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
ViennaExpressionNode >> maximalType [

	^ self subclassResponsibility
]

{ #category : #typechecking }
ViennaExpressionNode >> maximalType: aViennaType [

	super maximalType: self maximalType.
	(maximalType isCompatibleWith: aViennaType) ifFalse: [
		^ ViennaTypeError
			  on: self
			  signal:
				  'Type mismatch: expected ' , aViennaType printString
				  , ' but actual ' , maximalType printString ]
]

{ #category : #accessing }
ViennaExpressionNode >> parser [

	^ ViennaVDMParser new expression end
]

{ #category : #typechecking }
ViennaExpressionNode >> typecheck [

	^ super typecheck ifUnit: [
		  ViennaTypeError
			  on: self
			  signal: 'An expression can not be of unit type' ]
]

{ #category : #typechecking }
ViennaExpressionNode >> typecheck: aViennaType [

	maximalType ifNil: [ self maximalType: aViennaType ].
	^ super typecheck: aViennaType
]
