parsers-interfaces
typeImport
	^ (self typeDefinition , ((self renamed , (self decl: self typeName)) ==> #second) optional)
		/ (self typeName , ((self renamed , (self decl: self typeName)) ==> #second) optional)