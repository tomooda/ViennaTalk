user interface
okToChange
	^ (codePane canDiscardEdits and: [ workspacePane canDiscardEdits ]) or: [ UIManager default confirm: 'Has unsaved changes.
Do you want to discard it to close?' ]