Class {
	#name : #WWTTranslationCompositeMatcher,
	#superclass : #WWTTranslationMatcher,
	#instVars : [
		'constructorName',
		'memberMatchers'
	],
	#category : 'ViennaTalk-WeblyWalkThrough-Translators'
}

{ #category : #'instance creation' }
WWTTranslationCompositeMatcher class >> constructor: aString withAll: anArrayOfWWTTranslationMatcher [
	^ self new
		constructorName: aString;
		memberMatchers: anArrayOfWWTTranslationMatcher;
		yourself
]

{ #category : #translating }
WWTTranslationCompositeMatcher >> accept: anObject [
	| binds |
	(anObject isViennaComposite and: [ anObject constructorName = constructorName ])
		ifFalse: [ ^ nil ].
	binds := Dictionary new.
	1 to: memberMatchers size do: [ :index | 
		(((memberMatchers at: index) accept: (anObject at: index)) ifNil: [ ^ nil ])
			keysAndValuesDo: [ :var :val | binds at: var put: val ] ].
	^ binds
]

{ #category : #accessing }
WWTTranslationCompositeMatcher >> allVariables [
	^ memberMatchers inject: #() into: [ :vars :matcher | vars , matcher allVariables ]
]

{ #category : #accessing }
WWTTranslationCompositeMatcher >> constructorName [
	^ constructorName
]

{ #category : #accessing }
WWTTranslationCompositeMatcher >> constructorName: aString [
	constructorName := aString
]

{ #category : #translating }
WWTTranslationCompositeMatcher >> emit: aDictionary [
	^ ViennaComposite
		constructorName: constructorName
		withAll:
			(memberMatchers
				collect: [ :matcher | 
					| vars localBinds |
					vars := matcher allVariables.
					localBinds := Dictionary new: vars size.
					vars do: [ :var | localBinds at: var put: (aDictionary at: var) ].
					matcher emit: localBinds ])
]

{ #category : #accessing }
WWTTranslationCompositeMatcher >> memberMatchers [
	^ memberMatchers
]

{ #category : #accessing }
WWTTranslationCompositeMatcher >> memberMatchers: anArrayOfWWTTranslationMatcher [
	memberMatchers := anArrayOfWWTTranslationMatcher
]
