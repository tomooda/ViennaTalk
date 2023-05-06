Class {
	#name : #ViennaLetBeExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaLetBeExpressionNode class >> multipleBind: aViennaMultipleBindNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  multipleBind: aViennaMultipleBindNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> label [

	^ 'LetBeExpression'
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> multipleBind [

	^ self at: 1
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> multipleBind: aViennaMultipleBindNode [

	self at: 1 put: aViennaMultipleBindNode
]

{ #category : #'pretty printing' }
ViennaLetBeExpressionNode >> operatorPrecedence [

	^ 10
]
