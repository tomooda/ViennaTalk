parsers-interfaces
functionsSignature
	^ ((self reserved: 'functions') , (self functionSignature separatedBy: semicolon) withoutSeparators
		, semicolon optional) ==> #second