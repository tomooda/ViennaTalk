code generation-types
optionalType: aViennaNode env: aDictionary
	| baseType |
	baseType := self generate: aViennaNode first env: aDictionary.
	^ baseType , ' optional'