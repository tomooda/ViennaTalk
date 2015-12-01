parsers-types
unionType
	^ super unionType ==> [ :basetypes | '(' , ('|' join: basetypes) , ')' ]