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

{ #category : #'parsers-patterns' }
ViennaLetBeExpressionNode >> expression [

	^ self at: 2
]

{ #category : #'parsers-patterns' }
ViennaLetBeExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaLetBeExpressionNode >> label [

	^ 'LetBeExpression'
]

{ #category : #'parsers-patterns' }
ViennaLetBeExpressionNode >> multipleBind [

	^ self at: 1
]

{ #category : #'parsers-patterns' }
ViennaLetBeExpressionNode >> multipleBind: aViennaMultipleBindNode [

	self at: 1 put: aViennaMultipleBindNode
]
