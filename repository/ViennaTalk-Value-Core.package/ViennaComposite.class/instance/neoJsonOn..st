printing
neoJsonOn: neoJSONWriter
	(Dictionary new
		at: constructorName put: self asArray;
		yourself) neoJsonOn: neoJSONWriter