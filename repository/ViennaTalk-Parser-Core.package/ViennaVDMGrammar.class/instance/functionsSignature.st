parsers-interfaces
functionsSignature
	^ (self functions , (self functionSignature separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second