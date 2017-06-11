parsers-types
typeName
	^ super typeName
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TypeName'
				start: start
				end: end
				with:
					(array isString
						ifTrue: [ ViennaNode
								label: 'LocalName'
								start: start
								end: end
								with: array ]
						ifFalse: [ ViennaNode
								label: 'GlobalName'
								start: start
								end: end
								withAll: array ]) ]