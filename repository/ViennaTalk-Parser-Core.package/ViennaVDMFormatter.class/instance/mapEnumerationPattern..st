formatting-patterns and binds
mapEnumerationPattern: aViennaNode
	^ '{' , (self formatEnumerate: (self formatAll: aViennaNode first) ifEmpty: [ '|->' ]) , '}'