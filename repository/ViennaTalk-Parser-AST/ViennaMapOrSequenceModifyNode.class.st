Class {
	#name : #ViennaMapOrSequenceModifyNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

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

{ #category : #'pretty printing' }
ViennaMapOrSequenceModifyNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter override
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> isViennaMapOrSequenceModifyNode [

	^ true
]

{ #category : #accessing }
ViennaMapOrSequenceModifyNode >> label [

	^ 'MapOrSequenceModify'
]
