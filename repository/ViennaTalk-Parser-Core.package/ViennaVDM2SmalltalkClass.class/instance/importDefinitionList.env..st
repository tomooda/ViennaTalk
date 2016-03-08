code generation-definitions
importDefinitionList: aViennaNode env: aDictionary
	aViennaNode do: [ :node | self generate: node env: aDictionary ]