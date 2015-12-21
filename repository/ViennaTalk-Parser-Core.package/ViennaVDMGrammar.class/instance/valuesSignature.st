parsers-interfaces
valuesSignature
	^ ((self reserved: 'values') , (self valueSignature separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second