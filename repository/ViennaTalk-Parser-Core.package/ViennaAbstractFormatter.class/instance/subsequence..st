formatting-expressions
subsequence: aViennaNode
	| sequence start end |
	sequence := self format: aViennaNode first.
	start := self format: aViennaNode second.
	end := self format: aViennaNode third.
	(self needsIndent: sequence , start , end)
		ifFalse: [ ^ sequence , '(' , start , ',' , self dots , ',' , end , ')' ].
	(self needsIndent: start , end)
		ifFalse: [ ^ sequence , '(' , String cr , indent , (self indentString: start , ',' , self dots , ', ' , end , ')') ].
	^ sequence , '(' , String cr , indent
		, ((self indentString: start , ',') , String cr , indent , self dots , ', ' , (self indentString: end , ')'))