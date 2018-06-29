Class {
	#name : #WWTTranslationObjectMatcher,
	#superclass : #WWTTranslationMatcher,
	#instVars : [
		'object'
	],
	#category : 'ViennaTalk-WeblyWalkThrough-Translators'
}

{ #category : #'instance creation' }
WWTTranslationObjectMatcher class >> with: anObject [
	^ self new
		object: anObject;
		yourself
]

{ #category : #translating }
WWTTranslationObjectMatcher >> accept: anObject [
	^ anObject = object
		ifTrue: [ Dictionary new ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
WWTTranslationObjectMatcher >> allVariables [
	^ Array new
]

{ #category : #translating }
WWTTranslationObjectMatcher >> emit: aDictionary [
	^ object
]

{ #category : #accessing }
WWTTranslationObjectMatcher >> object [
	^ object
]

{ #category : #accessing }
WWTTranslationObjectMatcher >> object: anObject [
	object := anObject
]
