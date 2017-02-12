formatting-statements
trapStatement: aViennaNode
	| pattern handler statement |
	pattern := self format: aViennaNode first.
	handler := self format: aViennaNode second.
	statement := self format: aViennaNode third.
	^ (self needsIndent: pattern)
		ifTrue: [ (self indentString: 'trap' insertCr: pattern) , String cr
				, (self indentString: 'with' insertCr: handler) , String cr
				, (self indentString: 'in' insertCr: statement) ]
		ifFalse: [ | trap |
			trap := 'trap ' , pattern.
			(self needsIndent: trap , handler)
				ifTrue: [ trap , String cr , (self indentString: 'with' insertCr: handler) , String cr
						, (self indentString: 'in' insertCr: statement) ]
				ifFalse: [ trap := trap , ' with ' , handler.
					(self needsIndent: trap , statement)
						ifTrue: [ trap , String cr , (self indentString: 'in' insertCr: statement) ]
						ifFalse: [ trap , ' in ' , statement ] ] ]