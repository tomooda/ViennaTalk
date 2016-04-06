parsers-interfaces
valueImport
	^ name , (((self operator: ':') , type) ==> #second) optional , ((self renamed , name) ==> #second) optional