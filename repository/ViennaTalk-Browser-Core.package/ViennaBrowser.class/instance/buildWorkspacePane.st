user interface
buildWorkspacePane
	^ (ViennaPluggableTextMorph
		on: self
		text: #workspace
		accept: #acceptWorkspace:
		readSelection: #workspaceSelection
		menu: #workspacePaneMenu:shifted:
		setSelection: #workspaceSelection:)
		setBalloonText: 'workspace';
		askBeforeDiscardingEdits: true;
		bindKeyCombination: $d command toAction: [ self doItIn: workspacePane ];
		bindKeyCombination: $p command toAction: [ self printItIn: workspacePane ];
		font: ViennaLauncher font;
		yourself