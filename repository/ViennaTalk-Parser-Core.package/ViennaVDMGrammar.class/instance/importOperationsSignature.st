parsers-interfaces
importOperationsSignature
	^ ((self reserved: 'operations') , (self operationImport separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second