code generation-interfaces
typeImport: aViennaNode env: aDictionary
	| moduleName |
	moduleName := (aViennaNode parentLabelled: 'ImportDefinition' ifAbsent: [ nil ])
		ifNotNil: [ :importDefinition | importDefinition first ]
		ifNil: [ ^ self error: 'Malformed AST: TypeImport must appear under ImportDefinition' ].
	aViennaNode second
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: moduleName , String space , aViennaNode first first first ]