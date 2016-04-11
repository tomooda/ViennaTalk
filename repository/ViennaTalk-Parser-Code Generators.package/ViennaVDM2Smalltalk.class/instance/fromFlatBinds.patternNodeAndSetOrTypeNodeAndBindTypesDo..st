utilities
fromFlatBinds: patternsAndSets patternNodeAndSetOrTypeNodeAndBindTypesDo: aBlock
	| boundVariables |
	boundVariables := patternsAndSets collect: [ :pair | self boundVariables: pair first ].
	1 to: patternsAndSets size do: [ :index | 
		| bindNode patternNode |
		bindNode := patternsAndSets at: index.
		patternNode := bindNode first.
		aBlock
			value: bindNode first
			value: bindNode second
			value:
				((patternNode label = 'PatternIdentifier'
					and: [ 
						(1 to: patternsAndSets size)
							allSatisfy: [ :i | i = index or: [ ((boundVariables at: i) includes: patternNode first) not ] ] ])
					ifTrue: [ #identifier ]
					ifFalse: [ #compound ]) ]