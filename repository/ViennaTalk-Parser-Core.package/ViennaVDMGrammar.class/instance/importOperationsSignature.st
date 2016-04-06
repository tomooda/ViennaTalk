parsers-interfaces
importOperationsSignature
	^ (self operations , (self operationImport separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second