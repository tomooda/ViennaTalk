parsers-interfaces
typeExport
	^ super typeExport
		=>> [ :start :end :array | 
			array first isNil
				ifTrue: [ ViennaNode
						label: 'TypeNameExport'
						start: start
						end: end
						with: array second ]
				ifFalse: [ ViennaNode
						label: 'TypeStructExport'
						start: start
						end: end
						with: array second ] ]