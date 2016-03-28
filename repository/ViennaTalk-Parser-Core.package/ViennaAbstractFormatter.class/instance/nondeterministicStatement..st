formatting-statements
nondeterministicStatement: aViennaNode
	| statements |
	statements := self formatAll: aViennaNode.
	^ '||('
		,
			((self anyNeedsIndent: statements)
				ifTrue: [ ',' , String cr , indent join: (statements collect: [ :statement | self indentString: statement ]) ]
				ifFalse: [ ', ' join: statements ]) , ')'