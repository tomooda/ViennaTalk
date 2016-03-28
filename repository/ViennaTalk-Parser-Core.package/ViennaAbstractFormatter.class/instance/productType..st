formatting-types
productType: aViennaNode
	^ self formatEnumerate: (self formatAll: aViennaNode) separator: self mul ifEmpty: [ '' ]