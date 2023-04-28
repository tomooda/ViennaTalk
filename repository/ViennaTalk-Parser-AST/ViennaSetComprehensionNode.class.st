Class {
	#name : #ViennaSetComprehensionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaSetComprehensionNode class >> expression: aViennaExpressionNode1 bindList: aViennaBindListNode suchthatExpression: aViennaExpressionNode2 [

	^ (self new: 3)
		  expression: aViennaExpressionNode1;
		  bindList: aViennaBindListNode;
		  suchthatExpression: aViennaExpressionNode2;
		  yourself
]

{ #category : #accessing }
ViennaSetComprehensionNode >> bindList [

	^ self at: 2
]

{ #category : #accessing }
ViennaSetComprehensionNode >> bindList: aViennaBindListNode [

	self at: 2 put: aViennaBindListNode
]

{ #category : #accessing }
ViennaSetComprehensionNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaSetComprehensionNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaSetComprehensionNode >> label [

	^ 'SetComprehension'
]

{ #category : #accessing }
ViennaSetComprehensionNode >> suchthatExpression [

	^ self at: 3
]

{ #category : #accessing }
ViennaSetComprehensionNode >> suchthatExpression: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]
