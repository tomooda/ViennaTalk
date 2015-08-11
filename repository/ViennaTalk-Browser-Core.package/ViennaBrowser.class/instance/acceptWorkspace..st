workspace pane
acceptWorkspace: aStringOrText
	| oldWorkspace |
	oldWorkspace := workspace.
	workspace := aStringOrText.
	oldWorkspace ~= workspace ifTrue: [ self changed: #workspace ]