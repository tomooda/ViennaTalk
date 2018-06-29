Class {
	#name : #WWTTranslationMapMatcher,
	#superclass : #WWTTranslationMatcher,
	#instVars : [
		'matchers'
	],
	#category : 'ViennaTalk-WeblyWalkThrough-Translators'
}

{ #category : #'instance creation' }
WWTTranslationMapMatcher class >> from: aDictionaryOfStringToMatcher [
	^ self new
		matchers: (Array withAll: aDictionaryOfStringToMatcher associations);
		yourself
]

{ #category : #translating }
WWTTranslationMapMatcher >> accept: anObject [
	| binds |
	anObject isDictionary
		ifFalse: [ ^ nil ].
	(matchers contains: [ :assoc | (anObject includesKey: assoc key) not ])
		ifTrue: [ ^ nil ].
	binds := Dictionary new.
	matchers
		do: [ :assoc | 
			| field matcher |
			field := assoc key.
			matcher := assoc value.
			((matcher accept: (anObject at: field)) ifNil: [ ^ nil ]) keysAndValuesDo: [ :var :val | binds at: var put: val ] ].
	^ binds
]

{ #category : #accessing }
WWTTranslationMapMatcher >> allVariables [
	^ matchers inject: #() into: [ :vars :assoc | vars , assoc value allVariables ]
]

{ #category : #translating }
WWTTranslationMapMatcher >> emit: aDictionary [
	^ (matchers
		collect: [ :assoc | 
			| field matcher vars localBinds |
			field := assoc key.
			matcher := assoc value.
			vars := matcher allVariables.
			localBinds := Dictionary new: vars size.
			vars do: [ :var | localBinds at: var put: (aDictionary at: var) ].
			field -> (matcher emit: localBinds) ]) asDictionary
]

{ #category : #accessing }
WWTTranslationMapMatcher >> matchers [
	^ matchers
]

{ #category : #accessing }
WWTTranslationMapMatcher >> matchers: anArrayOfStringToMatcher [
	matchers := anArrayOfStringToMatcher
]
