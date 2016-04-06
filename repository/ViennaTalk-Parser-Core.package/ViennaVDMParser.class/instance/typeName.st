parsers-types
typeName
	^ super typeName
		==> [ :array | 
			ViennaNode
				label: 'TypeName'
				with:
					(array isString
						ifTrue: [ ViennaNode label: 'LocalName' with: array ]
						ifFalse: [ ViennaNode label: 'GlobalName' withAll: array ]) ]