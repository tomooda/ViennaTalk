parsers-interfaces
importDefinition
	^ ((self reserved: 'from') , identifier , self importModuleSignature)
		==> [ :triple | 
			{(triple second).
			(triple third)} ]