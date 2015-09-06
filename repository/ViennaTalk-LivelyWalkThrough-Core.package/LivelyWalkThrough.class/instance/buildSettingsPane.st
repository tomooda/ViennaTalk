user interface
buildSettingsPane
	| pane urlPrefixPane |
	pane := Morph new.
	pane
		color: Color white;
		changeTableLayout;
		listDirection: #topToBottom.
	urlPrefixPane := Morph new.
	urlPrefixPane
		color: Color white;
		changeTableLayout;
		listDirection: #leftToRight;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
	urlPrefixPane
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
	pane addMorphBack: urlPrefixPane.
	^ pane