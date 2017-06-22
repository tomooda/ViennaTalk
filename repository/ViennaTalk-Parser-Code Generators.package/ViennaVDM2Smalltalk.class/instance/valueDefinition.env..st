code generation-definitions
valueDefinition: aViennaNode env: aDictionary
	| patternNode pattern patternType typeCheck body |
	patternNode := aViennaNode first.
	pattern := self generate: patternNode env: aDictionary.
	patternType := aViennaNode second
		ifNotNil: [ :typeNode | self generate: typeNode env: aDictionary ].
	typeCheck := runtimeTypeCheck = true and: [ patternType notNil ].
	body := self generate: aViennaNode third env: aDictionary.
	^ patternNode label = 'PatternIdentifier'
		ifTrue: [ patternNode first
				ifNotNil: [ self
						stringStreamContents: [ :stream | 
							stream
								nextPutAll: patternNode first;
								nextPutAll: ' := ';
								nextPutAll: body.
							typeCheck
								ifTrue: [ stream
										nextPutAll: '. ';
										nextPutAll: (self generateCheck: patternNode first type: patternType) ] ] ]
				ifNil: [ typeCheck
						ifTrue: [ self generateCheck: body type: patternType ]
						ifFalse: [ body ] ] ]
		ifFalse: [ | val |
			val := (self varNameGenerator: 'val' uniqueIn: {body}) value.
			self
				stringStreamContents: [ :stream | 
					stream
						nextPutAll: '(';
						nextPutAll: body;
						nextPutAll: ' in: [ :';
						nextPutAll: val;
						nextPutAll: ' | '.
					typeCheck
						ifTrue: [ stream nextPutAll: (self generateCheck: val type: patternType) ].
					stream
						nextPutAll:
							(self
								binder: pattern
								with: val
								vars: (self boundVariables: aViennaNode first) asArray);
						nextPutAll: ' ifFalse: [ViennaNoMatch signal]])' ] ]