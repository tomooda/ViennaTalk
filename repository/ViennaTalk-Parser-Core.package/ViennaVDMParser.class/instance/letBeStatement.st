parsers-statements
letBeStatement
	^ super letBeStatement ==> [ :array | ViennaNode label: 'LetBeStatement' withAll: array ]