code generation-definitions
functionImport: aViennaNode env: aDictionary module: aString
	aViennaNode fourth
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: aString , String space , aViennaNode first first ]