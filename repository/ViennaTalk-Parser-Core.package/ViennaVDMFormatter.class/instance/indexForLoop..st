formatting-statements
indexForLoop: aViennaNode
	| identifier start end step statement |
	identifier := self format: aViennaNode first.
	start := self format: aViennaNode second.
	end := self format: aViennaNode third.
	step := aViennaNode fourth ifNotNil: [ self format: aViennaNode fourth ] ifNil: [ '' ].
	statement := self format: aViennaNode fifth.
	(self needsIndent: identifier , start , end , step , statement)
		ifFalse: [ ^ 'for ' , identifier , ' = ' , start , ' to ' , end , (step ifNotEmpty: [ ' by ' , step ]) , ' do ' , statement ].
	(self needsIndent: identifier , start , end , step)
		ifFalse: [ 
			^ 'for ' , identifier , ' = ' , start , ' to ' , end , (step ifNotEmpty: [ ' by ' , step ]) , String cr , ' do '
				, (self indentString: statement) ].
	^ 'for ' , identifier , ' = ' , (self indentString: start) , String cr , 'to ' , (self indentString: end)
		, (step ifNotEmpty: [ String cr , 'by ' , (self indent: step) ]) , String cr , 'do ' , (self indentString: statement)