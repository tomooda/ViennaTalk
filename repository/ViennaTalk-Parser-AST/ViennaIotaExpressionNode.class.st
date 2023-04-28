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

{ #category : #'parsers-patterns' }
ViennaIotaExpressionNode >> bind [

	^ self at: 1
]

{ #category : #'parsers-patterns' }
ViennaIotaExpressionNode >> bind: aViennaBindNode [

	self at: 1 put: aViennaBindNode
]

{ #category : #'parsers-patterns' }
ViennaIotaExpressionNode >> expression [

	^ self at: 2
]

{ #category : #'parsers-patterns' }
ViennaIotaExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaIotaExpressionNode >> label [

	^ 'IotaExpression'
]
