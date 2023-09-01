Class {
	#name : #ViennaMapEnumerationNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapEnumerationNode >> formatWith: aViennaAbstractFormatter [

	| elements |
	elements := aViennaAbstractFormatter formatAll: self.
	^ '{' , (aViennaAbstractFormatter
		   formatEnumerate: elements
		   ifEmpty: [ aViennaAbstractFormatter maplet ]) , '}'
]

{ #category : #private }
ViennaMapEnumerationNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :maplet | maplet freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #accessing }
ViennaMapEnumerationNode >> isViennaMapEnumerationNode [

	^ true
]

{ #category : #accessing }
ViennaMapEnumerationNode >> label [

	^ 'MapEnumeration'
]
