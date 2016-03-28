formatting-expressions
setRangeExpression: aViennaNode
	| start end |
	start := self format: aViennaNode first.
	end := self format: aViennaNode second.
	^ self noIndentString: '{' , start , ',' insertCrIfNeeded: self dots , ', ' , end , '}'