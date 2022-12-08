Class {
	#name : #LWTTimerWidget,
	#superclass : #LWTWidget,
	#instVars : [
		'value',
		'stepTime',
		'stepping'
	],
	#category : #'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #json }
LWTTimerWidget >> asJsonObject [
	^ super asJsonObject
		at: 'rawValue' put: self rawValue;
		at: 'stepTime' put: self stepTime;
		yourself
]

{ #category : #events }
LWTTimerWidget >> availableEventSelectors [

	^ #( changed assigned )
]

{ #category : #accessing }
LWTTimerWidget >> basename [
	^ 'Timer'
]

{ #category : #operations }
LWTTimerWidget >> changeStepTime [
	(UIManager default request: 'Enter interval in msecs' initialAnswer: stepTime printString title: self name)
		ifNotNil: [ :answer | answer asInteger ifNotNil: [ :newTimeStep | self stepTime: newTimeStep ] ]
]

{ #category : #defaults }
LWTTimerWidget >> defaultExtent [
	^ 100@50
]

{ #category : #defaults }
LWTTimerWidget >> defaultStepTime [
	^ 100
]

{ #category : #drawing }
LWTTimerWidget >> drawOn: aCanvas [
	| low high left middle right |
	low := (self bounds bottom * 0.8 + (self bounds top * 0.2)) asInteger.
	high := (self bounds bottom * 0.2 + (self bounds top * 0.8)) asInteger.
	left := (self bounds left * 0.8 + (self bounds right * 0.2)) asInteger.
	right := (self bounds left * 0.2 + (self bounds right * 0.8)) asInteger.
	middle := (self bounds left * 0.4 + (self bounds right * 0.6)) asInteger.
	super drawOn: aCanvas.
	aCanvas
		frameAndFillRectangle: self bounds
		fillColor: Color transparent
		borderWidth: 1
		borderColor: Color red.
	value odd
		ifTrue: [ 
			aCanvas
				line: left @ high
				to: left @ low
				width: 2
				color: Color black.
			aCanvas
				line: left @ low
				to: middle @ low
				width: 2
				color: Color black.
			aCanvas
				line: middle @ low
				to: middle @ high
				width: 2
				color: Color black.
			aCanvas
				line: middle @ high
				to: right @ high
				width: 2
				color: Color black ]
		ifFalse: [ 
			aCanvas
				line: left @ low
				to: left @ high
				width: 2
				color: Color black.
			aCanvas
				line: left @ high
				to: middle @ high
				width: 2
				color: Color black.
			aCanvas
				line: middle @ high
				to: middle @ low
				width: 2
				color: Color black.
			aCanvas
				line: middle @ low
				to: right @ low
				width: 2
				color: Color black ]
]

{ #category : #'event handling' }
LWTTimerWidget >> handleMouseDown: aMouseEvent [
	aMouseEvent yellowButtonPressed
		ifFalse: [ 
			stepping
				ifTrue: [ self stepping: false ].
			self step ].
	^ super handleMouseDown: aMouseEvent
]

{ #category : #'event handling' }
LWTTimerWidget >> handlesMouseDown: anEvent [
	^ true
]

{ #category : #'initialize-release' }
LWTTimerWidget >> initialize [
	super initialize.
	value := 0.
	stepTime := self defaultStepTime.
	stepping := false
]

{ #category : #menu }
LWTTimerWidget >> menu [
	| menu |
	menu := super menu.
	menu add: 'change interval...' target: self selector: #changeStepTime.
	stepping
		ifTrue: [ menu add: 'stop ticking' target: self selector: #stopStepping ]
		ifFalse: [ menu add: 'start ticking' target: self selector: #startStepping ].
	^ menu
]

{ #category : #private }
LWTTimerWidget >> rawValue [
	^ value
]

{ #category : #private }
LWTTimerWidget >> rawValue: anInteger [
	value := anInteger.
	self changed
]

{ #category : #stepping }
LWTTimerWidget >> startStepping [
	"Start getting sent the 'step' message."
	super stopStepping.
	stepping := true.
	self startStepping: #stepAt: at: Time millisecondClockValue arguments: nil stepTime: stepTime.
]

{ #category : #stepping }
LWTTimerWidget >> step [
	value := value + 1.
	self event: #ticked.
	self changed
]

{ #category : #accessing }
LWTTimerWidget >> stepTime [
	^ stepTime
]

{ #category : #accessing }
LWTTimerWidget >> stepTime: aNumber [
	stepTime := aNumber.
	self stopStepping.
	stepping
		ifTrue: [ self startStepping ]
]

{ #category : #accessing }
LWTTimerWidget >> stepping: aBoolean [
	stepping := aBoolean.
	self stopStepping.
	stepping
		ifTrue: [ self startStepping ]
]

{ #category : #stepping }
LWTTimerWidget >> stopStepping [
	stepping := false.
	super stopStepping
]

{ #category : #accessing }
LWTTimerWidget >> value [
	^ value
]

{ #category : #accessing }
LWTTimerWidget >> value: aString [
	aString asInteger
		ifNotNil: [ :i | 
			| oldValue |
			oldValue := value.
			value := i asString.
			self event: #assigned.
			oldValue ~= value
				ifTrue: [ self event: #changed ].
			self changed ]
]

{ #category : #stepping }
LWTTimerWidget >> wantsSteps [
	^ false
]
