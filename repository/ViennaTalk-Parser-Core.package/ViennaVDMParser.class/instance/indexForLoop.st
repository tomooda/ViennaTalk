parsers-statements
indexForLoop
	^ super indexForLoop ==> [ :array | ViennaNode label: 'IndexForLoop' withAll: array ]