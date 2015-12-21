parsers-interfaces
operationImport
	^ name , (((self operator: ':') , self operationType) ==> #second) optional
		, (((self reserved: 'renamed') , name) ==> #second) optional