formatting-expressions
conditionalExpression: aViennaNode
	^ 'elseif ' , (self indentString: (self format: aViennaNode first)) , String cr , indent , 'then '
		, (self indentString: (self format: aViennaNode second))