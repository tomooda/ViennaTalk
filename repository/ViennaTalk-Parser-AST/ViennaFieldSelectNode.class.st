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

{ #category : #'pretty printing' }
ViennaFieldSelectNode >> formatWith: aViennaAbstractFormatter [

	| record field |
	record := aViennaAbstractFormatter format: self expression.
	field := aViennaAbstractFormatter format: self field.
	^ record , '.' , field
]

{ #category : #'pretty printing' }
ViennaFieldSelectNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaFieldSelectNode >> isViennaFieldSelectNode [

	^ true
]

{ #category : #accessing }
ViennaFieldSelectNode >> label [

	^ 'FieldSelect'
]

{ #category : #'pretty printing' }
ViennaFieldSelectNode >> operatorPrecedence [

	^ 40
]
