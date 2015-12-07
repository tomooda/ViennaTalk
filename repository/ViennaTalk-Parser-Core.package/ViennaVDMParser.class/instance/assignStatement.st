parsers-statements
assignStatement
	^ super assignStatement ==> [ :pair | ViennaNode label: 'AssignStatement' withAll: pair ]