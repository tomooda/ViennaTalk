Class {
	#name : #LWTWidgetDispenser,
	#superclass : #Morph,
	#instVars : [
		'fieldWidget',
		'buttonWidget',
		'padWidget',
		'areaWidget'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #accessing }
LWTWidgetDispenser >> areaWidget [
	^ areaWidget ifNil: [ areaWidget := LWTMouseSensor area ]
]

{ #category : #accessing }
LWTWidgetDispenser >> buttonWidget [
	^ buttonWidget ifNil: [ buttonWidget := LWTMouseSensor button ]
]

{ #category : #accessing }
LWTWidgetDispenser >> fieldWidget [
	^ fieldWidget
		ifNil: [ 
			LWTFieldWidget new
				name: 'FieldWidget';
				yourself ]
]

{ #category : #'event handling' }
LWTWidgetDispenser >> handleMouseDown: aMouseEvent [
	self halt.
]

{ #category : #'event handling' }
LWTWidgetDispenser >> handlesMouseDown: aMouseEvent [
	^ true
]

{ #category : #'initialize-release' }
LWTWidgetDispenser >> initialize [
	super initialize.
	self color: Color white.
	self
		changeTableLayout;
		listDirection: #topToBottom.
	self addMorph: self fieldWidget.
	self addMorph: self buttonWidget.
	self addMorph: self padWidget.
	self addMorph: self areaWidget
]

{ #category : #accessing }
LWTWidgetDispenser >> padWidget [
	^ padWidget ifNil: [ padWidget := LWTMouseSensor pad ]
]
