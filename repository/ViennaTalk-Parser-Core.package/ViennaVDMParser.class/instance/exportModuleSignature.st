parsers-interfaces
exportModuleSignature
	^ super exportModuleSignature
		==> [ :array | 
			array = 'all'
				ifTrue: [ ViennaNode label: 'ExportModuleSignatrueAll' ]
				ifFalse: [ ViennaNode label: 'ExportModuleSignature' withAll: array ] ]