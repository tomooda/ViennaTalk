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

	maximalType := aViennaType
]

{ #category : #typechecking }
ViennaExpressionNode >> typecheck [

	^ maximalType ifNil: [ maximalType := self maximalType ]
]

{ #category : #typechecking }
ViennaExpressionNode >> typecheck: aViennaType [

	| type |
	type := self typecheck.
	^ (type isCompatibleWith: aViennaType)
		  ifTrue: [ type ]
		  ifFalse: [
			  ^ ViennaTypeError
				    on: self
				    signal:
					    'Type mismatch: expected ' , aViennaType printString
					    , ' but actual ' , type printString ]
]
