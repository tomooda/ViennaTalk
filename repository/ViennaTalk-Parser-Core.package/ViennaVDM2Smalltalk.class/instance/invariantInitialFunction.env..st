code generation-types
invariantInitialFunction: aViennaNode env: aDictionary
	| patternNode expression varGenerator |
	patternNode := aViennaNode first.
	expression := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'inv' uniqueIn: {expression}.
	^ self
		closureFromFlatBinds: (Array with: (Array with: patternNode with: nil))
		body: expression
		varGenerator: varGenerator
		env: aDictionary