user interface
buildSettingsPane
	| pane urlPrefixPane animationPane |
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
	(Smalltalk includesKey: #ViennaTranspiledAnimation)
		ifTrue: [ animationPane := Morph new.
			animationPane
				color: Color white;
				changeTableLayout;
				listDirection: #leftToRight;
				hResizing: #spaceFill;
				vResizing: #shrinkWrap.
			animationPane
				addMorphBack:
					((CheckboxMorph
						on: self director
						selected: #usesTranspiler
						changeSelected: #usesTranspiler:)
						label: 'use transpiler';
						yourself).
			pane addMorphBack: animationPane ].
	^ pane