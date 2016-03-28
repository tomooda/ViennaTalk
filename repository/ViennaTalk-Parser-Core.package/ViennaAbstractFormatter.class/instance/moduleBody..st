formatting-definitions
moduleBody: aViennaNode
	| definitionBlocks |
	definitionBlocks := self formatAll: aViennaNode.
	^ 'definitions' , String cr , (String cr join: definitionBlocks)