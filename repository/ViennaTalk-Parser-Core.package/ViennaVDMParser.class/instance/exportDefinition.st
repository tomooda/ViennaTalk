parsers-interfaces
exportDefinition
	^ super exportDefinition
		=>> [ :start :end :moduleSignature | 
			ViennaNode
				label: 'ExportDefinition'
				start: start
				end: end
				with: moduleSignature ]