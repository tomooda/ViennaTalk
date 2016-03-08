evaluating
translateIt
	| parser editor ast codeFromSelection |
	parser := ViennaVDMParser new.
	editor := codeText widget widget textMorph editor.
	editor lineSelectAndEmptyCheck: [ ^ '' ].
	ast := parser expression end / parser statement end / parser type end
		parse: (codeText text asString copyFrom: editor startIndex to: editor stopIndex - 1) trim.
	ast isPetitFailure
		ifTrue: [ ^ codeText notify: ast message at: ast position + 1 in: codeText text ].
	codeFromSelection := ViennaVDM2SmalltalkScript new generate: ast.
	editor afterSelectionInsertAndSelect: codeFromSelection.
	codeText widget widget
		selectFrom: editor startIndex to: editor stopIndex;
		textChanged;
		scrollSelectionIntoView.
	^ true