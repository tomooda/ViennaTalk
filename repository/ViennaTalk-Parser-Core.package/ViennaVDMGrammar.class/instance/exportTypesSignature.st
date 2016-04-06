parsers-interfaces
exportTypesSignature
	^ (self types , (self typeExport separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second