Class {
	#name : #LWTWidgetDispenser,
	#superclass : #Morph,
	#instVars : [
		'fieldWidget',
		'imageWidget',
		'buttonWidget',
		'padWidget',
		'areaWidget'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #accessing }
LWTWidgetDispenser >> areaWidget [
	^ areaWidget
		ifNil: [ 
			areaWidget := LWTMouseSensor area
				freeze;
				name: 'Area';
				extent: 80 @ 80;
				yourself ]
]

{ #category : #accessing }
LWTWidgetDispenser >> buttonWidget [
	^ buttonWidget
		ifNil: [ 
			buttonWidget := LWTMouseSensor button
				freeze;
				name: 'Button';
				yourself ]
]

{ #category : #accessing }
LWTWidgetDispenser >> fieldWidget [
	^ fieldWidget
		ifNil: [ 
			fieldWidget := LWTFieldWidget new
				freeze;
				name: 'Field';
				yourself ]
]

{ #category : #'event handling' }
LWTWidgetDispenser >> handleMouseDown: aMouseEvent [
	| point |
	aMouseEvent wasHandled: true.
	point := aMouseEvent position.
	(fieldWidget bounds containsPoint: point)
		ifTrue: [ LWTFieldWidget new openInHand ].
	(imageWidget bounds containsPoint: point)
		ifTrue: [ LWTImageWidget new openInHand ].
	(buttonWidget bounds containsPoint: point)
		ifTrue: [ LWTMouseSensor button openInHand ].
	(padWidget bounds containsPoint: point)
		ifTrue: [ LWTMouseSensor pad openInHand ].
	(areaWidget bounds containsPoint: point)
		ifTrue: [ LWTMouseSensor area openInHand ]
]

{ #category : #'event handling' }
LWTWidgetDispenser >> handlesMouseDown: aMouseEvent [
	^ true
]

{ #category : #accessing }
LWTWidgetDispenser >> imageWidget [
	^ imageWidget
		ifNil: [ 
			imageWidget := LWTImageWidget new
				freeze;
				name: 'Image';
				extent: 80 @ 80;
				value: 'Pharo.png'
				yourself ]
]

{ #category : #'initialize-release' }
LWTWidgetDispenser >> initialize [
	super initialize.
	self color: Color white.
	self
		changeTableLayout;
		listDirection: #topToBottom;
		cellInset: 3.
	self addMorphBack: self fieldWidget.
	self addMorphBack: self imageWidget.
	self addMorphBack: self buttonWidget.
	self addMorphBack: self padWidget.
	self addMorphBack: self areaWidget
]

{ #category : #accessing }
LWTWidgetDispenser >> padWidget [
	^ padWidget
		ifNil: [ 
			padWidget := LWTMouseSensor pad
				freeze;
				name: 'MousePad';
				extent: 80 @ 80;
				yourself ]
]
