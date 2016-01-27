code generation-expressions
recordConstructor: aViennaNode env: aDictionary
	| constructorName args |
	constructorName := self generate: aViennaNode first env: aDictionary.
	args := self generate: aViennaNode second env: aDictionary.
	^ '(ViennaComposite constructorName: ' , constructorName storeString , ' withAll: {' , (' . ' join: args) , '})'