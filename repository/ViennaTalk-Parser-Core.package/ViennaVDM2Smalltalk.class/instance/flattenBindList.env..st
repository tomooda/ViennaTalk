utilities
flattenBindList: bindListNode env: aDictionary
	^ Array
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
									typeOrSetNode} ] ] ]