parsers-statements
defStatement
	^ super defStatement ==> [ :array | ViennaNode label: 'DefStatement' withAll: array ]