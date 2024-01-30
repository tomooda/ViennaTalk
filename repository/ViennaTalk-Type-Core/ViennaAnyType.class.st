Class {
	#name : #ViennaAnyType,
	#superclass : #ViennaBasicType,
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaAnyType class >> precedence [
	^ 6
]

{ #category : #comparing }
ViennaAnyType >> = anObject [
	^ self class = anObject class
]

{ #category : #comparing }
ViennaAnyType >> >= anObject [
	^ true
]

{ #category : #enumerating }
ViennaAnyType >> basicDo: aBlock [
	^ self shouldNotImplement
]

{ #category : #testing }
ViennaAnyType >> basicIncludes: anObject [
	^ true
]

{ #category : #testing }
ViennaAnyType >> basicIsEnumerable [
	^ false
]

{ #category : #comparing }
ViennaAnyType >> hash [
	^ self class hash
]

{ #category : #testing }
ViennaAnyType >> isCompatibleWith: aViennaType [

	^ aViennaType isUnitType not
]

{ #category : #accessing }
ViennaAnyType >> name [
	^ '?'
]
