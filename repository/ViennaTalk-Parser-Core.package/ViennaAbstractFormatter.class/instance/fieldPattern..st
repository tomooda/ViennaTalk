formatting-patterns and binds
fieldPattern: aViennaNode
	| identifier pattern |
	identifier := self format: aViennaNode first.
	pattern := self format: aViennaNode second.
	^ identifier , ' ', self maplet, ' ', pattern