parsers-statements
trapStatement
	^ super trapStatement ==> [ :pair | ViennaNode label: 'TrapStatement' withAll: pair ]