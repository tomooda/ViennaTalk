Class {
	#name : 'ViennaTestResultItem',
	#superclass : 'Object',
	#instVars : [
		'module'
	],
	#classInstVars : [
		'OffIcon',
		'SuccessIcon',
		'FailureIcon',
		'ErrorIcon'
	],
	#category : 'ViennaTalk-Browser-Core-TestRunner',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'TestRunner'
}

{ #category : 'private' }
ViennaTestResultItem class >> createIcon: aColor [

	| form |
	form := Form extent: self iconExtent depth: 32.
	form getCanvas
		fillColor: Color transparent;
		fillOval: (0 @ 0 extent: self iconExtent)
		color: aColor
		borderWidth: 1
		borderColor: aColor darker.
	^ form
]

{ #category : 'accessing' }
ViennaTestResultItem class >> errorIcon [

	^ ErrorIcon ifNil: [
		  ErrorIcon := self createIcon: self errorIconColor ]
]

{ #category : 'accessing' }
ViennaTestResultItem class >> errorIconColor [

	^ Color red
]

{ #category : 'accessing' }
ViennaTestResultItem class >> failureIcon [

	^ FailureIcon ifNil: [
		  FailureIcon := self createIcon: self failureIconColor ]
]

{ #category : 'accessing' }
ViennaTestResultItem class >> failureIconColor [

	^ Color yellow
]

{ #category : 'utilities' }
ViennaTestResultItem class >> flushIcons [

	<script: 'ViennaTestResultItem flushIcons'>
	OffIcon := SuccessIcon := FailureIcon := ErrorIcon := nil
]

{ #category : 'accessing' }
ViennaTestResultItem class >> iconExtent [

	^ (ViennaLauncher font height * 0.7 max: 5) asPoint
]

{ #category : 'testing' }
ViennaTestResultItem class >> isAbstract [

	^ self = ViennaTestResultItem
]

{ #category : 'accessing' }
ViennaTestResultItem class >> offIcon [

	^ OffIcon ifNil: [ OffIcon := self createIcon: self offIconColor ]
]

{ #category : 'accessing' }
ViennaTestResultItem class >> offIconColor [

	^ Color darkGray
]

{ #category : 'accessing' }
ViennaTestResultItem class >> successIcon [

	^ SuccessIcon ifNil: [
		  SuccessIcon := self createIcon: self successIconColor ]
]

{ #category : 'accessing' }
ViennaTestResultItem class >> successIconColor [

	^ Color green
]

{ #category : 'menus' }
ViennaTestResultItem >> buildContextMenu: aSpMenuPresenter for: aViennaRefactoringBrowser [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaTestResultItem >> errorIcon [

	^ self class errorIcon
]

{ #category : 'accessing' }
ViennaTestResultItem >> exception [

	^ nil
]

{ #category : 'accessing' }
ViennaTestResultItem >> failureIcon [

	^ self class failureIcon
]

{ #category : 'accessing' }
ViennaTestResultItem >> message [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaTestResultItem >> module [

	^ module
]

{ #category : 'accessing' }
ViennaTestResultItem >> module: aString [

	module := aString
]

{ #category : 'accessing' }
ViennaTestResultItem >> offIcon [

	^ self class offIcon
]

{ #category : 'accessing' }
ViennaTestResultItem >> successIcon [

	^ self class successIcon
]

{ #category : 'accessing' }
ViennaTestResultItem >> testName [

	^ self subclassResponsibility
]
