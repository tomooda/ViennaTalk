code generation-types
productType: aViennaNode env: aDictionary
	^ '(' , ('*' join: (self generateAll: aViennaNode env: aDictionary)) , ')'