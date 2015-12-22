formatting-patterns and binds
setEnumPattern: aViennaNode
	^ '{' , (self formatEnumerate: (self formatAll: aViennaNode first) ifEmpty: [ '' ]) , '}'