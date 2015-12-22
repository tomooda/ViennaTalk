do-its
format
	^ self viennaTextMorph ifNil: [ false ] ifNotNil: [ :textMorph | model formatIn: textMorph ]