parsers-interfaces
exportDefinition
	^ super exportDefinition ==> [ :moduleSignature | ViennaNode label: 'ExportDefinition' with: moduleSignature ]