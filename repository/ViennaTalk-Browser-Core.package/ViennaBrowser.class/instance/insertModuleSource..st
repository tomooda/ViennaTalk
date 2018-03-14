code pane menu
insertModuleSource: moduleName
	| section moduleSource editor |
	section := ((self modulePositionsFrom: animation specification)
		detect: [ :assoc | assoc key = moduleName ]
		ifNone: [ String new ]) value.
	moduleSource := (animation specification copyFrom: section first to: section last) asText
		makeAllColor: Color black.
	codePane highlight.
	editor := codePane textMorph editor.
	editor replaceSelectionWith: moduleSource.
	editor
		selectInterval: (editor selectionInterval first to: editor selectionInterval first + moduleSource size - 1)