Class {
	#name : #ViennaTypeJudgementNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTypeJudgementNode class >> expression: aViennaExpressionNode type: aViennaTypeNode [

	^ (self new: 2)
		  expression: aViennaExpressionNode;
		  type: aViennaTypeNode;
		  yourself
]

{ #category : #accessing }
ViennaTypeJudgementNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeJudgementNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaTypeJudgementNode >> label [

	^ 'TypeJudgement'
]

{ #category : #accessing }
ViennaTypeJudgementNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaTypeJudgementNode >> type: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
