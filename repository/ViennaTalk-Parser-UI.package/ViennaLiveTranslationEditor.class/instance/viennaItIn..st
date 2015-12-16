evaluating
viennaItIn: aTextModel
	| compiler codeFromSource editor codeFromSelection result |
	compiler := ViennaVDM2SmalltalkTranslator new.
	codeFromSource := targetText text asString.
	editor := aTextModel widget widget textMorph editor.
	editor lineSelectAndEmptyCheck: [ ^ '' ].
	codeFromSelection := compiler expression end / compiler statement end / compiler type end
		parse: (aTextModel text asString copyFrom: editor startIndex to: editor stopIndex - 1) trim.
	codeFromSelection isPetitFailure
		ifTrue: [ ^ aTextModel notify: codeFromSelection message at: codeFromSelection position + 1 in: aTextModel text ].
	result := (Compiler evaluate: codeFromSource , '.' , codeFromSelection) viennaString.
	editor afterSelectionInsertAndSelect: result.
	aTextModel widget widget
		selectFrom: editor startIndex to: editor stopIndex - 1;
		textChanged;
		scrollSelectionIntoView.
	^ true