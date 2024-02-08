Class {
	#name : #ViennaUnitType,
	#superclass : #ViennaBasicType,
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaUnitType class >> precedence [
	^ 6
]

{ #category : #arithmetic }
ViennaUnitType >> & aViennaType [

	^ self
]

{ #category : #arithmetic }
ViennaUnitType >> * aViennaType [

	^ self
]

{ #category : #arithmetic }
ViennaUnitType >> + aViennaType [

	^ aViennaType
]

{ #category : #arithmetic }
ViennaUnitType >> +> aViennaType [

	^ aViennaType isUnitType
		  ifTrue: [ ViennaType unit ]
		  ifFalse: [
		  ViennaTotalFunctionType withAll: Array new with: aViennaType ]
]

{ #category : #arithmetic }
ViennaUnitType >> -> aViennaType [

	^ aViennaType isUnitType
		  ifTrue: [ ViennaType unit ]
		  ifFalse: [
		  ViennaPartialFunctionType withAll: Array new with: aViennaType ]
]

{ #category : #comparing }
ViennaUnitType >> = anObject [
	^ self class = anObject class
]

{ #category : #arithmetic }
ViennaUnitType >> ==> aViennaType [

	^ ViennaOperationType withAll: Array new with: aViennaType
]

{ #category : #arithmetic }
ViennaUnitType >> >= aViennaType [

	^ aViennaType isUnitType
]

{ #category : #enumerating }
ViennaUnitType >> basicDo: aBlock [

	
]

{ #category : #testing }
ViennaUnitType >> basicIncludes: anObject [

	^ false
]

{ #category : #testing }
ViennaUnitType >> basicIsEnumerable [
	^ true
]

{ #category : #controling }
ViennaUnitType >> ifNotUnit: aBlock [
]

{ #category : #controling }
ViennaUnitType >> ifNotUnit: aBlock ifUnit: anotherBlock [

	^ anotherBlock cull: self
]

{ #category : #controling }
ViennaUnitType >> ifUnit: aBlock [

	aBlock cull: self
]

{ #category : #controling }
ViennaUnitType >> ifUnit: aBlock ifNotUnit: anotherBlock [

	^ aBlock cull: self
]

{ #category : #testing }
ViennaUnitType >> isCompatibleWith: aViennaType [

	^ self = aViennaType or: [
		  (aViennaType isChoiceType or: [ aViennaType isConstrainedType ])
			  and: [ aViennaType isCompatibleWith: self ] ]
]

{ #category : #testing }
ViennaUnitType >> isUnitType [

	^ true
]

{ #category : #accessing }
ViennaUnitType >> name [
	^ '()'
]

{ #category : #enumerating }
ViennaUnitType >> possibleTypesDo: aBlock [

	
]

{ #category : #arithmetic }
ViennaUnitType >> seq1 [

	^ self
]

{ #category : #arithmetic }
ViennaUnitType >> set1 [

	^ self
]

{ #category : #arithmetic }
ViennaUnitType >> | aViennaType [

	^ aViennaType
]
