code generation-definitions
operationImport: aViennaNode env: aDictionary module: aString
	aViennaNode third
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: aString , String space , aViennaNode first first ]