toolbuilder
buildValuePaneWith: builder 
	| textSpec |
	textSpec := builder pluggableTextSpec new.
	textSpec model: self;
		 name: #valuePane;
		 getText: #contents;
		 setText: #accept:;
		 selection: #contentsSelection;
		 menu: #valuePaneMenu:shifted:.
	^ textSpec