module list menu
moduleListMenu: aMenu 
	| referenceSubMenu |
	aMenu add: 'remove module' translated selector: #removeModule.
	aMenu addLine.
	referenceSubMenu := MenuMorph new defaultTarget: self.
	self importerModules
		do: [:name | referenceSubMenu
				add: name
				selector: #selectModuleNamed:
				argument: name].
	referenceSubMenu hasItems
		ifTrue: [aMenu add: 'imported by...' translated subMenu: referenceSubMenu].
	^ aMenu