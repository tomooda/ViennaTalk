code generation-expressions
existsExpression: aViennaNode env: aDictionary
	| bindListNode expr varGenerator pair flatBinds setsAndVars |
	bindListNode := aViennaNode first.
	expr := self generate: aViennaNode second env: aDictionary.
	varGenerator := self
		varNameGenerator: 'exists'
		uniqueIn: (Array with: expr).
	pair := self
		flattenBindList: bindListNode
		varGenerator: varGenerator
		env: aDictionary.
	flatBinds := pair first.
	setsAndVars := pair second.
	^ self
		stringStreamContents: [ :stream | 
			stream nextPutAll: '(['.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' :';
						nextPutAll: setAndVar second ].
			stream
				nextPutAll: ' | ';
				nextPutAll:
					(self
						generatorFromFlatBinds: flatBinds
						selector: #anySatisfy:
						whenMatchFailed: 'false'
						body: expr
						varGenerator: varGenerator
						env: aDictionary);
				nextPutAll: ']'.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' value: ';
						nextPutAll: setAndVar first ].
			stream nextPut: $) ]