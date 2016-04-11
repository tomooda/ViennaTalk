code generation-interfaces
importDefinition: aViennaNode env: aDictionary
	| moduleName importModuleSignatureNode |
	moduleName := aViennaNode first.
	importModuleSignatureNode := aViennaNode second.
	importModuleSignatureNode do: [ :node | self generate: node env: aDictionary ]