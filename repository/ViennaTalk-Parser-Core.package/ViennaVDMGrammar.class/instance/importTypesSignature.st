parsers-interfaces
importTypesSignature
	^ ((self reserved: 'types') , (self typeImport separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second