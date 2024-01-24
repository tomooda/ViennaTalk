Class {
	#name : #ViennaSetTypeNode,
	#superclass : #ViennaUnaryTypeConstructorNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #converting }
ViennaSetTypeNode >> asMaximalViennaType [

	^ self type asMaximalViennaType set
]

{ #category : #'pretty printing' }
ViennaSetTypeNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter setPrefix
	  , (aViennaAbstractFormatter format: self type)
	  , aViennaAbstractFormatter setPostfix
]

{ #category : #testing }
ViennaSetTypeNode >> isViennaSetTypeNode [

	^ true
]

{ #category : #accessing }
ViennaSetTypeNode >> label [

	^ 'SetType'
]

{ #category : #'pretty printing' }
ViennaSetTypeNode >> operatorPrecedence [

	^ 5
]
