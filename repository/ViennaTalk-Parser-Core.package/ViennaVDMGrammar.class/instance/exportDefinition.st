parsers-interfaces
exportDefinition
	^ ((self reserved: 'exports') , self exportModuleSignature) ==> #second