utilities
generatorCodeFromBindList: aCollectionOfMultipleBind varGenerator: aVarGeneratorBlock do: aBlock
	aCollectionOfMultipleBind
		do: [ :pair | 
			| patterns set |
			patterns := pair first.
			set := pair second.
			patterns
				do: [ :pat | 
					| vars binder |
					vars := pat first.
					binder := pat second.
					aBlock
						value:
							(self
								generatorCodeFromVar: vars
								binder: binder
								set: set
								varGenerator: aVarGeneratorBlock) ] ]