code generation-expressions
tokenConstructor: aViennaNode env: aDictionary
	^ '(ViennaToken with: ' , (self generate: aViennaNode first env: aDictionary) , ')'