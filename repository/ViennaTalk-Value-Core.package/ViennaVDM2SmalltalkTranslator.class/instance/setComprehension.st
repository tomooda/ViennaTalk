parsers-expressions-basics
setComprehension
	^ super setComprehension
		==> [ :triple | 
			Array
				new: 1024
				streamContents: [ :stream | 
					stream nextPutAll: '[|set|set:=Set new.'.
					triple second
						do: [ :_multibind | 
							_multibind first
								do: [ :_var | 
									stream
										nextPutAll: _multibind second;
										nextPutAll: ' do: [:';
										nextPutAll: _var;
										nextPut: $| ] ].
					triple third
						ifNotNil: [ :cond | 
							stream
								nextPutAll: cond;
								nextPutAll: ' ifTrue: [' ].
					stream
						nextPutAll: 'set add: ';
						nextPutAll: triple first.
					triple third ifNotNil: [ stream nextPut: $] ].
					triple second do: [ :_multibind | _multibind first do: [ :_var | stream nextPut: $] ] ].
					stream nextPutAll: '. set] value' ] ]