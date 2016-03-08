code generation-definitions
importFunctionsSignature: aViennaNode env: aDictionary module: aString
	aViennaNode do: [ :node | self generate: node env: aDictionary module: aString ]