code generation-interfaces
functionImport: aViennaNode env: aDictionary
	| moduleName |
	moduleName := (aViennaNode parentLabelled: 'ImportDefinition' ifAbsent: [ nil ])
		ifNotNil: [ :importDefinition | importDefinition first ]
		ifNil: [ ^ self error: 'Malformed AST: FunctionImport must appear under ImportDefinition' ].
	aViennaNode fourth
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: moduleName , String space , aViennaNode first first ]