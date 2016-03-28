formatting-interfaces
typeStructExport: aViennaNode
	| name |
	name := self format: aViennaNode first.
	^ 'struct ' , name