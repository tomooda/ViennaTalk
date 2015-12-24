VDM manipulations
formatSelectionInCodeText
	| parser editor result |
	parser := ViennaVDMParser new.
	editor := codeText widget widget textMorph editor.
	editor lineSelectAndEmptyCheck: [ ^ '' ].
	result := parser expression end / parser statement end / parser type end
		parse: (codeText text asString copyFrom: editor startIndex to: editor stopIndex - 1) trim.
	result isPetitFailure
		ifTrue: [ ^ codeText notify: result message at: result position + 1 in: codeText text ].
	editor replaceSelectionWith: result.
	codeText widget widget
		selectFrom: editor startIndex to: editor stopIndex - 1;
		textChanged;
		scrollSelectionIntoView.
	^ true