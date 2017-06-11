parsers-interfaces
exportModuleSignature
	^ super exportModuleSignature
		=>> [ :start :end :array | 
			array = 'all'
				ifTrue: [ ViennaNode label: 'ExportModuleSignatrueAll' start: start end: end ]
				ifFalse: [ ViennaNode
						label: 'ExportModuleSignature'
						start: start
						end: end
						withAll: array ] ]