parsers-types
operationType
	| discretionaryType |
	discretionaryType := self discretionaryType.
	^ (discretionaryType , (self operator: '==>') , discretionaryType)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]