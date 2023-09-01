Class {
	#name : #ViennaExistsExpressionNode,
	#superclass : #ViennaMultipleBindQuantifierNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaExistsExpressionNode class >> bindList: aViennaBindListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  bindList: aViennaBindListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaExistsExpressionNode >> formatWith: aViennaAbstractFormatter [

	| bindList expression |
	bindList := aViennaAbstractFormatter format: self bindList.
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter
				   indentString: aViennaAbstractFormatter exists
				   insertCrIfNeeded:
				   bindList trim , ' ' , aViennaAbstractFormatter dot)
		  insertCrIfNeeded: expression
]

{ #category : #testing }
ViennaExistsExpressionNode >> isViennaExistsExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaExistsExpressionNode >> label [

	^ 'ExistsExpression'
]

{ #category : #'pretty printing' }
ViennaExistsExpressionNode >> operatorPrecedence [

	^ 10
]
