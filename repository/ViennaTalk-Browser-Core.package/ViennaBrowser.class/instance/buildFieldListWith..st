toolbuilder
buildFieldListWith: builder 
	| listSpec |
	listSpec := builder pluggableListSpec new.
	listSpec model: self;
	      name: #fieldListPane;
		 list: #fieldList;
		 getIndex: #fieldSelectionIndex;
		 setIndex: #fieldSelectionIndex:;
		 menu: #fieldListMenu:;
		 dragItem: #dragFromFieldList:;
		 dropItem: #dropOnFieldList:at:;
		 keyPress: #inspectorKey:from:.
	^ listSpec