user interface
buildSettingsPane
	| pane item |
	pane := Morph new.
	pane
		color: Color white;
		changeTableLayout;
		listDirection: #toToBottom.
	item := Morph new.
	item
		color: Color white;
		changeTableLayout;
		listDirection: #leftToRight;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
	item
		addMorphBack:
				(' name ' asMorph
						hResizing: #rigid;
						yourself);
		addMorphBack:
				((PluggableTextMorph on: self director text: #urlPrefix accept: #acceptUrlPrefix:)
						autoAccept: true;
						extent: 100 @ (TextStyle default defaultFont height * 2);
						hResizing: #spaceFill;
						yourself).
	pane addMorphBack: item.
	^ pane