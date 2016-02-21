utilities
flattenBindList: bindListNode varGenerator: varGenerator env: aDictionary
	| setsAndVars |
	setsAndVars := OrderedCollection new: bindListNode size.
	^ {(Array
		new: 16
		streamContents: [ :stream | 
			bindListNode
				do: [ :multipleBindNode | 
					| typeOrSetNode varName localNameNode |
					typeOrSetNode := multipleBindNode second.
					varName := varGenerator value.
					localNameNode := ViennaNode label: 'LocalName' with: varName.
					setsAndVars
						add:
							{(typeOrSetNode label = 'SetRangeExpression'
								ifTrue: [ '(' , (self intervalExpression: typeOrSetNode env: aDictionary) , ')' ]
								ifFalse: [ self generate: typeOrSetNode env: aDictionary ]).
							varName}.
					multipleBindNode first
						do: [ :patternNode | 
							stream
								nextPut:
									{patternNode.
									localNameNode} ] ] ]).
	setsAndVars}