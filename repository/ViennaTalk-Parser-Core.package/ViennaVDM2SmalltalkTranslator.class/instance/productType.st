parsers-types
productType
	^ super productType ==> [ :basetypes | '(' , ('*' join: basetypes) , ')' ]