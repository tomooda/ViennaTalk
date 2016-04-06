parsers-definitions
stateDefinition
	^ (self state , self typeIdentifier trim , self of , self stateFieldList , invariant optional , self initialisation optional
		, self endKeyword , semicolon optional)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array fifth).
			(array sixth)} ]