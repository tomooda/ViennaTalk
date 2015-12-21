parsers-interfaces
importFunctionsSignature
	^ ((self reserved: 'functions') , (self functionImport separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second