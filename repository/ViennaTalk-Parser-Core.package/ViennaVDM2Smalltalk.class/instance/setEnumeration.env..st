code generation-expressions
setEnumeration: aViennaNode env: aDictionary
	^ '{' , (' . ' join: (self generate: aViennaNode first env: aDictionary)) , '} asSet'