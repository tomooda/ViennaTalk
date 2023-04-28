Class {
	#name : #ViennaLetExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaLetExpressionNode class >> localDefinitionList: aViennaLocalDefinitionListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  localDefinitionList: aViennaLocalDefinitionListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #'parsers-definitions' }
ViennaLetExpressionNode >> expression [

	^ self at: 2
]

{ #category : #'parsers-definitions' }
ViennaLetExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaLetExpressionNode >> label [

	^ 'LetExpression'
]

{ #category : #'parsers-definitions' }
ViennaLetExpressionNode >> localDefinitionList [

	^ self at: 1
]

{ #category : #'parsers-definitions' }
ViennaLetExpressionNode >> localDefinitionList: aViennaLocalDefinitionListNode [

	self at: 1 put: aViennaLocalDefinitionListNode
]
