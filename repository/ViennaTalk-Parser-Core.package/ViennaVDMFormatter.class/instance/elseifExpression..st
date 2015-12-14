formatting-expressions
elseifExpression: aViennaNode
	^ 'elseif ' , (self format: aViennaNode first) , ' then ' , (self indentString: (self format: aViennaNode second))