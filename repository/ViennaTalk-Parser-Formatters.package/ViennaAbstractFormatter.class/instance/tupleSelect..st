formatting-expressions
tupleSelect: aViennaNode
	| tuple int |
	tuple := self format: aViennaNode first.
	int := self format: aViennaNode second.
	^ self print: tuple infix: '.#' arg: int