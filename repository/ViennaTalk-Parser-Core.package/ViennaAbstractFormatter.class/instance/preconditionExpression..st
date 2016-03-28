formatting-expressions
preconditionExpression: aViennaNode
	| expressions |
	expressions := self formatAll: aViennaNode.
	^ 'pre_('
		,
			((self anyNeedsIndent: expressions)
				ifTrue: [ ',' , String cr , indent join: (expressions collect: [ :expression | self indentString: expression ]) ]
				ifFalse: [ ', ' join: expressions ]) , ')'