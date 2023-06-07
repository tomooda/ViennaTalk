Class {
	#name : #ViennaProductTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaProductTypeNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  formatEnumerate: (aViennaAbstractFormatter formatAll: self)
		  separator: aViennaAbstractFormatter mul
		  ifEmpty: [ '' ]
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
