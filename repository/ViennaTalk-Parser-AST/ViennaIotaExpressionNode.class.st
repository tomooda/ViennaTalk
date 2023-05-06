Class {
	#name : #ViennaIotaExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaIotaExpressionNode class >> bind: aViennaBindNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  bind: aViennaBindNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaIotaExpressionNode >> bind [

	^ self at: 1
]

{ #category : #accessing }
ViennaIotaExpressionNode >> bind: aViennaBindNode [

	self at: 1 put: aViennaBindNode
]

{ #category : #accessing }
ViennaIotaExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaIotaExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaIotaExpressionNode >> label [

	^ 'IotaExpression'
]

{ #category : #'pretty printing' }
ViennaIotaExpressionNode >> operatorPrecedence [

	^ 30
]
