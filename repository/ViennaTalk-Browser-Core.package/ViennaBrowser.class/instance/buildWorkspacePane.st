user interface
buildWorkspacePane
	^ (ViennaPluggableTextMorph
		on: self
		text: #workspace
		accept: #acceptWorkspace:
		readSelection: #workspaceSelection
		menu: #workspacePaneMenu:shifted:
		setSelection: #workspaceSelection:)
		askBeforeDiscardingEdits: true;
		yourself