parsers-types
compositeType
	^ super compositeType
		==> [ :pair | 
			| constructorName fields |
			constructorName := pair first.
			fields := pair second.
			'(ViennaType compose: ' , constructorName storeString , ' of: {' , (' . ' join: fields) , '})' ]