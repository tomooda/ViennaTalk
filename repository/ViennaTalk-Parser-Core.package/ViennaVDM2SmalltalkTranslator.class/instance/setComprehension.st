parsers-expressions-basics
setComprehension
	^ super setComprehension
		==> [ :triple | 
			| expr binds guard varGenerator set |
			expr := triple first.
			binds := triple second.
			guard := triple third.
			varGenerator := self
				varNameGenerator: 'set'
				uniqueIn: (Array with: expr) , (binds collect: #second) , (Array with: (guard ifNil: [ '' ])).
			set := varGenerator value.
			String
				new: 1024
				streamContents: [ :stream | 
					stream nextPutAll: '[ | ' , set , ' | ' , set , ' :=Set new.'.
					self
						generatorCodeFromBindList: binds
						varGenerator: varGenerator
						do: [ :generatorScript | stream nextPutAll: generatorScript ].
					guard
						ifNotNil: [ 
							stream
								nextPutAll: guard;
								nextPutAll: ' ifTrue: [' ].
					stream
						nextPutAll: set;
						nextPutAll: ' add: ';
						nextPutAll: expr.
					guard ifNotNil: [ stream nextPut: $] ].
					self generatorCodeFromBindList: binds varGenerator: varGenerator do: [ :generatorScript | stream nextPut: $] ].
					stream
						nextPut: $.;
						nextPutAll: set;
						nextPutAll: '] value' ] ]