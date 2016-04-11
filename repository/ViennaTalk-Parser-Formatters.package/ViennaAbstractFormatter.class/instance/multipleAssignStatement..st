formatting-statements
multipleAssignStatement: aViennaNode
	| statements |
	statements := self formatAll: aViennaNode.
	^ 'atomic('
		,
			((self anyNeedsIndent: statements)
				ifTrue: [ ';' , String cr , indent join: (statements collect: [ :statement | self indentString: statement ]) ]
				ifFalse: [ '; ' join: statements ]) , ')'