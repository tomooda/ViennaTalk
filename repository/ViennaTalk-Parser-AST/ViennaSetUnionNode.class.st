Class {
	#name : #ViennaSetUnionNode,
	#superclass : #ViennaBinaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSetUnionNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter union
]

{ #category : #accessing }
ViennaSetUnionNode >> isViennaSetUnionNode [

	^ true
]

{ #category : #accessing }
ViennaSetUnionNode >> label [

	^ 'SetUnion'
]

{ #category : #'pretty printing' }
ViennaSetUnionNode >> operatorPrecedence [

	^ 31
]

{ #category : #accessing }
ViennaSetUnionNode >> paramType1 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaSetUnionNode >> paramType2 [

	^ ViennaType any set
]

{ #category : #accessing }
ViennaSetUnionNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	| basetype |
	basetype := aViennaType1 basetype >= aViennaType2 basetype
		            ifTrue: [ aViennaType1 basetype ]
		            ifFalse: [
			            aViennaType2 basetype >= aViennaType1 basetype
				            ifTrue: [ aViennaType2 basetype ]
				            ifFalse: [
				            aViennaType1 basetype | aViennaType2 basetype ] ].
	^ (aViennaType1 isSet1Type or: [ aViennaType2 isSet1Type ])
		  ifTrue: [ basetype set1 ]
		  ifFalse: [ basetype set ]
]
