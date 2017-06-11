parsers-interfaces
interface
	^ super interface
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Interface'
				start: start
				end: end
				withAll: array ]