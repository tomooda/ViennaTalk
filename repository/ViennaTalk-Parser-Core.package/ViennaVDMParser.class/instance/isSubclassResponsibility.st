parsers-definitions
isSubclassResponsibility
	^ super isSubclassResponsibility ==> [ :ignore | ViennaNode label: 'IsSubclassResponsibility' ]