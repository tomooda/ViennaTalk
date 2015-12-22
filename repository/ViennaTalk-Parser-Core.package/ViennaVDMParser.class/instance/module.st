parsers-definitions
module
	^ super module ==> [ :array | ViennaNode label: 'Module' withAll: array ]