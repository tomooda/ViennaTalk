formatting-types
unionType: aViennaNode
	^ self formatEnumerate: (self formatAll: aViennaNode) separator: '|' ifEmpty: [ '' ]