parsers-types
identifiedField
	^ super identifiedField
		==> [ :pair | 
			| fieldName fieldType |
			fieldName := pair first.
			fieldType := pair second.
			{fieldName.
			false.
			fieldType} ]