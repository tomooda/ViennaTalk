parsers-expressions-basics
mapComprehension
	^ super mapComprehension
		==> [ :quatro | 
			Array
				new: 1024
				streamContents: [ :stream | 
					stream nextPutAll: '[|map|map:=Dictionary new.'.
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
						nextPutAll: 'map at: ';
						nextPutAll: quatro first;
						nextPutAll: ' put: ';
						nextPutAll: quatro second.
					quatro fourth ifNotNil: [ stream nextPut: $] ].
					quatro third do: [ :_multibind | _multibind first do: [ :_var | stream nextPut: $] ] ].
					stream nextPutAll: '. map] value' ] ]