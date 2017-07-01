code generation-types
unionType: aViennaNode env: aDictionary
	^ '(' , ('|' join: (self generateAll: aViennaNode env: aDictionary)) , ')'