user interface
buildFilePane
	| pane |
	pane := Morph new.
	pane
		color: Color white;
		changeTableLayout;
		listDirection: #topToBottom;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		listCentering: #topLeft;
		wrapCentering: #topLeft.
	pane
		addMorphBack:
			(PluggableButtonMorph new
				label: 'Load...';
				actionBlock: [ self director load ];
				hResizing: #spaceFill;
				listCentering: #topLeft;
				yourself).
	pane
		addMorphBack:
			(PluggableButtonMorph new
				label: 'Save...';
				actionBlock: [ self director save ];
				hResizing: #spaceFill;
				listCentering: #topLeft;
				yourself).
	pane
		addMorphBack:
			(PluggableButtonMorph new
				label: 'Save As...';
				actionBlock: [ self director saveAs ];
				hResizing: #spaceFill;
				listCentering: #topLeft;
				yourself).
	^ pane