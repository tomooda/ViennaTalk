code generation-definitions
typeImport: aViennaNode env: aDictionary module: aString
	aViennaNode second
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: aString , String space , aViennaNode first first ]