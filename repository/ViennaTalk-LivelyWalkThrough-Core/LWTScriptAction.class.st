Class {
	#name : #LWTScriptAction,
	#superclass : #LWTAction,
	#instVars : [
		'source'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #printing }
LWTScriptAction >> displayString [
	^ source copy
]

{ #category : #testing }
LWTScriptAction >> isScriptAction [
	^ true
]

{ #category : #accessing }
LWTScriptAction >> source [
	^ source copy
]

{ #category : #accessing }
LWTScriptAction >> source: aString [
	source := aString
]
