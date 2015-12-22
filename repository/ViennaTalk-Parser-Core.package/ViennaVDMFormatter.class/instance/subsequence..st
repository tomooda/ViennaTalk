formatting-expressions
subsequence: aViennaNode
	| sequence start end |
	sequence := self format: aViennaNode first.
	start := self format: aViennaNode second.
	end := self format: aViennaNode third.
	(self needsIndent: sequence , start , end)
		ifFalse: [ ^ sequence , '(' , start , ',...,' , end , ')' ].
	(self needsIndent: start , end)
		ifFalse: [ ^ sequence , '(' , String cr , indent , (self indentString: start , ',..., ' , end , ')') ].
	^ sequence , '(' , String cr , indent
		, ((self indentString: start , ',') , String cr , indent , '..., ' , (self indentString: end , ')'))