parsers-interfaces
importModuleSignature
	^ super importModuleSignature
		=>> [ :start :end :array | 
			array = 'all'
				ifTrue: [ ViennaNode label: 'ImportModuleSignatureAll' start: start end: end ]
				ifFalse: [ ViennaNode
						label: 'ImportModuleSignature'
						start: start
						end: end
						withAll: array ] ]