toolbuilder
buildModuleListWith: builder

	| listSpec |
	listSpec := builder pluggableListSpec new.
	listSpec 
		model: self;
		list: #moduleList; 
		getIndex: #moduleSelectionIndex; 
		setIndex: #moduleSelectionIndex:; 
		menu: #moduleListMenu:; 
		dragItem: #dragFromModuleList:;
		dropItem: #dropOnModuleList:at:;
		keyPress: #inspectorKey:from:.
	^listSpec