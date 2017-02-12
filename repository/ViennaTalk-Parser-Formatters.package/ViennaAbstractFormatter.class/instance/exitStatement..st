formatting-statements
exitStatement: aViennaNode
	^ 'exit ' , (self indentString: (self format: aViennaNode first))