Class {
	#name : #LWTImageWidget,
	#superclass : #LWTWidget,
	#instVars : [
		'form',
		'value'
	],
	#category : #'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #json }
LWTImageWidget >> asJsonObject [
	^ super asJsonObject
		at: 'base64Form' put: self base64Form;
		yourself
]

{ #category : #events }
LWTImageWidget >> availableEventSelectors [
	^ #(#changed #clicked #doubleClicked #entered #moved #left #up)
]

{ #category : #private }
LWTImageWidget >> base64Form [
	^ form
		ifNotNil: [ 
			(Base64MimeConverter
				mimeEncode:
					(ByteArray new: 1024 streamContents: [ :stream | PNGReadWriter putForm: form onStream: stream ]) readStream
				multiLine: false) contents ]
]

{ #category : #private }
LWTImageWidget >> base64Form: aString [

	form := PNGReadWriter formFromStream:
		        (Base64MimeConverter mimeDecodeToBytes: aString readStream)
]

{ #category : #accessing }
LWTImageWidget >> basename [
	^ 'Image'
]

{ #category : #operations }
LWTImageWidget >> changeImage [
	(LivelyWalkThrough
		fileOpen: 'Select an image file'
		extensions: #('png' 'jpg' 'jpeg')
		path: nil
		preview: #image)
		ifNotNil: [ :filename | 
			[ form := Form fromFileNamed: filename fullName ]
				on: Error
				do: [ :ex |  ] ]
]

{ #category : #'event handling' }
LWTImageWidget >> click: aMouseEvent [
	self event: #clicked
]

{ #category : #defaults }
LWTImageWidget >> defaultExtent [
	^ 200 @ 200
]

{ #category : #'event handling' }
LWTImageWidget >> doubleClick: aMouseEvent [
	self event: #doubleClicked
]

{ #category : #drawing }
LWTImageWidget >> drawOn: aCanvas [
	form
		ifNil: [ 
			aCanvas
				frameAndFillRectangle: self bounds
				fillColor: Color transparent
				borderWidth: 2
				borderColor: Color black ]
		ifNotNil: [ 
			| scale |
			scale := self extent / form extent.
			aCanvas
				paintImage:
					(form
						magnifyBy:
							(scale x asFloat > scale y asFloat
								ifTrue: [ scale y asFloat ]
								ifFalse: [ scale x asFloat ]))
				at: self position ].
	super drawOn: aCanvas
]

{ #category : #'event handling' }
LWTImageWidget >> handleMouseDown: aMouseEvent [
	aMouseEvent hand waitForClicksOrDrag: self event: aMouseEvent.
	^ super handleMouseDown: aMouseEvent
]

{ #category : #'event handling' }
LWTImageWidget >> handleMouseEnter: aMouseEvent [
	self event: #entered
]

{ #category : #'event handling' }
LWTImageWidget >> handleMouseLeave: aMouseEvent [
	self event: #left
]

{ #category : #'event handling' }
LWTImageWidget >> handleMouseMove: aMouseEvent [
	self event: #moved.
	^ super handleMouseMove: aMouseEvent
]

{ #category : #'event handling' }
LWTImageWidget >> handleMouseUp: aMouseEvent [
	self event: #up
]

{ #category : #'initialize-release' }
LWTImageWidget >> initialize [
	super initialize.
	value := String new
]

{ #category : #menu }
LWTImageWidget >> menu [
	| menu |
	menu := super menu.
	menu
		add: 'change image' translated target: self selector: #changeImage;
		add: 'remove image' translated target: self selector: #noImage;
		yourself.
	^ menu
]

{ #category : #operations }
LWTImageWidget >> noImage [
	form := nil
]

{ #category : #private }
LWTImageWidget >> path: aString [
	form := [ ImageReadWriter formFromFileNamed: aString ]
		on: Error
		do: [ :ex | nil ].
	self changed
]

{ #category : #accessing }
LWTImageWidget >> value [
	^ value
]

{ #category : #accessing }
LWTImageWidget >> value: aString [
	value ~= aString
		ifTrue: [ 
			value := aString.
			self changed.
			self event: #assigned.
			self event: #changed ]
		ifFalse: [ self event: #assigned ]
]
