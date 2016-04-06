parsers-interfaces
exportFunctionsSignature
	^ (self functions , (self functionExport separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second