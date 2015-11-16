accessing-field types
equalityAbstractionFieldNameAt: anInteger put: aString
	namedFields at: aString put: anInteger.
	equalityFields := equalityFields copyWithout: anInteger