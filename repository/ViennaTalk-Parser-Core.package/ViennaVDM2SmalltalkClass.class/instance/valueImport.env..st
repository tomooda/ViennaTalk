code generation-interfaces
valueImport: aViennaNode env: aDictionary
	| moduleName |
	moduleName := (aViennaNode parentLabelled: 'ImportDefinition' ifAbsent: [ nil ])
		ifNotNil: [ :importDefinition | importDefinition first ]
		ifNil: [ ^ self error: 'Malformed AST: ValueImport must appear under ImportDefinition' ].
	aViennaNode third
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: moduleName , String space , aViennaNode first first ]