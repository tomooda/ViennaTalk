Class {
	#name : #ViennaExpressionNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaExpressionNode class >> isAbstract [

	^ self = ViennaExpressionNode
]

{ #category : #private }
ViennaExpressionNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #testing }
ViennaExpressionNode >> isViennaExpressionNode [
	^ true
]

{ #category : #typechecking }
ViennaExpressionNode >> typecheck [

	^ super typecheck ifUnit: [
		  ViennaTypeError
			  on: self
			  signal: 'An expression can not be of unit type' ]
]
