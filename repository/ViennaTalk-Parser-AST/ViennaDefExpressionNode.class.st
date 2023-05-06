Class {
	#name : #ViennaDefExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaDefExpressionNode class >> equalDefinitionList: aViennaEqualDefinitionListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  equalDefinitionList: aViennaEqualDefinitionListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaDefExpressionNode >> equalDefinitionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaDefExpressionNode >> equalDefinitionList: aViennaEqualDefinitionListNode [

	self at: 1 put: aViennaEqualDefinitionListNode
]

{ #category : #accessing }
ViennaDefExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaDefExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaDefExpressionNode >> label [

	^ 'DefExpression'
]

{ #category : #'pretty printing' }
ViennaDefExpressionNode >> operatorPrecedence [

	^ 10
]
