Class {
	#name : #ViennaExists1ExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaExists1ExpressionNode class >> bind: aViennaBindNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  bind: aViennaBindNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #'parsers-patterns' }
ViennaExists1ExpressionNode >> bind [

	^ self at: 1
]

{ #category : #'parsers-patterns' }
ViennaExists1ExpressionNode >> bind: aViennaBindNode [

	self at: 1 put: aViennaBindNode
]

{ #category : #'parsers-patterns' }
ViennaExists1ExpressionNode >> edxpression [

	^ self at: 2
]

{ #category : #'parsers-patterns' }
ViennaExists1ExpressionNode >> edxpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExists1ExpressionNode >> label [

	^ 'Exists1Expression'
]
