parsers-definitions
isSubclassResponsibility
	^ super isSubclassResponsibility
		=>>
			[ :start :end :ignore | ViennaNode label: 'IsSubclassResponsibility' start: start end: end ]