code generation-definitions
operationDefinitions: aViennaNode env: aDictionary
	aViennaNode do: [ :node | self generate: node env: aDictionary ]