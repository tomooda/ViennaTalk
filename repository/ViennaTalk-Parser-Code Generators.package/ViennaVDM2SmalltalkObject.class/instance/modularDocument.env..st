code generation-definitions
modularDocument: aViennaNode env: aDictionary
	| objects |
	aViennaNode do: [ :node | self generate: node env: aDictionary ].
	objects := classes collect: [ :moduleClass | moduleClass new ].
	aViennaNode
		do: [ :moduleNode | 
			| moduleName moduleObject |
			moduleName := moduleNode first.
			moduleObject := objects at: moduleName.
			moduleNode second first
				ifNotNil: [ :importDefinitionListNode | 
					importDefinitionListNode
						do: [ :importDefinitionNode | 
							| importedModuleName importedModuleObject |
							importedModuleName := importDefinitionNode first.
							importedModuleObject := objects at: importedModuleName.
							moduleObject perform: (importedModuleName , ':') asSymbol with: importedModuleObject ] ] ].
	objects valuesDo: [ :moduleObject | moduleObject init ].
	^ objects