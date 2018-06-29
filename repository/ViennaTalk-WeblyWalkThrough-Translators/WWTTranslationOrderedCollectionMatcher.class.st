Class {
	#name : #WWTTranslationOrderedCollectionMatcher,
	#superclass : #WWTTranslationMatcher,
	#instVars : [
		'elementMatcher'
	],
	#category : 'ViennaTalk-WeblyWalkThrough-Translators'
}

{ #category : #'instance creation' }
WWTTranslationOrderedCollectionMatcher class >> with: aWWTTranslationMatcher [
	^ self new
		elementMatcher: aWWTTranslationMatcher;
		yourself
]

{ #category : #translating }
WWTTranslationOrderedCollectionMatcher >> accept: anObject [
	| binds |
	anObject isSequence
		ifFalse: [ ^ nil ].
	binds := Dictionary new.
	anObject
		do: [ :element | 
			((elementMatcher accept: element) ifNil: [ ^ nil ])
				keysAndValuesDo: [ :var :val | (binds at: var ifAbsentPut: [ OrderedCollection new ]) add: val ] ].
	^ binds
]

{ #category : #accessing }
WWTTranslationOrderedCollectionMatcher >> allVariables [
	^ elementMatcher allVariables
]

{ #category : #accessing }
WWTTranslationOrderedCollectionMatcher >> elementMatcher [
	^ elementMatcher
]

{ #category : #accessing }
WWTTranslationOrderedCollectionMatcher >> elementMatcher: aWWTTranslationMatcher [
	elementMatcher := aWWTTranslationMatcher
]

{ #category : #translating }
WWTTranslationOrderedCollectionMatcher >> emit: aDictionary [
	| binds sizes |
	binds := Dictionary new.
	self allVariables do: [ :var | binds at: var put: (aDictionary at: var) ].
	sizes := (binds values collect: #size) asSet asArray.
	^ sizes size = 1
		ifTrue: [ 
			((1 to: sizes first)
				collect: [ :index | 
					| localBind |
					localBind := Dictionary new: binds size.
					binds keysAndValuesDo: [ :var :vals | localBind at: var put: (vals at: index) ].
					elementMatcher emit: localBind ]) asOrderedCollection ]
]
