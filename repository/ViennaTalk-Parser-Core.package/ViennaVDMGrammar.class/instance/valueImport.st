parsers-interfaces
valueImport
	^ name , (((self operator: ':') , type) ==> #second) optional , ((self renamed , (self decl: name)) ==> #second) optional