Class {
	#name : #ViennaMapOrSequenceReferenceNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

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
ViennaMapOrSequenceReferenceNode >> label [

	^ 'MapOrSequenceReference'
]

{ #category : #'pretty printing' }
ViennaMapOrSequenceReferenceNode >> operatorPrecedence [

	^ 31
]
