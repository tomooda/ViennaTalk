code generation-definitions
valueDefinitions: aViennaNode env: aDictionary
	aViennaNode do: [ :node | self generate: node env: aDictionary ]