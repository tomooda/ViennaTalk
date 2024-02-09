Class {
	#name : #ViennaPatternBindNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaPatternBindNode class >> isAbstract [

	^ self = ViennaPatternBindNode
]

{ #category : #private }
ViennaPatternBindNode >> boundIdentifiersDo: aBlock [

	^ self subclassResponsibility
]

{ #category : #testing }
ViennaPatternBindNode >> isViennaPatternBindNode [

	^ true
]

{ #category : #testing }
ViennaPatternBindNode >> isViennaPatternHolderNode [

	^ true
]

{ #category : #typechecking }
ViennaPatternBindNode >> maximalType [

	^ self subclassResponsibility
]

{ #category : #typechecking }
ViennaPatternBindNode >> maximalType: aViennaType [

	maximalType := aViennaType
]

{ #category : #typechecking }
ViennaPatternBindNode >> typecheck [

	^ maximalType ifNil: [ maximalType := self maximalType ]
]

{ #category : #typechecking }
ViennaPatternBindNode >> typecheck: aViennaType [

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
