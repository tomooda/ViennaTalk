Class {
	#name : #ViennaSet1TypeNode,
	#superclass : #ViennaUnaryTypeConstructorNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #converting }
ViennaSet1TypeNode >> asMaximalViennaType [

	^ self type asMaximalViennaType set1
]

{ #category : #'pretty printing' }
ViennaSet1TypeNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter set1Prefix
	  , (aViennaAbstractFormatter format: self type)
	  , aViennaAbstractFormatter set1Postfix
]

{ #category : #testing }
ViennaSet1TypeNode >> isViennaSet1TypeNode [

	^ true
]

{ #category : #accessing }
ViennaSet1TypeNode >> label [

	^ 'Set1Type'
]

{ #category : #'pretty printing' }
ViennaSet1TypeNode >> operatorPrecedence [

	^ 5
]
