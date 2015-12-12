evaluating
translateIt
	| compiler editor codeFromSelection |
	compiler := ViennaVDM2SmalltalkTranslator new.
	editor := codeText widget widget textMorph editor.
	editor lineSelectAndEmptyCheck: [ ^ '' ].
	codeFromSelection := compiler expression end / compiler statement end / compiler type end
		parse: (codeText text asString copyFrom: editor startIndex to: editor stopIndex - 1) trim.
	codeFromSelection isPetitFailure
		ifTrue: [ ^ codeText notify: codeFromSelection message at: codeFromSelection position + 1 in: codeText text ].
	editor afterSelectionInsertAndSelect: codeFromSelection.
	codeText widget widget
		selectFrom: editor startIndex to: editor stopIndex;
		textChanged;
		scrollSelectionIntoView.
	^ true