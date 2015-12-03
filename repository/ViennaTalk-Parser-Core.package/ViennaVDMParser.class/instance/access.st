parsers-definitions
access
	^ super access ==> [ :string | ViennaNode label: 'Access' with: string ]