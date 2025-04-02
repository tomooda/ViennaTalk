Class {
	#name : 'LWTLivetalkCompiler',
	#superclass : 'Object',
	#instVars : [
		'parser',
		'numberLiteral',
		'stringLiteral',
		'identifier',
		'morphName',
		'actionName',
		'vdmcall',
		'expression',
		'arrow',
		'dialog',
		'step'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core',
	#package : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : 'compiling' }
LWTLivetalkCompiler >> compileToSmalltalk: aString ifError: errorBlock [
	| sourceStream |
	sourceStream := aString readStream asPetit2Stream.
	^ parser parse: sourceStream onError: [ :msg :position | errorBlock cull: msg cull: position ]
]

{ #category : 'initialize-release' }
LWTLivetalkCompiler >> initialize [
	| quote nat int decimal escapes |
	super initialize.
	quote := $" asPParser.
	escapes := Dictionary new
		at: $n put: Character cr;
		at: $t put: Character tab;
		yourself.
	nat := ((1 to: 9) inject: $0 asPParser into: [ :p :digit | p / digit asCharacterDigit asPParser ]) plusA flatten.
	int := $- asPParser optional , nat.
	decimal := int , ($. asPParser , nat) optional.
	numberLiteral := (decimal , ($e asPParser / $E asPParser , decimal) optional) flatten trim
		==> [ :str |  ' ', str trim, ' ' ].
	stringLiteral := (quote
		,
			((quote not
				,
					((($\ asPParser , #any asPParser) ==> [ :pair | escapes at: pair second ifAbsent: [ pair second ] ]) / #any asPParser))
				==> [ :pair | pair second ]) star , quote) ==> [ :triple | (String withAll: triple second) viennaString ].
	identifier := (#letter asPParser / $` asPParser / $_ asPParser
		, (#letter asPParser / $` asPParser / $_ asPParser / #digit asPParser) star) flatten.
	morphName := ($[ asPParser , (($] asPParser not , #any asPParser) ==> [ :pair | pair second ]) star flatten , $] asPParser)
		==> [ :args | args second ].
	actionName := ($< asPParser , identifier , $> asPParser) ==> [ :args | args second ].
	vdmcall := PP2UnresolvedNode new.
	expression := PP2UnresolvedNode new.
	vdmcall
		def:
			(identifier , $( asPParser trim
				,
					((expression , (($, asPParser trim , expression) ==> [ :args | args second ]) star)
						==> [ :args | (Array with: args first) , args second ]) optional , $) asPParser trim)
				==> [ :args | Array with: args first with: args third ].
	expression
		def:
			(stringLiteral ==> [ :str | str storeString ]) / numberLiteral
				/ (morphName ==> [ :name | 'self execValueOf: (' , name storeString , ')' ])
				/
					(vdmcall
						==> [ :pair | 
							| stream |
							stream := String new writeStream.
							stream nextPutAll: 'self execVDM: '.
							pair first storeOn: stream.
							stream nextPutAll: 'withArguments: {'.
							pair second
								ifNotNil: [ 
									pair second
										do: [ :arg | 
											stream
												nextPut: $(;
												nextPutAll: arg;
												nextPut: $) ]
										separatedBy: [ stream nextPut: $. ] ].
							stream nextPut: $}.
							stream contents ]).
	arrow := (expression , '->' asPParser trim , morphName)
		==> [ :args | 
			| stream |
			stream := String new writeStream.
			stream nextPutAll: 'self execLet: ('.
			args third storeOn: stream.
			stream nextPutAll: ') be: ('.
			stream nextPutAll: args first.
			stream nextPutAll: ')'.
			stream contents ].
	dialog := ($! asPParser trim , expression) ==> [ :pair | 'self execDialog: (' , pair second , ')' ].
	step := (arrow / dialog / expression) trim.
	parser := step star end
		==> [ :exprs | 
			| stream |
			stream := String new writeStream.
			exprs
				do: [ :expr | 
					stream nextPutAll: expr.
					stream nextPutAll: '. ' ].
			stream contents ]
]
