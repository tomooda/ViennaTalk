formatting-patterns and binds
patternIdentifier: aViennaNode
	^ aViennaNode first ifNil: ['-'] ifNotNil: [:identifier | self format:identifier]