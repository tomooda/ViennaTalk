initialize-release
initialize
	| quote nat int decimal escapes |
	super initialize.
	quote := $" asParser.
	escapes := Dictionary new
		at: $n put: Character cr;
		at: $t put: Character tab;
		yourself.
	nat := ((1 to: 9) inject: $0 asParser into: [ :p :digit | p / digit asCharacterDigit asParser ]) plus flatten.
	int := $- asParser optional , nat.
	decimal := int , ($. asParser , nat) optional.
	numberLiteral := (decimal , ($e asParser / $E asParser , decimal) optional) flatten trim ==> [ :str | str trim ].
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