Class {
	#name : #ViennaProductTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #converting }
ViennaProductTypeNode >> asMaximalViennaType [

	^ ViennaType product: (self collect: #asMaximalViennaType)
]

{ #category : #'pretty printing' }
ViennaProductTypeNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  formatEnumerate: (aViennaAbstractFormatter formatAll: self)
		  separator: aViennaAbstractFormatter mul
		  ifEmpty: [ '' ]
]

{ #category : #private }
ViennaProductTypeNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :type | type freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaProductTypeNode >> isViennaProductTypeNode [

	^ true
]

{ #category : #accessing }
ViennaProductTypeNode >> label [

	^ 'ProductType'
]

{ #category : #'pretty printing' }
ViennaProductTypeNode >> operatorPrecedence [

	^ 3
]
