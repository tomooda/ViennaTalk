parsers-definitions
initialisation
	^ super initialisation
		=>> [ :start :end :invFunc | 
			ViennaNode
				label: 'Initialisation'
				start: start
				end: end
				with: invFunc ]