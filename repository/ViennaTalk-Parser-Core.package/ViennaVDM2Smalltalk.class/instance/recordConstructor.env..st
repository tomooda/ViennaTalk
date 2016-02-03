code generation-expressions
recordConstructor: aViennaNode env: aDictionary
	| constructorName args |
	constructorName := self generate: aViennaNode first env: aDictionary.
	args := '{', (' . ' join: (self generate: aViennaNode second env: aDictionary)), '}'.
	^ '(' , constructorName , ' applyTo: ' , args , ')'