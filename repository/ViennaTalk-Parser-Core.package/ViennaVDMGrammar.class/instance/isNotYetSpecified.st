parsers-definitions
isNotYetSpecified
	^ ((self reserved: 'is') , (self reserved: 'not') , (self reserved: 'yet') , (self reserved: 'specified'))
		==> [ :array | nil ]