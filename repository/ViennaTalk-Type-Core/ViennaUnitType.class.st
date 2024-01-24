Class {
	#name : #ViennaUnitType,
	#superclass : #ViennaType,
	#category : #'ViennaTalk-Type-Core'
}

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

{ #category : #accessing }
ViennaUnitType >> name [
	^ '()'
]
