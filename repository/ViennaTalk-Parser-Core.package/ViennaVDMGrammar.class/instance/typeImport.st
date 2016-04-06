parsers-interfaces
typeImport
	^ (self typeDefinition , ((self renamed , self typeName) ==> #second) optional)
		/ (self typeName , ((self renamed , self typeName) ==> #second) optional)