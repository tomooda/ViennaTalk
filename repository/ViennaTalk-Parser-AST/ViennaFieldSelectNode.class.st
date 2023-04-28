Class {
	#name : #ViennaFieldSelectNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaFieldSelectNode class >> expression: aViennaExpression field: aString [

	^ (self new: 2)
		  expression: aViennaExpression;
		  field: aString;
		  yourself
]

{ #category : #accessing }
ViennaFieldSelectNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaFieldSelectNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaFieldSelectNode >> field [

	^ self at: 2
]

{ #category : #accessing }
ViennaFieldSelectNode >> field: aString [

	self at: 2 put: aString
]

{ #category : #accessing }
ViennaFieldSelectNode >> label [

	^ 'FieldSelect'
]
