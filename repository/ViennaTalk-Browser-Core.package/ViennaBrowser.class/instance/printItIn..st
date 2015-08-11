private
printItIn: aPluggableTextMorph 
	aPluggableTextMorph
		handleEdit: [| editor result selectionInterval |
			editor := aPluggableTextMorph textMorph editor.
			editor
				lineSelectAndEmptyCheck: [^ nil].
			result := self evaluate: editor selectionAsStream upToEnd.
			selectionInterval := editor selectionInterval.
			aPluggableTextMorph textMorph installEditorToReplace: editor.
			aPluggableTextMorph textMorph
				handleEdit: [editor afterSelectionInsertAndSelect: result].
			selectionInterval := editor selectionInterval.
			aPluggableTextMorph textMorph editor selectFrom: selectionInterval first to: selectionInterval last.
			aPluggableTextMorph scrollSelectionIntoView.
			self changed: #value]