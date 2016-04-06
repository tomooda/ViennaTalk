parsers-interfaces
typeImport
	^ (self typeDefinition , ((self renamed , (self decl: name)) ==> #second) optional)
		/ (self typeName , ((self renamed , (self decl: name)) ==> #second) optional)