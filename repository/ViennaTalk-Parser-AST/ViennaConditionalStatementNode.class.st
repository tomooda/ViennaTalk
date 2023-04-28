Class {
	#name : #ViennaConditionalStatementNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaConditionalStatementNode class >> condition: aViennaExpressionNode statement: aViennaStatementNode [

	^ (self new: 2)
		  condition: aViennaExpressionNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #accessing }
ViennaConditionalStatementNode >> condition [

	^ self at: 1
]

{ #category : #accessing }
ViennaConditionalStatementNode >> condition: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaConditionalStatementNode >> label [

	^ 'ConditionalStatement'
]

{ #category : #accessing }
ViennaConditionalStatementNode >> statement [

	^ self at: 2
]

{ #category : #accessing }
ViennaConditionalStatementNode >> statement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]
