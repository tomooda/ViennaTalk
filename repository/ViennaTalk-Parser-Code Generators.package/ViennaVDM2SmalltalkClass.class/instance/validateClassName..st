utilities
validateClassName: aString
	aString ifEmpty: [ ^ false ].
	aString first canBeGlobalVarInitial
		ifFalse: [ ^ false ].
	(aString allSatisfy: [ :char | char isAlphaNumeric or: [ char = $_ ] ])
		ifFalse: [ ^ false ].
	^ true