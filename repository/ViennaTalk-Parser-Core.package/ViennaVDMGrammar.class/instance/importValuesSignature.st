parsers-interfaces
importValuesSignature
	^ ((self reserved: 'values') , (self valueImport separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second