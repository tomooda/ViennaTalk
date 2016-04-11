formatting-definitions
module: aViennaNode
	| identifier interface moduleBody |
	identifier := self format: aViennaNode first.
	interface := self format: aViennaNode second.
	moduleBody := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | String cr , (self format: node) ].
	^ 'module ' , identifier , String cr , interface , moduleBody , String cr , 'end ' , identifier