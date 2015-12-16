formatting-expressions
setRangeExpression: aViennaNode
	| start end |
	start := self format: aViennaNode first.
	end := self format: aViennaNode second.
	^ '{' , start
		,
			((self needsIndent: start , end)
				ifTrue: [ ',' , String cr , indent , '..., ' , (self indentString: end) ]
				ifFalse: [ ',..., ' , end ]) , '}'