code generation-expressions
setComprehension: aViennaNode env: aDictionary
	| expr bindListNode guard varGenerator set |
	expr := self generate: aViennaNode first env: aDictionary.
	bindListNode := aViennaNode second.
	guard := self generate: aViennaNode third env: aDictionary.
	varGenerator := self varNameGenerator: 'set' uniqueIn: (Array with: expr) , (Array with: (guard ifNil: [ '' ])).
	set := varGenerator value.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: '[ | ' , set , ' | ' , set , ' :=Set new.'.
			self
				generatorCodeBindList: bindListNode
				varGenerator: varGenerator
				env: aDictionary
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
			bindListNode do: [ :multiBindNode | multiBindNode first do: [ :generatorScript | stream nextPut: $] ] ].
			stream
				nextPut: $.;
				nextPutAll: set;
				nextPutAll: '] value' ]