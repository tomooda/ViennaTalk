formatting-definitions
parameters: aViennaNode
	^ '(' , (', ' join: (self formatAll: aViennaNode)) , ')'