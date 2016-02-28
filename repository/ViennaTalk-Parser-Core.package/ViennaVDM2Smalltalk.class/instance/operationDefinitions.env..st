code generation-definitions
operationDefinitions: aViennaNode env: aDictionary
	^ '.' , String cr join: (aViennaNode collect: [ :node | self generate: node env: aDictionary ])