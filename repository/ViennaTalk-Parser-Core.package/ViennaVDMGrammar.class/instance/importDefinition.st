parsers-interfaces
importDefinition
	^ (self from , identifier trim , self importModuleSignature)
		==> [ :triple | 
			{(triple second).
			(triple third)} ]