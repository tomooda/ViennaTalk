user interface
buildFieldList
	^ (PluggableListMorph
		on: self
		list: #fieldList
		selected: #fieldSelectionIndex
		changeSelected: #fieldSelectionIndex:
		menu: nil)
		font: ViennaLauncher font;
		yourself