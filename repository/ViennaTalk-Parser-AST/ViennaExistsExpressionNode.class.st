Class {
	#name : #ViennaExistsExpressionNode,
	#superclass : #ViennaExpressionNode,
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

{ #category : #accessing }
ViennaExistsExpressionNode >> bindList [

	^ self at: 1
]

{ #category : #accessing }
ViennaExistsExpressionNode >> bindList: aViennaBindListNode [

	self at: 1 put: aViennaBindListNode
]

{ #category : #accessing }
ViennaExistsExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaExistsExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
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

{ #category : #accessing }
ViennaExistsExpressionNode >> label [

	^ 'ExistsExpression'
]

{ #category : #'pretty printing' }
ViennaExistsExpressionNode >> operatorPrecedence [

	^ 10
]
