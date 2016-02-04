code generation-expressions
mapComprehension: aViennaNode env: aDictionary
	| keyExpr valueExpr guard varGenerator map |
	keyExpr := self generate: aViennaNode first env: aDictionary.
	valueExpr := self generate: aViennaNode second env: aDictionary.
	guard := self generate: aViennaNode fourth env: aDictionary.
	varGenerator := self
		varNameGenerator: 'map'
		uniqueIn:
			{keyExpr.
			valueExpr} , {(guard ifNil: [ '' ])}.
	map := varGenerator value.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: '[ | ' , map , ' | ' , map , ' :=Dictionary new.'.
			self
				generatorCodeBindList: aViennaNode third
				varGenerator: varGenerator
				env: aDictionary
				do: [ :generatorScript | stream nextPutAll: generatorScript ].
			guard
				ifNotNil: [ 
					stream
						nextPutAll: guard;
						nextPutAll: ' ifTrue: [' ].
			stream
				nextPutAll: map;
				nextPutAll: ' at: ';
				nextPutAll: keyExpr;
				nextPutAll: ' put: ';
				nextPutAll: valueExpr.
			guard ifNotNil: [ stream nextPut: $] ].
			aViennaNode third do: [ :multiBindNode | multiBindNode first do: [ :patternNode | stream nextPut: $] ] ].
			stream
				nextPut: $.;
				nextPutAll: map;
				nextPutAll: '] value' ]