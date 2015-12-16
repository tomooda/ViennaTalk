formatting-expressions
existsExpression: aViennaNode
	| bindList expression |
	bindList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	(self needsIndent: bindList)
		ifTrue: [ 
			^ 'exists' , String cr , indent , (self indentString: bindList) , String cr , '&' , String cr , indent
				, (self indentString: expression) ].
	(self needsIndent: bindList , expression)
		ifTrue: [ ^ 'exists ' , bindList , ' &' , String cr , indent , (self indentString: expression) ].
	^ 'exists ' , bindList , ' & ' , expression