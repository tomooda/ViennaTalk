parsers-types
optionalType
	^ ((self operator: $[) , type , (self operator: $])) ==> [ :triple | triple second ]