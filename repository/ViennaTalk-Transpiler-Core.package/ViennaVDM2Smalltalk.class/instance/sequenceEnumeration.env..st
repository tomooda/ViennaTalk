code generation-expressions
sequenceEnumeration: aViennaNode env: aDictionary
	^ '{' , (' . ' join: (self generate: aViennaNode first env: aDictionary)) , '} asOrderedCollection'