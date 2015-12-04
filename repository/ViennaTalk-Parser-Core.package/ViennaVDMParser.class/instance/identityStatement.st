parsers-statements
identityStatement
	^ super identityStatement ==> [ :ignore | ViennaNode label: 'IdentityStatement' ]