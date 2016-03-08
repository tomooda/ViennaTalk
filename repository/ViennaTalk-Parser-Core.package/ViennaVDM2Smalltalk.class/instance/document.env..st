code generation-definitions
document: aViennaNode env: aDictionary
	^ aViennaNode first label = 'DefinitionBlock'
		ifTrue: [ self flatDocument: aViennaNode env: aDictionary ]
		ifFalse: [ self modularDocument: aViennaNode env: aDictionary ]