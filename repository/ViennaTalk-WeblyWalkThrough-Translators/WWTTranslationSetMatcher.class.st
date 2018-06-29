Class {
	#name : #WWTTranslationSetMatcher,
	#superclass : #WWTTranslationMatcher,
	#instVars : [
		'elementMatcher'
	],
	#category : 'ViennaTalk-WeblyWalkThrough-Translators'
}

{ #category : #'instance creation' }
WWTTranslationSetMatcher class >> with: aWWTTranslationMatcher [
	^ self new
		elementMatcher: aWWTTranslationMatcher;
		yourself
]

{ #category : #translating }
WWTTranslationSetMatcher >> accept: anObject [
	| binds |
	anObject isArray
		ifFalse: [ ^ nil ].
	binds := Dictionary new.
	anObject
		do: [ :element | 
			((elementMatcher accept: element) ifNil: [ ^ nil ])
				keysAndValuesDo: [ :var :val | (binds at: var ifAbsentPut: [ OrderedCollection new ]) add: val ] ].
	^ binds
]

{ #category : #accessing }
WWTTranslationSetMatcher >> allVariables [
	^ elementMatcher allVariables
]

{ #category : #accessing }
WWTTranslationSetMatcher >> elementMatcher [
	^ elementMatcher
]

{ #category : #accessing }
WWTTranslationSetMatcher >> elementMatcher: aWWTTranslationMatcher [
	elementMatcher := aWWTTranslationMatcher
]

{ #category : #translating }
WWTTranslationSetMatcher >> emit: aDictionary [
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
					elementMatcher emit: localBind ]) asSet ]
]
