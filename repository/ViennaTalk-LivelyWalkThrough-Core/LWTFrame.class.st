Class {
	#name : 'LWTFrame',
	#superclass : 'Object',
	#instVars : [
		'timestamp'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core',
	#package : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : 'menu' }
LWTFrame >> addFrameMenu: aMenu [
	"add nothing by default"
]

{ #category : 'testing' }
LWTFrame >> hasBrowser [
	^ true
]

{ #category : 'initialize-release' }
LWTFrame >> initialize [
	super initialize.
	timestamp := DateAndTime now
]

{ #category : 'testing' }
LWTFrame >> isEventFrame [
	^ false
]

{ #category : 'testing' }
LWTFrame >> isVDMCallFrame [
	^ false
]

{ #category : 'testing' }
LWTFrame >> isVDMStateFrame [
	^ false
]

{ #category : 'interface opening' }
LWTFrame >> openBrowser [
	^ self subclassResponsibility
]

{ #category : 'printing' }
LWTFrame >> printOn: aStream [
	self subclassResponsibility
]

{ #category : 'accessing' }
LWTFrame >> timestamp [
	^ timestamp
]
