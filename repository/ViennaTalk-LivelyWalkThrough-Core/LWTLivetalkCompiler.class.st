Class {
	#name : #LWTLivetalkCompiler,
	#superclass : #Object,
	#instVars : [
		'parser',
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
	#category : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #compiling }
LWTLivetalkCompiler >> compileToSmalltalk: aString ifError: errorBlock [
	| sourceStream |
	sourceStream := aString readStream asPetitStream.
	^ parser parse: sourceStream onError: [ :msg :position | errorBlock cull: msg cull: position ]
]

{ #category : #'initialize-release' }
LWTLivetalkCompiler >> initialize [
	| quote escapes |
	super initialize.
	quote := $" asParser.
	escapes := Dictionary new
		at: $n put: Character cr;
		at: $t put: Character tab;
		yourself.
	stringLiteral := (quote
		,
			((quote not
				,
					((($\ asParser , #any asParser) ==> [ :pair | escapes at: pair second ifAbsent: [ pair second ] ]) / #any asParser))
				==> [ :pair | pair second ]) star , quote) ==> [ :triple | String withAll: triple second ].
	identifier := (#letter asParser / $` asParser / $_ asParser
		, (#letter asParser / $` asParser / $_ asParser / #digit asParser) star) flatten.
	morphName := ($[ asParser , (($] asParser not , #any asParser) ==> [ :pair | pair second ]) star flatten , $] asParser)
		==> [ :args | args second ].
	actionName := ($< asParser , identifier , $> asParser) ==> [ :args | args second ].
	vdmcall := PPUnresolvedParser new.
	expression := PPUnresolvedParser new.
	vdmcall
		def:
			(identifier , $( asParser trim
				,
					((expression , (($, asParser trim , expression) ==> [ :args | args second ]) star)
						==> [ :args | (Array with: args first) , args second ]) optional , $) asParser trim)
				==> [ :args | Array with: args first with: args third ].
	expression
		def:
			(stringLiteral ==> [ :str | str storeString ])
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
	arrow := (expression , '->' asParser trim , morphName)
		==> [ :args | 
			| stream |
			stream := String new writeStream.
			stream nextPutAll: 'self execLet: ('.
			args third storeOn: stream.
			stream nextPutAll: ') be: ('.
			stream nextPutAll: args first.
			stream nextPutAll: ')'.
			stream contents ].
	dialog := ($! asParser trim , expression) ==> [ :pair | 'self execDialog: (' , pair second , ')' ].
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