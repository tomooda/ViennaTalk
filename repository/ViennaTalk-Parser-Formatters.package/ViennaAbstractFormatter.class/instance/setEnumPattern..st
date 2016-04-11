formatting-patterns and binds
setEnumPattern: aViennaNode
	^ '{' , (self formatEnumerate: (self formatAll: aViennaNode) ifEmpty: [ '' ]) , '}'