Class {
	#name : #WWTTranslationArrayMatcher,
	#superclass : #WWTTranslationMatcher,
	#instVars : [
		'elementMatchers'
	],
	#category : 'ViennaTalk-WeblyWalkThrough-Translators'
}

{ #category : #'instance creation' }
WWTTranslationArrayMatcher class >> withAll: anArrayOfWWTTranslationMatcher [
	^ self new
		elementMatchers: anArrayOfWWTTranslationMatcher;
		yourself
]

{ #category : #translating }
WWTTranslationArrayMatcher >> accept: anObject [
	| binds |
	anObject isArray
		ifFalse: [ ^ nil ].
	binds := Dictionary new.
	1 to: elementMatchers size do: [ :index | 
		(((elementMatchers at: index) accept: (anObject at: index)) ifNil: [ ^ nil ])
			keysAndValuesDo: [ :var :val | binds at: var put: val ] ].
	^ binds
]

{ #category : #accessing }
WWTTranslationArrayMatcher >> allVariables [
	^ elementMatchers inject: #() into: [ :vars :matcher | vars , matcher allVariables ]
]

{ #category : #accessing }
WWTTranslationArrayMatcher >> elementMatchers [
	^ elementMatchers
]

{ #category : #accessing }
WWTTranslationArrayMatcher >> elementMatchers: anArrayOfWWTTranslationMatcher [
	elementMatchers := anArrayOfWWTTranslationMatcher
]

{ #category : #translating }
WWTTranslationArrayMatcher >> emit: aDictionary [
	^ elementMatchers
		collect: [ :matcher | 
			| vars localBinds |
			vars := matcher allVariables.
			localBinds := Dictionary new: vars size.
			vars do: [ :var | localBinds at: var put: (aDictionary at: var) ].
			matcher emit: localBinds ]
]
