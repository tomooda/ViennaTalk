parsers-statements
alwaysStatement
	^ super alwaysStatement ==> [ :pair | ViennaNode label: 'AlwaysStatement' withAll: pair ]