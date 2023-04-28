Class {
	#name : #ViennaTupleSelectNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTupleSelectNode class >> expression: aViennaExpressionNode index: aString [

	^ (self new: 2)
		  expression: aViennaExpressionNode;
		  index: aString;
		  yourself
]

{ #category : #accessing }
ViennaTupleSelectNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaTupleSelectNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaTupleSelectNode >> index [

	^ self at: 2
]

{ #category : #accessing }
ViennaTupleSelectNode >> index: aString [

	self at: 2 put: aString
]

{ #category : #accessing }
ViennaTupleSelectNode >> label [

	^ 'TupleSelect'
]
