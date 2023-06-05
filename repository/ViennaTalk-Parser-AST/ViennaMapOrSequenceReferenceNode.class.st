Class {
	#name : #ViennaMapOrSequenceReferenceNode,
	#superclass : #ViennaStateDesignatorNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaMapOrSequenceReferenceNode class >> expression: aViennaExpressionNode1 argumentExpression: aViennaExpressionNode2 [

	^ (self new: 2)
		  expression: aViennaExpressionNode1;
		  argumentExpression: aViennaExpressionNode2;
		  yourself
]

{ #category : #accessing }
ViennaMapOrSequenceReferenceNode >> argumentExpression [

	^ self at: 2
]

{ #category : #accessing }
ViennaMapOrSequenceReferenceNode >> argumentExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaMapOrSequenceReferenceNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaMapOrSequenceReferenceNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaMapOrSequenceReferenceNode >> formatWith: aViennaAbstractFormatter [

	| ref arg |
	ref := aViennaAbstractFormatter format: self first.
	arg := aViennaAbstractFormatter format: self second.
	^ (aViennaAbstractFormatter needsIndent: ref , arg)
		  ifTrue: [
			  ref , String cr , aViennaAbstractFormatter indent
			  , (aViennaAbstractFormatter indentString: '(' , arg , ')') ]
		  ifFalse: [ ref , '(' , arg , ')' ]
]

{ #category : #'pretty printing' }
ViennaMapOrSequenceReferenceNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #accessing }
ViennaMapOrSequenceReferenceNode >> isViennaMapOrSequenceReferenceNode [

	^ true
]

{ #category : #accessing }
ViennaMapOrSequenceReferenceNode >> label [

	^ 'MapOrSequenceReference'
]

{ #category : #'pretty printing' }
ViennaMapOrSequenceReferenceNode >> operatorPrecedence [

	^ 31
]
