parsers-interfaces
valuesSignature
	^ (self values , (self valueSignature separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second