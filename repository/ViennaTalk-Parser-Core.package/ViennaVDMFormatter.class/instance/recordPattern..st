formatting-patterns and binds
recordPattern: aViennaNode
	| constructor expressionList |
	constructor := self format: aViennaNode first.
	expressionList := self format: aViennaNode second.
	^ 'mk_' , constructor , '('
		,
			((self needsIndent: constructor , expressionList)
				ifTrue: [ String cr , indent , (self indentString: expressionList) ]
				ifFalse: [ expressionList ]) , ')'