parsers-interfaces
importFunctionsSignature
	^ (self functions , (self functionImport separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second