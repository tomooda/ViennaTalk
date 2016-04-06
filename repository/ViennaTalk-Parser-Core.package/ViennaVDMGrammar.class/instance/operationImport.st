parsers-interfaces
operationImport
	^ name , (((self operator: ':') , self operationType) ==> #second) optional
		, ((self renamed , (self decl: name)) ==> #second) optional