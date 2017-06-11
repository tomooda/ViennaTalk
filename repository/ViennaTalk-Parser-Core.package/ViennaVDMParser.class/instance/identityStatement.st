parsers-statements
identityStatement
	^ super identityStatement
		=>> [ :start :end :ignore | ViennaNode label: 'IdentityStatement' start: start end: end ]