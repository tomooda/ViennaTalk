parsers-interfaces
exportFunctionsSignature
	^ ((self reserved: 'functions') , (self functionExport separatedBy: semicolon) withoutSeparators) ==> #second