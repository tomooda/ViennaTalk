Class {
	#name : #ViennaSequenceComprehensionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaSequenceComprehensionNode class >> expression: aViennaExpressionNode1 setSeqBind: aViennaSetSeqBindNode suchthatExpression: aViennaExpressionNode2 [

	^ (self new: 3)
		  expression: aViennaExpressionNode1;
		  setSeqBind: aViennaSetSeqBindNode;
		  suchthatExpression: aViennaExpressionNode2;
		  yourself
]

{ #category : #accessing }
ViennaSequenceComprehensionNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaSequenceComprehensionNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaSequenceComprehensionNode >> label [

	^ 'SequenceComprehension'
]

{ #category : #accessing }
ViennaSequenceComprehensionNode >> setSeqBind [

	^ self at: 2
]

{ #category : #accessing }
ViennaSequenceComprehensionNode >> setSeqBind: aViennaSetSeqBindNode [

	self at: 2 put: aViennaSetSeqBindNode
]

{ #category : #accessing }
ViennaSequenceComprehensionNode >> suchthatExpression [

	^ self at: 3
]

{ #category : #accessing }
ViennaSequenceComprehensionNode >> suchthatExpression: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]