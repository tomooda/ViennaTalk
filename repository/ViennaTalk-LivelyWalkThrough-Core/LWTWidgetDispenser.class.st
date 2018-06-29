Class {
	#name : #LWTWidgetDispenser,
	#superclass : #Morph,
	#instVars : [
		'fieldWidget',
		'plotWidget',
		'imageWidget',
		'buttonWidget',
		'padWidget',
		'areaWidget',
		'remoteWidget'
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
				nameColor: Color black;
				nameFont:
						(self nameFontForWidgets);
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
				nameColor: Color black;
				nameFont: self nameFontForWidgets;
				yourself ]
]

{ #category : #accessing }
LWTWidgetDispenser >> fieldWidget [
	^ fieldWidget
		ifNil: [ 
			fieldWidget := LWTFieldWidget new
				freeze;
				name: 'Field';
				nameColor: Color black;
				nameFont: self nameFontForWidgets;
				yourself ]
]

{ #category : #'event handling' }
LWTWidgetDispenser >> handleMouseDown: aMouseEvent [
	| point |
	aMouseEvent wasHandled: true.
	point := aMouseEvent position.
	(fieldWidget bounds containsPoint: point)
		ifTrue: [ LWTFieldWidget new openInHand ].
	(plotWidget bounds containsPoint: point)
		ifTrue: [ LWTPlotWidget new openInHand ].
	(imageWidget bounds containsPoint: point)
		ifTrue: [ LWTImageWidget new openInHand ].
	(buttonWidget bounds containsPoint: point)
		ifTrue: [ LWTMouseSensor button openInHand ].
	(padWidget bounds containsPoint: point)
		ifTrue: [ LWTMouseSensor pad openInHand ].
	(areaWidget bounds containsPoint: point)
		ifTrue: [ LWTMouseSensor area openInHand ].
	(remoteWidget bounds containsPoint: point)
		ifTrue: [ LWTRemoteWidget new openInHand ].

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
				nameColor: Color black;
				nameFont: self nameFontForWidgets;
				extent: 80 @ 80;
				value: 'Pharo.png';
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
	self addMorphBack: self plotWidget.
	self addMorphBack: self imageWidget.
	self addMorphBack: self buttonWidget.
	self addMorphBack: self padWidget.
	self addMorphBack: self areaWidget.
	self addMorphBack: self remoteWidget
]

{ #category : #accessing }
LWTWidgetDispenser >> nameFontForWidgets [
	^ LogicalFont
		familyName: TextStyle default defaultFont familyName
		pointSize: TextStyle default defaultFont pointSize
		stretchValue: 5
		weightValue: 700
		slantValue: 0
]

{ #category : #accessing }
LWTWidgetDispenser >> padWidget [
	^ padWidget
		ifNil: [ 
			padWidget := LWTMouseSensor pad
				freeze;
				name: 'MousePad';
				nameColor: Color black;
				nameFont: self nameFontForWidgets;
				extent: 80 @ 80;
				yourself ]
]

{ #category : #accessing }
LWTWidgetDispenser >> plotWidget [
	^ plotWidget
		ifNil: [ 
			plotWidget := LWTPlotWidget new
				freeze;
				name: 'Plot';
				nameColor: Color black;
				nameFont: self nameFontForWidgets;
				extent: 80 @ 80;
				data: ((0 to: 5) collect: [ :t | t asFloat sin negated ]);
				yourself ]
]

{ #category : #accessing }
LWTWidgetDispenser >> remoteWidget [
	^ remoteWidget
		ifNil: [ 
			remoteWidget := LWTRemoteWidget new
				freeze;
				name: 'Remote';
				nameColor: Color black;
				nameFont: self nameFontForWidgets;
				yourself ]
]
