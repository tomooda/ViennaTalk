parsers-interfaces
importValuesSignature
	^ (self values , (self valueImport separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second