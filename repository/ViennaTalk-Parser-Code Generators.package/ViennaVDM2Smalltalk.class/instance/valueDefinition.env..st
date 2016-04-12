code generation-definitions
valueDefinition: aViennaNode env: aDictionary
	| patternNode pattern body binder |
	patternNode := aViennaNode first.
	pattern := self generate: patternNode env: aDictionary.
	body := self generate: aViennaNode third env: aDictionary.
	^ patternNode label = 'PatternIdentifier'
		ifTrue: [ patternNode first ifNotNil: [ '(' , patternNode first , ' := ' , body , ')' ] ifNil: [ body ] ]
		ifFalse: [ 
			binder := self binder: pattern with: body vars: (self boundVariables: aViennaNode first) asArray.
			'(' , binder , '  ifFalse: [ViennaNoMatch signal])' ]