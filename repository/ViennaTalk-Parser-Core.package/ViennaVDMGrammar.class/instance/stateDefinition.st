parsers-definitions
stateDefinition
	^ ((self reserved: 'state') , identifier , (self reserved: 'of') , self stateFieldList , invariant optional
		, self initialisation optional , (self reserved: 'end') , semicolon optional)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array fifth).
			(array sixth)} ]