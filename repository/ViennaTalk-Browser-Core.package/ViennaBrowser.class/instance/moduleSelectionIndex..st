module list
moduleSelectionIndex: anInteger 
	^ self
		selectModuleNamed: (self moduleList
				at: anInteger
				ifAbsent: [])