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

{ #category : #accessing }
ViennaPatternBindNode >> maximalType [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaPatternBindNode >> maximalType: aViennaType [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaPatternBindNode >> typecheck [

	^ self maximalType
]

{ #category : #accessing }
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
