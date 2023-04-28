Class {
	#name : #ViennaMapOrSequenceModifyNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaMapOrSequenceModifyNode class >> expression: aViennaExpressionNode1 expression: aViennaExpressionNode2 [

	^ (self new: 2)
		  expression1: aViennaExpressionNode1;
		  expression1: aViennaExpressionNode2;
		  yourself
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> expression1 [

	^ self at: 1
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> expression1: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> expression2 [

	^ self at: 2
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> expression2: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> label [

	^ 'MapOrSequenceModify'
]
