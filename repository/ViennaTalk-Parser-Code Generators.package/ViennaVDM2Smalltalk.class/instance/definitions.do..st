utilities
definitions: aViennaNode do: aBlock
	(#('AccessFunctionDefinition' 'AccessOperationDefinition' 'AccessValueDefinition' 'AccessTypeDefinition' 'StateDefinition')
		includes: aViennaNode label)
		ifTrue: [ ^ aBlock value: aViennaNode ].
	aViennaNode do: [ :node | self definitions: node do: aBlock ]