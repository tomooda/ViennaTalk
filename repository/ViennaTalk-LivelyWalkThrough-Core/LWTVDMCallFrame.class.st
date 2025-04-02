Class {
	#name : 'LWTVDMCallFrame',
	#superclass : 'LWTFrame',
	#instVars : [
		'callee',
		'expression',
		'value'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core',
	#package : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : 'instance creation' }
LWTVDMCallFrame class >> callee: callee expression: aString value: anotherString [ 
	^ self new callee: callee;
		 expression: aString;
		 value: anotherString;
		 yourself
]

{ #category : 'instance creation' }
LWTVDMCallFrame class >> expression: aString value: anotherString [ 
	^ self new expression: aString;
		 value: anotherString;
		 yourself
]

{ #category : 'accessing' }
LWTVDMCallFrame >> callee [
	^ callee
]

{ #category : 'accessing' }
LWTVDMCallFrame >> callee: aString [
	callee := aString
]

{ #category : 'accessing' }
LWTVDMCallFrame >> expression [
	^ expression
]

{ #category : 'accessing' }
LWTVDMCallFrame >> expression: aString [
	expression := aString
]

{ #category : 'testing' }
LWTVDMCallFrame >> isVDMCallFrame [
	^ true
]

{ #category : 'interface opening' }
LWTVDMCallFrame >> openBrowser [
	| module |
	module := (callee indexOf: $`)
				in: [:index | index > 0
						ifTrue: [callee copyFrom: 1 to: index - 1]
						ifFalse: ['DEFAULT']].
	^ ViennaBrowser open model selectModuleNamed: module
]

{ #category : 'printing' }
LWTVDMCallFrame >> printOn: aStream [ 
	timestamp printOn: aStream.
	aStream nextPutAll: ' : VDM : '.
	aStream nextPutAll: expression.
	aStream nextPutAll: '='.
	aStream nextPutAll: value
]

{ #category : 'accessing' }
LWTVDMCallFrame >> value [
	^ value
]

{ #category : 'accessing' }
LWTVDMCallFrame >> value: aString [
	value := aString
]
