parsers-interfaces
typeImport
	^ (self typeDefinition , ((self renamed , (self decl: (self type: name))) ==> #second) optional)
		/ (self typeName , ((self renamed , (self decl: (self type: name))) ==> #second) optional)