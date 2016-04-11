bound variables-types
boundVariablesCompositeType: aViennaNode into: aSet
	| constructor fieldList |
	constructor := aViennaNode first.
	fieldList := aViennaNode second.
	aSet add: constructor.
	fieldList
		do: [ :field | 
			| type |
			type := field third.
			self boundVariables: type into: aSet ]