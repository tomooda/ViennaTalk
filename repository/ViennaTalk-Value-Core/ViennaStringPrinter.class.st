Class {
	#name : #ViennaStringPrinter,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'value'
	],
	#category : 'ViennaTalk-Value-Core'
}

{ #category : #'instance creation' }
ViennaStringPrinter class >> on: anObject [
	^ self new
		value: anObject;
		yourself
]

{ #category : #printing }
ViennaStringPrinter >> printOn: aStream [
	value viennaStringOn: aStream
]

{ #category : #accessing }
ViennaStringPrinter >> value [
	^ value
]

{ #category : #accessing }
ViennaStringPrinter >> value: anObject [
	value := anObject
]
