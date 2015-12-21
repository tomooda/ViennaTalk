parsers-interfaces
exportTypesSignature
	^ ((self reserved: 'types') , (self typeExport separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second