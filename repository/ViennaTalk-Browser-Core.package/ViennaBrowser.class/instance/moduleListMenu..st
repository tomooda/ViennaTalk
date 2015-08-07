module list menu
moduleListMenu: aMenu 
	| referenceSubMenu |
	aMenu add: 'remove module' translated action: #removeModule.
	aMenu addLine.
	referenceSubMenu := MenuMorph new defaultTarget: self.
	self referringModules
		do: [:name | referenceSubMenu
				add: name
				selector: #selectModuleNamed:
				argument: name].
	referenceSubMenu hasItems
		ifTrue: [aMenu add: 'referring modules...' translated subMenu: referenceSubMenu].
	^ aMenu