toolbuilder
buildCodePaneWith: builder
	| textSpec |
	textSpec := builder pluggableTextSpec new.
	textSpec 
		model: self;
		name: #codePane;
		getText: #code; 
		setText: #code:notifying:; 
		selection: #contentsSelection; 
		menu: #codePaneMenu:shifted:;
		askBeforeDiscardingEdits: true.
	^textSpec