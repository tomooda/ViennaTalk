Class {
	#name : #ViennaTestResultItem,
	#superclass : #Object,
	#instVars : [
		'module',
		'operation',
		'message'
	],
	#classInstVars : [
		'icon'
	],
	#category : 'ViennaTalk-Browser-Core'
}

{ #category : #accessing }
ViennaTestResultItem class >> createIcon [
	| form |
	form := Form extent: self iconExtent depth: 32.
	form getCanvas
		fillColor: Color transparent;
		fillOval: (0 @ 0 extent: self iconExtent)
			color: self iconColor
			borderWidth: 1
			borderColor: self iconColor darker.
	^ form
]

{ #category : #accessing }
ViennaTestResultItem class >> flushIcon [
	icon := nil
]

{ #category : #accessing }
ViennaTestResultItem class >> flushIcons [
	<script: 'ViennaTestResultItem flushIcons'>
	self allSubclassesDo: [ :c | c flushIcon ]
]

{ #category : #accessing }
ViennaTestResultItem class >> icon [
	^ icon ifNil: [ self createIcon ]
]

{ #category : #accessing }
ViennaTestResultItem class >> iconColor [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaTestResultItem class >> iconExtent [
	^ ViennaLauncher font height asPoint
]

{ #category : #'instance creation' }
ViennaTestResultItem class >> module: module operation: operation message: message [
	^ self new
		module: module;
		operation: operation;
		message: message;
		yourself
]

{ #category : #accessing }
ViennaTestResultItem >> icon [
	^ self class icon
]

{ #category : #testing }
ViennaTestResultItem >> isError [
	^ false
]

{ #category : #testing }
ViennaTestResultItem >> isFailure [
	^ false
]

{ #category : #testing }
ViennaTestResultItem >> isSuccess [
	^ false
]

{ #category : #accessing }
ViennaTestResultItem >> message [
	^ message
]

{ #category : #accessing }
ViennaTestResultItem >> message: aString [
	message := aString
]

{ #category : #accessing }
ViennaTestResultItem >> module [
	^ module
]

{ #category : #accessing }
ViennaTestResultItem >> module: aString [
	module := aString
]

{ #category : #accessing }
ViennaTestResultItem >> operation [
	^ operation
]

{ #category : #accessing }
ViennaTestResultItem >> operation: aString [
	operation := aString
]

{ #category : #printing }
ViennaTestResultItem >> printOn: aStream [
	module
		ifNotNil: [ aStream
				nextPutAll: module;
				nextPut: $` ].
	operation
		ifNotNil: [ aStream
				nextPutAll: operation;
				nextPutAll: '()' ].
	aStream nextPutAll: ' -> '.
	message ifNotNil: [ aStream nextPutAll: message ]
]
