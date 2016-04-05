parsers-definitions
stateDefinition
	^ (self state , identifier trim , (self reserved: 'of') , self stateFieldList , invariant optional
		, self initialisation optional , self endKeyword , semicolon optional)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array fifth).
			(array sixth)} ]