parsers-types
discretionaryType1
	^ type1 / (((self operator: $() , (self operator: $))) ==> [ :pair | nil ])