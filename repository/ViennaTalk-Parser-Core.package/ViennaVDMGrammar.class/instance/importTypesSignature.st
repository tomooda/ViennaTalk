parsers-interfaces
importTypesSignature
	^ (self types , (self typeImport separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second