code generation-expressions
setComprehension: aViennaNode env: aDictionary
	| expr binds guard varGenerator set |
	expr := self generate: aViennaNode first env: aDictionary.
	binds := self generate: aViennaNode second env: aDictionary.
	guard := self generate: aViennaNode third env: aDictionary.
	varGenerator := self
		varNameGenerator: 'set'
		uniqueIn: (Array with: expr) , (binds collect: #second) , (Array with: (guard ifNil: [ '' ])).
	set := varGenerator value.
	^ String
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
				nextPutAll: '] value' ]