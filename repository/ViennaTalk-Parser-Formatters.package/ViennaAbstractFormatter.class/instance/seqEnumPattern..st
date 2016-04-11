formatting-patterns and binds
seqEnumPattern: aViennaNode
	^ '[' , (self formatEnumerate: (self formatAll: aViennaNode) ifEmpty: [ '' ]) , ']'