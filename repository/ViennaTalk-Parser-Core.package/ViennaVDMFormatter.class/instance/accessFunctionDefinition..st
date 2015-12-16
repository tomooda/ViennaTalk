formatting-definitions
accessFunctionDefinition: aViennaNode
	^ ' ' join: ((self formatAll: aViennaNode) reject: [ :str | str trim isEmpty ])