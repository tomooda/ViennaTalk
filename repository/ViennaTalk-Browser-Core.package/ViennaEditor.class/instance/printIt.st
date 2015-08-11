do-its
printIt
	^ self viennaTextMorph ifNil: [ false ] ifNotNil: [ :textMorph | model printItIn: textMorph ]