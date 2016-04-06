parsers-interfaces
operationsSignature
	^ (self operations , (self operationSignature separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second