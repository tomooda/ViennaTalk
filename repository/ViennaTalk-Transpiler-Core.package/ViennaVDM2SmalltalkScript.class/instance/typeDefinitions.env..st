code generation-definitions
typeDefinitions: aViennaNode env: aDictionary
	^ '.' , String cr
		join: ((self reorderDefinitions: aViennaNode) collect: [ :node | self generate: node env: aDictionary ])