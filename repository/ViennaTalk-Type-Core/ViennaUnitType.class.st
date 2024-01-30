Class {
	#name : #ViennaUnitType,
	#superclass : #ViennaBasicType,
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaUnitType class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaUnitType >> = anObject [
	^ self class = anObject class
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
ViennaUnitType >> isUnitType [

	^ true
]

{ #category : #accessing }
ViennaUnitType >> name [
	^ '()'
]
