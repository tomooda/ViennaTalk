parsers-types
equalityAbstractionField
	^ super equalityAbstractionField
		==> [ :pair | 
			| fieldName fieldType |
			fieldName := pair first.
			fieldType := pair second.
			'{' , fieldName storeString , '. true. ' , pair second , '}' ]