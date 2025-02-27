Class {
	#name : 'LWTEventFrame',
	#superclass : 'LWTFrame',
	#instVars : [
		'morphName',
		'event'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core',
	#package : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : 'instance creation' }
LWTEventFrame class >> morphName: aString event: aSymbol [ 
	^ self new morphName: aString;
		 event: aSymbol;
		 yourself
]

{ #category : 'accessing' }
LWTEventFrame >> event [
	^ event
]

{ #category : 'accessing' }
LWTEventFrame >> event: aSymbol [
	event := aSymbol asSymbol
]

{ #category : 'testing' }
LWTEventFrame >> isEventFrame [
	^ true
]

{ #category : 'accessing' }
LWTEventFrame >> morphName [
	^ morphName
]

{ #category : 'accessing' }
LWTEventFrame >> morphName: aString [
	morphName := aString asString
]

{ #category : 'interface opening' }
LWTEventFrame >> openBrowser [

	
]

{ #category : 'printing' }
LWTEventFrame >> printOn: aStream [
	timestamp printOn: aStream.
	aStream nextPutAll: ' : EVENT : ['.
	aStream nextPutAll: morphName.
	aStream nextPutAll: ']'.
	event printOn: aStream
]
