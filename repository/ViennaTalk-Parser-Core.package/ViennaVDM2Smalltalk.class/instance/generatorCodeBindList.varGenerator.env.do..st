utilities
generatorCodeBindList: bindListNode varGenerator: aVarGeneratorBlock env: aDictionary do: aBlock
	bindListNode
		do: [ :multipleTypeOrSetBindNode | 
			| typeOrSetNode |
			typeOrSetNode := multipleTypeOrSetBindNode second.
			multipleTypeOrSetBindNode first
				do: [ :patternNode | 
					aBlock
						value:
							(self
								generatorCodePattern: patternNode
								typeOrSet: typeOrSetNode
								needsSort: false
								varGenerator: aVarGeneratorBlock
								env: aDictionary) ] ]