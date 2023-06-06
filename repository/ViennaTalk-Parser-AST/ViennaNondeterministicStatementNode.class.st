Class {
	#name : #ViennaNondeterministicStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaNondeterministicStatementNode >> formatWith: aViennaAbstractFormatter [

	| statements |
	statements := aViennaAbstractFormatter formatAll: self.
	^ '||(' , ((aViennaAbstractFormatter anyNeedsIndent: statements)
		   ifTrue: [
			   aViennaAbstractFormatter
				   join: ',' , String cr , aViennaAbstractFormatter indent
				   withAll: (statements collect: [ :statement |
						    aViennaAbstractFormatter indentString: statement ]) ]
		   ifFalse: [
		   aViennaAbstractFormatter join: ', ' withAll: statements ]) , ')'
]

{ #category : #testing }
ViennaNondeterministicStatementNode >> isViennaNondeterministicStatementNode [

	^ true
]

{ #category : #accessing }
ViennaNondeterministicStatementNode >> label [

	^ 'NondeterministicStatement'
]
