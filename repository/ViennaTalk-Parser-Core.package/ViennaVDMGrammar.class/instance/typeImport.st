parsers-interfaces
typeImport
	^ (self typeDefinition , (((self reserved: 'renamed') , name) ==> #second) optional)
		/ (name , (((self reserved: 'renamed') , name) ==> #second) optional)