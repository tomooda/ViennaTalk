Class {
	#name : #WWTTranslationDictionaryMatcher,
	#superclass : #WWTTranslationMatcher,
	#instVars : [
		'keyMatcher',
		'valueMatcher'
	],
	#category : 'ViennaTalk-WeblyWalkThrough-Translators'
}

{ #category : #'instance creation' }
WWTTranslationDictionaryMatcher class >> key: aWWTTranslationMatcher1 value: aWWTTranslationMatcher2 [
	^ self new
		keyMatcher: aWWTTranslationMatcher1;
		valueMatcher: aWWTTranslationMatcher2;
		yourself
]

{ #category : #translating }
WWTTranslationDictionaryMatcher >> accept: anObject [
	| associations binds |
	anObject isDictionary
		ifFalse: [ ^ nil ].
	associations := anObject associations asArray.
	binds := Dictionary new.
	associations
		do: [ :assoc | 
			((keyMatcher accept: assoc key) ifNil: [ ^ nil ])
				keysAndValuesDo: [ :var :val | (binds at: var ifAbsentPut: [ OrderedCollection new ]) add: val ].
			((valueMatcher accept: assoc value) ifNil: [ ^ nil ])
				keysAndValuesDo: [ :var :val | (binds at: var ifAbsentPut: [ OrderedCollection new ]) add: val ] ].
	^ binds
]

{ #category : #accessing }
WWTTranslationDictionaryMatcher >> allVariables [
	^ keyMatcher allVariables , valueMatcher allVariables
]

{ #category : #translating }
WWTTranslationDictionaryMatcher >> emit: aDictionary [
	| binds sizes |
	binds := Dictionary new.
	self allVariables do: [ :var | binds at: var put: (aDictionary at: var) ].
	sizes := (binds values collect: #size) asSet asArray.
	^ sizes size = 1
		ifTrue: [ 
			| keyVars valueVars |
			keyVars := keyMatcher allVariables.
			valueVars := valueMatcher allVariables.
			((1 to: sizes first)
				collect: [ :index | 
					| keyBinds valueBinds |
					keyBinds := Dictionary new: binds size.
					valueBinds := Dictionary new: binds size.
					keyVars do: [ :var :vals | keyBinds at: var put: ((binds at: var) at: index) ].
					valueVars do: [ :var :vals | valueBinds at: var put: ((binds at: var) at: index) ].
					(keyMatcher emit: keyBinds) -> (valueMatcher emit: valueBinds) ]) asDictionary ]
]

{ #category : #accessing }
WWTTranslationDictionaryMatcher >> keyMatcher [
	^ keyMatcher
]

{ #category : #accessing }
WWTTranslationDictionaryMatcher >> keyMatcher: aWWTTranslationMatcher [
	keyMatcher := aWWTTranslationMatcher
]

{ #category : #accessing }
WWTTranslationDictionaryMatcher >> valueMatcher [
	^ valueMatcher
]

{ #category : #accessing }
WWTTranslationDictionaryMatcher >> valueMatcher: aWWTTranslationMatcher [
	valueMatcher := aWWTTranslationMatcher
]
