Class {
	#name : #WWTTranslationBindingMatcher,
	#superclass : #WWTTranslationMatcher,
	#instVars : [
		'variable'
	],
	#category : 'ViennaTalk-WeblyWalkThrough-Translators'
}

{ #category : #'instance creation' }
WWTTranslationBindingMatcher class >> variable: aString [
	^ self new
		variable: aString;
		yourself
]

{ #category : #translating }
WWTTranslationBindingMatcher >> accept: anObject [
	^ Dictionary new
		at: variable put: anObject;
		yourself
]

{ #category : #accessing }
WWTTranslationBindingMatcher >> allVariables [
	^ Array with: variable
]

{ #category : #translating }
WWTTranslationBindingMatcher >> emit: aDictionary [
	^ aDictionary at: variable
]

{ #category : #accessing }
WWTTranslationBindingMatcher >> variable [
	^ variable
]

{ #category : #accessing }
WWTTranslationBindingMatcher >> variable: aString [
	variable := aString
]
