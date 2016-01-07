translating
jsonToVdmString: jsonString
	| jsonObj |
	jsonObj := (NeoJSONReader on: jsonString readStream)
		listClass: OrderedCollection;
		next.
	^ (self jsonToVdm: jsonObj) viennaString