Class {
	#name : #LWTVDMStateFrame,
	#superclass : #LWTFrame,
	#instVars : [
		'states'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #'instance creation' }
LWTVDMStateFrame class >> states: aDictionaryOfBindings [ 
	^ self new states: aDictionaryOfBindings;
		 yourself
]

{ #category : #testing }
LWTVDMStateFrame >> isVDMStateFrame [
	^ true
]

{ #category : #'interface opening' }
LWTVDMStateFrame >> openBrowser [
	^ ViennaBrowser open
]

{ #category : #printing }
LWTVDMStateFrame >> printOn: aStream [ 
	timestamp printOn: aStream.
	aStream nextPutAll: ' : State : {'.
	states keys asSortedCollection
		do: [:module | 
			aStream nextPutAll: module;
				 nextPutAll: ': {'.
			(states at: module)
				do: [:binding | aStream nextPutAll: binding key;
						 nextPut: $:;
						 nextPutAll: binding value]
				separatedBy: [aStream nextPut: $,].
			aStream nextPutAll: '}']
		separatedBy: [aStream nextPutAll: ', '].
	aStream nextPutAll: '}'
]

{ #category : #accessing }
LWTVDMStateFrame >> states [
	^ states
]

{ #category : #accessing }
LWTVDMStateFrame >> states: aDictionaryOfBindings [
	states := aDictionaryOfBindings
]
