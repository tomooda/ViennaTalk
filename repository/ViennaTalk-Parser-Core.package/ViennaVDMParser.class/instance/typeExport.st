parsers-interfaces
typeExport
	^ super typeExport
		==> [ :array | 
			array first isNil
				ifTrue: [ ViennaNode label: 'TypeNameExport' with: array second ]
				ifFalse: [ ViennaNode label: 'TypeStructExport' with: array second ] ]