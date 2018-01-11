parsers-statements
errorStatement
	^ super errorStatement ==> [ :string | ViennaNode label: 'ErrorStatement' ]