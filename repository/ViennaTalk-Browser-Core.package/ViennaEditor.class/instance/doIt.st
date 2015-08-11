do-its
doIt
	^ self viennaTextMorph ifNil: [ false ] ifNotNil: [ :textMorph | model doItIn: textMorph ]