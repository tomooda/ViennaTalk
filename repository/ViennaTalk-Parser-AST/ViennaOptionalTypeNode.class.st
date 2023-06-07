Class {
	#name : #ViennaOptionalTypeNode,
	#superclass : #ViennaUnaryTypeConstructorNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaOptionalTypeNode >> formatWith: aViennaAbstractFormatter [

	^ '[' , (aViennaAbstractFormatter format: self type) , ']'
]

{ #category : #testing }
ViennaOptionalTypeNode >> isViennaOptionalTypeNode [

	^ true
]

{ #category : #accessing }
ViennaOptionalTypeNode >> label [

	^ 'OptionalType'
]
