user interface
buildFieldList
	^ PluggableListMorph
		on: self
		list: #fieldList
		selected: #fieldSelectionIndex
		changeSelected: #fieldSelectionIndex:
		menu: #fieldListMenu: