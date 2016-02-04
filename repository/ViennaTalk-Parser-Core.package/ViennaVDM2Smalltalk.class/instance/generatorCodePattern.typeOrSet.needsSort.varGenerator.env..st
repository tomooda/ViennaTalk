utilities
generatorCodePattern: patternNode typeOrSet: typeOrSetNode needsSort: aBoolean varGenerator: aVarGeneratorBlock env: aDictionary
	| tmpVar vars pattern typeOrSet |
	typeOrSet := typeOrSetNode label = 'SetRangeExpression'
		ifTrue: [ self intervalExpression: typeOrSetNode env: aDictionary ]
		ifFalse: [ self generate: typeOrSetNode env: aDictionary ].
	patternNode label = 'PatternIdentifier'
		ifTrue: [ ^ typeOrSet , ' do: [:' , patternNode first , '|' ].
	tmpVar := aVarGeneratorBlock value.
	vars := (self boundVariables: patternNode) asArray.
	pattern := self generate: patternNode env: aDictionary.
	aBoolean
		ifTrue: [ typeOrSet := typeOrSet , ' asSortedCollection' ].
	^ typeOrSet , ' do: [:' , tmpVar , ' || ' , (' ' join: vars) , ' | ' , (self binder: pattern with: tmpVar vars: vars)
		, ' ifFalse: [ViennaNoMatch signal].'