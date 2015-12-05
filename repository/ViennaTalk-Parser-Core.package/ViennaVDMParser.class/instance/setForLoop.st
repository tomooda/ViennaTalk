parsers-statements
setForLoop
	^ super setForLoop ==> [ :array | ViennaNode label: 'SetForLoop' withAll: array ]