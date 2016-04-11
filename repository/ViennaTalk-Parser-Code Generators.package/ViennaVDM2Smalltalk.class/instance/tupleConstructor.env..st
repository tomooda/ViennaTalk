code generation-expressions
tupleConstructor: aViennaNode env: aDictionary
	^ '{' , (' . ' join: (self generate: aViennaNode first env: aDictionary)) , '} '