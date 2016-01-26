utilities
generatorCodeFromBindList: aCollectionOfMultipleBind varGenerator: aVarGeneratorBlock do: aBlock
	aCollectionOfMultipleBind
		do: [ :pair | 
			| patterns set |
			patterns := pair first.
			set := pair second.
			patterns
				do: [ :pat | 
					| vars matcher |
					vars := pat first.
					matcher := pat second.
					aBlock
						value:
							(self
								generatorCodeFromVar: vars
								matcher: matcher
								set: set
								varGenerator: aVarGeneratorBlock) ] ]