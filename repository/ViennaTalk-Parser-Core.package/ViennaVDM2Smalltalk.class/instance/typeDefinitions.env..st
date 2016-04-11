code generation-definitions
typeDefinitions: aViennaNode env: aDictionary
	aViennaNode do: [ :node | self generate: node env: aDictionary ]