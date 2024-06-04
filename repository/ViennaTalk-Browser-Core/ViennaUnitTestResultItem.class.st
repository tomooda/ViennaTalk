Class {
	#name : 'ViennaUnitTestResultItem',
	#superclass : 'ViennaTestResultItem',
	#instVars : [
		'operation',
		'message'
	],
	#classInstVars : [
		'icon'
	],
	#category : 'ViennaTalk-Browser-Core-TestRunner',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'TestRunner'
}

{ #category : 'accessing' }
ViennaUnitTestResultItem class >> icon [

	^ self offIcon
]

{ #category : 'instance creation' }
ViennaUnitTestResultItem class >> module: module operation: operation message: message [

	^ self new
		  module: module;
		  operation: operation;
		  message: message;
		  yourself
]

{ #category : 'menus' }
ViennaUnitTestResultItem >> buildContextMenu: aSpMenuPresenter for: aViennaRefactoringBrowser [

	aSpMenuPresenter addItem: [ :item |
		item
			name: 'Jump to test operation';
			action: [
				aViennaRefactoringBrowser
					jumpToModule: self module
					operation: self operation ] ]
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> icon [
	^ self class icon
]

{ #category : 'notification' }
ViennaUnitTestResultItem >> inform [
	GrowlMorph
		openWithLabel: 'Failed: ' , module , '`' , operation
		contents: (message lines first readStream next: 100)
		color: (Color lightGray mixed: 0.5 with: self class iconColor)
]

{ #category : 'testing' }
ViennaUnitTestResultItem >> isError [
	^ false
]

{ #category : 'testing' }
ViennaUnitTestResultItem >> isFailure [
	^ false
]

{ #category : 'testing' }
ViennaUnitTestResultItem >> isSuccess [
	^ false
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> message [
	^ message
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> message: aString [
	message := aString
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> operation [
	^ operation
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> operation: aString [
	operation := aString
]

{ #category : 'printing' }
ViennaUnitTestResultItem >> printOn: aStream [
	aStream space.
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

{ #category : 'accessing' }
ViennaUnitTestResultItem >> sortingOrder [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> testName [

	^ self operation
]
