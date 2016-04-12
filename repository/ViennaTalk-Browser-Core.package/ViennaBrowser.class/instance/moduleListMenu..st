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
	aMenu add: 'generate a Smalltalk script (single module)...' translated selector: #generateSmalltalkScript.
	aMenu add: 'generate classes (all modules)...' translated selector: #generateSmalltalkClasses.
	aMenu add: 'generate object (all modules)...' translated selector: #generateSmalltalkObject.
	referenceSubMenu := MenuMorph new defaultTarget: self.
	self importerModules do: [ :name | referenceSubMenu add: name selector: #selectModuleNamed: argument: name ].
	referenceSubMenu hasItems
		ifTrue: [ 
			aMenu
				addLine;
				add: 'imported by...' translated subMenu: referenceSubMenu ].
	^ aMenu