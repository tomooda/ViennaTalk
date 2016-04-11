code generation-statements
dclStatement: aViennaNode env: aDictionary
	^ '. ' join: (self generateAll: aViennaNode env: aDictionary)