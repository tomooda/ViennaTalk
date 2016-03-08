code generation-definitions
functionDefinitions: aViennaNode env: aDictionary
	^ '.' , String cr join: (aViennaNode collect: [ :node | self generate: node env: aDictionary ])