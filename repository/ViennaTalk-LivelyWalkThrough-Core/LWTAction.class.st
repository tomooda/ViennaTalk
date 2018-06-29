Class {
	#name : #LWTAction,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #printing }
LWTAction >> displayString [
	^ self subclassResponsibility
]

{ #category : #testing }
LWTAction >> isLAAction [
	^ true
]

{ #category : #testing }
LWTAction >> isLivetalkScriptAction [
	^ false
]

{ #category : #testing }
LWTAction >> isScriptAction [
	^ false
]

{ #category : #testing }
LWTAction >> isSmalltalkScriptAction [
	^ false
]

{ #category : #accessing }
LWTAction >> name [
	^ name
]

{ #category : #accessing }
LWTAction >> name: aString [
	name := aString
]

{ #category : #evaluating }
LWTAction >> value [
	^ self subclassResponsibility
]
