parsers-types
productType
	^ super productType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ProductType'
				start: start
				end: end
				withAll: array ]