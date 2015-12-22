parsers-interfaces
importModuleSignature
	^ super importModuleSignature
		==> [ :array | 
			array = 'all'
				ifTrue: [ ViennaNode label: 'ImportModuleSignatureAll' ]
				ifFalse: [ ViennaNode label: 'ImportModuleSignature' withAll: array ] ]