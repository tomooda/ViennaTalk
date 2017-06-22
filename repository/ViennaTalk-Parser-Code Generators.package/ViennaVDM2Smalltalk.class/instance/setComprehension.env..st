code generation-expressions
setComprehension: aViennaNode env: aDictionary
	| expr bindListNode guard varGenerator set pair setsAndVars flatBinds |
	expr := self generate: aViennaNode first env: aDictionary.
	bindListNode := aViennaNode second.
	guard := self generate: aViennaNode third env: aDictionary.
	varGenerator := self
		varNameGenerator: 'set'
		uniqueIn: (Array with: expr) , (Array with: (guard ifNil: [ '' ])).
	set := varGenerator value.
	pair := self
		flattenBindList: bindListNode
		varGenerator: varGenerator
		env: aDictionary.
	flatBinds := pair first.
	setsAndVars := pair second.
	^ self
		stringStreamContents: [ :stream | 
			| body |
			body := set , ' add: ' , expr.
			guard ifNotNil: [ body := guard , ' ifTrue: [' , body , ']' ].
			stream nextPutAll: '(['.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' :';
						nextPutAll: setAndVar second ].
			stream
				nextPutAll: ' | | ' , set , ' | ' , set , ' :=Set new.';
				nextPutAll:
					(self
						generatorFromFlatBinds: flatBinds
						body: body
						varGenerator: varGenerator
						env: aDictionary);
				nextPutAll: '. ';
				nextPutAll: set;
				nextPutAll: ']'.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' value: ';
						nextPutAll: setAndVar first ].
			stream nextPut: $) ]