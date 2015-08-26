module list menu
moduleListMenu: aMenu
	| referenceSubMenu |
	aMenu add: 'new and load...' translated selector: #newAndLoadFromFile.
	aMenu add: 'load and merge...' translated selector: #loadAndMergeFromFile.
	aMenu add: 'save all modules...' translated selector: #saveAllModulesToFile.
	self selectedModule ifNotNil: [ aMenu add: 'save the module...' translated selector: #saveAModuleToFile ].
	aMenu addLine.
	aMenu add: 'remove module' translated selector: #removeModule.
	aMenu addLine.
	referenceSubMenu := MenuMorph new defaultTarget: self.
	self importerModules do: [ :name | referenceSubMenu add: name selector: #selectModuleNamed: argument: name ].
	referenceSubMenu hasItems
		ifTrue: [ aMenu add: 'imported by...' translated subMenu: referenceSubMenu ].
	^ aMenu