formatting-statements
returnStatement: aViennaNode
	^ 'return '
		, (aViennaNode first ifNil: [ '' ] ifNotNil: [ :arg | self indentString: (self format: arg) ])