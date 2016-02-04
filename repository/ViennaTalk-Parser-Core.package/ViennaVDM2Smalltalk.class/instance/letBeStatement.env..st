code generation-statements
letBeStatement: aViennaNode env: aDictionary
	| multibind guard statement varGenerator |
	multibind := self generate: aViennaNode first env: aDictionary.
	guard := self generate: aViennaNode second env: aDictionary.
	statement := self generate: aViennaNode third env: aDictionary.
	varGenerator := self varNameGenerator: 'letbe' uniqueIn: (Array with: multibind second with: guard with: statement).
	^ String
		new: 1024
		streamContents: [ :stream | 
			| patterns set vars |
			patterns := multibind first.
			set := multibind second.
			vars := (self boundVariables: aViennaNode first) asArray.
			stream
				nextPutAll: '[|';
				nextPutAll: (' ' join: vars);
				nextPutAll: '|('.
			patterns
				with: aViennaNode first first asArray
				do: [ :pat :patternNode | 
					| loopVar |
					loopVar := varGenerator value.
					stream
						nextPutAll: set;
						nextPutAll: ' anySatisfy: [:';
						nextPutAll: loopVar;
						nextPutAll: '|';
						nextPutAll: (self binder: pat with: loopVar vars: (self boundVariables: patternNode) asArray);
						nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
			stream nextPutAll: guard.
			multibind first do: [ :pat | stream nextPut: $] ].
			stream
				nextPutAll: ') ifFalse: [NotFound signal].';
				nextPutAll: statement;
				nextPutAll: '] value' ]