parsers-interfaces
operationsSignature
	^ ((self reserved: 'operations') , (self operationSignature separatedBy: semicolon) withoutSeparators
		, semicolon optional) ==> #second