Class {
	#name : 'ViennaUnitTestResultItem',
	#superclass : 'ViennaTestResultItem',
	#instVars : [
		'operation',
		'message',
		'result',
		'isRunning',
		'animation',
		'exception'
	],
	#classInstVars : [
		'icon'
	],
	#category : 'ViennaTalk-Browser-Core-Testing',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Testing'
}

{ #category : 'accessing' }
ViennaUnitTestResultItem class >> icon [

	^ self offIcon
]

{ #category : 'instance creation' }
ViennaUnitTestResultItem class >> module: module operation: operation animation: aViennaAnimation [

	^ self new
		  module: module;
		  operation: operation;
		  animation: aViennaAnimation;
		  yourself
]

{ #category : 'instance creation' }
ViennaUnitTestResultItem class >> module: module operation: operation message: message [

	^ self new
		  module: module;
		  operation: operation;
		  message: message;
		  yourself
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> animation [

	^ animation
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> animation: aViennaAnimation [

	animation := aViennaAnimation
]

{ #category : 'testing' }
ViennaUnitTestResultItem >> beError [

	result := #error
]

{ #category : 'testing' }
ViennaUnitTestResultItem >> beFailure [

	result := #failure
]

{ #category : 'testing' }
ViennaUnitTestResultItem >> beSuccess [

	result := #success
]

{ #category : 'menus' }
ViennaUnitTestResultItem >> buildContextMenu: aSpMenuPresenter for: aViennaRefactoringBrowser [

	aSpMenuPresenter addItem: [ :item |
		item
			name: 'Jump to test operation';
			action: [
				aViennaRefactoringBrowser
					jumpToModule: self module
					operation: self operation ] ].
	exception
		ifNotNil: [
			aSpMenuPresenter addGroup: [ :group |
				group addItem: [ :item |
					item
						name: 'Debug';
						action: [ exception debug ] ] ] ]
		ifNil: [
			aSpMenuPresenter addGroup: [ :group |
				group addItem: [ :item |
					item
						name: 'Debug it with transpiler';
						action: [ aViennaRefactoringBrowser debugTestResultItem: self ] ] ] ]
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> color [

	self isSuccess ifTrue: [ ^ self class successIconColor ].
	self isFailure ifTrue: [ ^ self class failureIconColor ].
	self isError ifTrue: [ ^ self class errorIconColor ].
	^ self class offIconColor
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> exception [

	^ exception
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> exception: anException [

	exception := anException freeze
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> icon [

	self isSuccess ifTrue: [ ^ self class successIcon ].
	self isFailure ifTrue: [ ^ self class failureIcon ].
	self isError ifTrue: [ ^ self class errorIcon ].
	^ self class offIcon
]

{ #category : 'notification' }
ViennaUnitTestResultItem >> inform [

	(self isFailure or: [ self isError ]) ifTrue: [
		^ GrowlMorph
			  openWithLabel: 'Failed: ' , module , '`' , operation
			  contents: (message lines first readStream next: 100)
			  color: (Color lightGray mixed: 0.5 with: self color) ]
]

{ #category : 'testing' }
ViennaUnitTestResultItem >> isError [

	^ result = #error
]

{ #category : 'testing' }
ViennaUnitTestResultItem >> isFailure [

	^ result = #failure
]

{ #category : 'testing' }
ViennaUnitTestResultItem >> isRunning [

	^ isRunning = true
]

{ #category : 'testing' }
ViennaUnitTestResultItem >> isSuccess [

	^ result = #success
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
ViennaUnitTestResultItem >> result [

	^ result
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> result: aSymbol [

	result := aSymbol
]

{ #category : 'running' }
ViennaUnitTestResultItem >> run [

	self startRunning.
	[
	animation state: Dictionary new.
	[
	[ animation runTestOperation: operation module: module ]
		on: ViennaException
		do: [ :ex |
			ex expression in: [ :expr |
				(expr isViennaComposite and: [
					 expr constructorName = 'AssertFailure' ]) ifTrue: [
					self beFailure.
					self message: 'assertion failed: ' , (expr at: 1) asString.
					animation isTranspiledAnimation ifTrue: [ self exception: ex ].
					self inform.
					^ self ].
				(expr isViennaComposite and: [
					 expr constructorName = 'AssertEqualsFailure' ]) ifTrue: [
					self beFailure.
					self message:
						'assertion failed: ' , (expr at: 3) asString , ' expected: '
						, (expr at: 2) viennaString , ' actual: '
						, (expr at: 1) viennaString.
					animation isTranspiledAnimation ifTrue: [
						self exception: exception ].
					self inform.
					^ self ].
				self beError.
				self message: expr viennaString.
				animation isTranspiledAnimation ifTrue: [
					self exception: exception ].
				self inform.
				^ self ] ] ]
		on: Error
		do: [ :ex |
			self beError.
			self message: ex printString.
			animation isTranspiledAnimation ifTrue: [ self exception: ex ].
			self inform.
			^ self ].
	self beSuccess ] ensure: [ self stopRunning ]
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> sortingOrder [

	self isError ifTrue: [ ^ 0 ].
	self isFailure ifTrue: [ ^ 1 ].
	self isSuccess ifTrue: [ ^ 2 ].
	^ 3
]

{ #category : 'running' }
ViennaUnitTestResultItem >> startRunning [

	isRunning := true
]

{ #category : 'running' }
ViennaUnitTestResultItem >> stopRunning [

	isRunning := false
]

{ #category : 'accessing' }
ViennaUnitTestResultItem >> testName [

	^ self operation
]
