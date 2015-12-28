printing
neoJsonOn: neoJSONWriter
	(Dictionary new
		at: 'token' put: value;
		yourself) neoJsonOn: neoJSONWriter