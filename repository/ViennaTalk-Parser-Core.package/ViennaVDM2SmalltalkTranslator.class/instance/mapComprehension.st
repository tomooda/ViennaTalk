parsers-expressions-basics
mapComprehension
	^ super mapComprehension
		==> [ :quatro | 
			String
				new: 1024
				streamContents: [ :stream | 
					| map |
					map := '_map'.
					[ 
					(quatro first findString: map) > 0
						or: [ 
							(quatro second findString: map) > 0
								or: [ 
									(quatro third contains: [ :_multibind | (_multibind second findString: map) > 0 ])
										or: [ quatro fourth notNil and: [ (quatro fourth findString: map) > 0 ] ] ] ] ]
						whileTrue: [ map := map , '_' ].
					stream nextPutAll: '[ | ' , map , ' | ' , map , ' := Dictionary new.'.
					quatro third
						do: [ :_multibind | 
							_multibind first
								do: [ :_var | 
									stream
										nextPutAll: _multibind second;
										nextPutAll: ' do: [:';
										nextPutAll: _var;
										nextPut: $| ] ].
					quatro fourth
						ifNotNil: [ :cond | 
							stream
								nextPutAll: cond;
								nextPutAll: ' ifTrue: [' ].
					stream
						nextPutAll: map , ' at: ';
						nextPutAll: quatro first;
						nextPutAll: ' put: ';
						nextPutAll: quatro second.
					quatro fourth ifNotNil: [ stream nextPut: $] ].
					quatro third do: [ :_multibind | _multibind first do: [ :_var | stream nextPut: $] ] ].
					stream nextPutAll: '. ' , map , '] value' ] ]