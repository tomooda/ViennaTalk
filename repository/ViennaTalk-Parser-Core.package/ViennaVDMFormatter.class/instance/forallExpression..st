formatting-expressions
forallExpression: aViennaNode
	| bindList expression |
	bindList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	(self needsIndent: bindList)
		ifTrue: [ 
			^ 'forall' , String cr , indent , (self indentString: bindList) , String cr , '&' , String cr , indent
				, (self indentString: expression) ].
	(self needsIndent: bindList , expression)
		ifTrue: [ ^ 'forall ' , bindList , ' &' , String cr , indent , (self indentString: expression) ].
	^ 'forall ' , bindList , ' & ' , expression