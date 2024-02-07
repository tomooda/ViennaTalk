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
ViennaUnitType >> + aViennaType [

	^ aViennaType
]

{ #category : #comparing }
ViennaUnitType >> = anObject [
	^ self class = anObject class
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
ViennaUnitType >> | aViennaType [

	^ aViennaType
]
