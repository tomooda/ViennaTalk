formatting-expressions
functionTypeInstantiation: aViennaNode
	| function typeArgs |
	function := self format: aViennaNode first.
	typeArgs := self format: aViennaNode second.
	^ function , typeArgs