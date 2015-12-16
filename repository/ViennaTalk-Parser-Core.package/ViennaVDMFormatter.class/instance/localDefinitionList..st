formatting-definitions
localDefinitionList: aViennaNode
	| localDefinitions |
	localDefinitions := self formatAll: aViennaNode.
	^ (self anyNeedsIndent: localDefinitions)
		ifTrue: [ ',' , String cr join: localDefinitions ]
		ifFalse: [ ', ' join: localDefinitions ]