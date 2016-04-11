formatting-definitions
equalDefinitionList: aViennaNode
	| defs |
	defs := self formatAll: aViennaNode.
	^ (';' , String cr join: defs) , ';'