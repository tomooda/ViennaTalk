utilities
flattenAndCheckBindList: bindListNode env: aDictionary do: aBlock
	| patternsAndSets boundVariables |
	patternsAndSets := Array
		new: 16
		streamContents: [ :stream | 
			bindListNode
				do: [ :multipleBindNode | 
					| typeOrSetNode |
					typeOrSetNode := multipleBindNode second.
					multipleBindNode first
						do: [ :patternNode | 
							stream
								nextPut:
									{patternNode.
									typeOrSetNode} ] ] ].
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
					ifTrue: [ #direct ]
					ifFalse: [ #complex ]) ]