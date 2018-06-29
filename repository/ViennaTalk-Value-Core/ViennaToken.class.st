Class {
	#name : #ViennaToken,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'value'
	],
	#category : 'ViennaTalk-Value-Core'
}

{ #category : #'instance creation' }
ViennaToken class >> with: anObject [
	^ self new
		setValue: anObject;
		yourself
]

{ #category : #comparing }
ViennaToken >> = anObject [
	^ self class == anObject class and: [ value = anObject value ]
]

{ #category : #comparing }
ViennaToken >> hash [
	^ value hash
]

{ #category : #private }
ViennaToken >> setValue: anObject [
	value := anObject
]

{ #category : #accessing }
ViennaToken >> value [
	^ value
]
