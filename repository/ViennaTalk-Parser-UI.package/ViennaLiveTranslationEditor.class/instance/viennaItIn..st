evaluating
viennaItIn: aTextModel
	| parser codeFromSource editor ast codeFromSelection result |
	parser := ViennaVDMParser new.
	codeFromSource := targetText text asString.
	editor := aTextModel widget widget textMorph editor.
	editor lineSelectAndEmptyCheck: [ ^ '' ].
	ast :=parser expression end / parser statement end / parser type end
		parse: (aTextModel text asString copyFrom: editor startIndex to: editor stopIndex - 1) trim.
	ast isPetitFailure
		ifTrue: [ ^ aTextModel notify: ast message at: ast position + 1 in: aTextModel text ].
	codeFromSelection := ViennaVDM2SmalltalkScript new generate: ast.
	result := (Compiler evaluate: codeFromSource , '.' , codeFromSelection) viennaString.
	editor afterSelectionInsertAndSelect: result.
	aTextModel widget widget
		selectFrom: editor startIndex to: editor stopIndex - 1;
		textChanged;
		scrollSelectionIntoView.
	^ true