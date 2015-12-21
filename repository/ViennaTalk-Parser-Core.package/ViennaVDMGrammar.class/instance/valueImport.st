parsers-interfaces
valueImport
	^ name , (((self operator: ':') , type) ==> #second) optional
		, (((self reserved: 'renamed') , name) ==> #second) optional