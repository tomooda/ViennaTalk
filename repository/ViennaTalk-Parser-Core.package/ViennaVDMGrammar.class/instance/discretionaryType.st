parsers-types
discretionaryType
	^ type / (((self operator: $() , (self operator: $))) ==> [ :pair | nil ])