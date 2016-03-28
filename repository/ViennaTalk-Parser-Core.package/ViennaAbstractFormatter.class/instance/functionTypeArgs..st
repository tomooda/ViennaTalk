formatting-expressions
functionTypeArgs: aViennaNode
	^ '[' , (', ' join: (self formatAll: aViennaNode)) , ']'