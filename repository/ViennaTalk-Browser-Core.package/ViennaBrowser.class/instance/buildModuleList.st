user interface
buildModuleList
	^ PluggableListMorph
		on: self
		list: #moduleList
		selected: #moduleSelectionIndex
		changeSelected: #moduleSelectionIndex:
		menu: #moduleListMenu: