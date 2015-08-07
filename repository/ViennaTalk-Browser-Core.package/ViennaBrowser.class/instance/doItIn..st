private
doItIn: aPluggableTextMorph 
	valuePane
		handleEdit: [| editor error |
			editor := aPluggableTextMorph textMorph editor.
			editor
				lineSelectAndEmptyCheck: [^ nil].
			error := nil.
			self
				evaluate: editor selectionAsStream upToEnd
				ifError: [:msg | error := msg].
			error
				ifNotNil: [| selectionInterval |
					selectionInterval := editor selectionInterval.
					aPluggableTextMorph textMorph installEditorToReplace: editor.
					aPluggableTextMorph textMorph
						handleEdit: [editor afterSelectionInsertAndSelect: error].
					selectionInterval := editor selectionInterval.
					aPluggableTextMorph textMorph editor selectFrom: selectionInterval first to: selectionInterval last.
					aPluggableTextMorph scrollSelectionIntoView]]