parsers-interfaces
importDefinition
	^ ((self reserved: 'from') , identifier trim , self importModuleSignature)
		==> [ :triple | 
			{(triple second).
			(triple third)} ]