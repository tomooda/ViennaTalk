code generation-definitions
functionDefinitions: aViennaNode env: aDictionary
	aViennaNode do: [ :node | self generate: node env: aDictionary ]