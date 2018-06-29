Class {
	#name : #LWTVariableImageWidget,
	#superclass : #LWTWidget,
	#instVars : [
		'form',
		'value',
		'forms'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Widgets'
}

{ #category : #json }
LWTVariableImageWidget class >> fromJsonObject: aDictionary on: aLWTDirector [
	^ (super fromJsonObject: aDictionary on: aLWTDirector)
		rawValue: (aDictionary at: '_rawValue');
		yourself
]

{ #category : #operations }
LWTVariableImageWidget >> addImage [
	| key |
	[ 
	key := UIManager default request: 'Enter a value to map from'.
	key ifNil: [ ^ self ].
	(forms includesKey: key) and: [ (UIManager proceed: key , ' is already defined. Do you want to overwite it?') not ] ]
		whileTrue.
	(LivelyWalkThrough
		fileOpen: 'Select an image file'
		extensions: #('png' 'jpg' 'jpeg')
		path: nil
		preview: #image)
		ifNotNil: [ :filename | 
			[forms at: key put: (Form fromFileNamed: filename fullName)] on: Error do: [:ex | ].
			self updateImage ]
]

{ #category : #json }
LWTVariableImageWidget >> asJsonObject [
	^ super asJsonObject
		at: 'base64Forms' put: self base64Forms;
		at: '_rawValue' put: self rawValue;
		yourself
]

{ #category : #events }
LWTVariableImageWidget >> availableEventSelectors [
	^ #(#changed #clicked #doubleClicked #entered #moved #left #up)
]

{ #category : #private }
LWTVariableImageWidget >> base64Forms [
	| base64Forms |
	base64Forms := Dictionary new.
	forms
		keysAndValuesDo: [ :key :image | 
			base64Forms
				at: key
				put:
					(Base64MimeConverter
						mimeEncode:
							(ByteArray new: 1024 streamContents: [ :stream | PNGReadWriter putForm: image onStream: stream ]) readStream
						multiLine: false) contents ].
	^ base64Forms
]

{ #category : #private }
LWTVariableImageWidget >> base64Forms: aDictionary [
	| newForms |
	newForms := Dictionary new.
	aDictionary
		keysAndValuesDo: [ :key :base64 | newForms at: key put: (PNGReadWriter formFromStream: (Base64MimeConverter mimeDecodeToBytes: base64 readStream)) ].
	forms := newForms
]

{ #category : #accessing }
LWTVariableImageWidget >> basename [
	^ 'VariableImage'
]

{ #category : #operations }
LWTVariableImageWidget >> changeDefaultImage [
	(LivelyWalkThrough
		fileOpen: 'Select an image file'
		extensions: #('png' 'jpg' 'jpeg')
		path: nil
		preview: #image)
		ifNotNil: [ :filename | 
			[ forms at: nil put: (Form fromFileNamed: filename fullName) ]
				on: Error
				do: [ :ex |  ].
			self updateImage ]
]

{ #category : #operations }
LWTVariableImageWidget >> changeImageAt: key [
	(LivelyWalkThrough
		fileOpen: 'Select an image file'
		extensions: #('png' 'jpg' 'jpeg')
		path: nil
		preview: #image)
		ifNotNil: [ :filename | 
			[ forms at: key put: (Form fromFileNamed: filename fullName) ]
				on: Error
				do: [ :ex |  ].
			self updateImage ]
]

{ #category : #'event handling' }
LWTVariableImageWidget >> click: aMouseEvent [
	self event: #clicked
]

{ #category : #defaults }
LWTVariableImageWidget >> defaultExtent [
	^ 200 @ 200
]

{ #category : #'event handling' }
LWTVariableImageWidget >> doubleClick: aMouseEvent [
	self event: #doubleClicked
]

{ #category : #drawing }
LWTVariableImageWidget >> drawOn: aCanvas [
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
LWTVariableImageWidget >> handleMouseDown: aMouseEvent [
	aMouseEvent hand waitForClicksOrDrag: self event: aMouseEvent.
	^ super handleMouseDown: aMouseEvent
]

{ #category : #'event handling' }
LWTVariableImageWidget >> handleMouseEnter: aMouseEvent [
	self event: #entered
]

{ #category : #'event handling' }
LWTVariableImageWidget >> handleMouseLeave: aMouseEvent [
	self event: #left
]

{ #category : #'event handling' }
LWTVariableImageWidget >> handleMouseMove: aMouseEvent [
	self event: #moved.
	^ super handleMouseMove: aMouseEvent
]

{ #category : #'event handling' }
LWTVariableImageWidget >> handleMouseUp: aMouseEvent [
	self event: #up
]

{ #category : #'initialize-release' }
LWTVariableImageWidget >> initialize [
	super initialize.
	forms := Dictionary new
]

{ #category : #private }
LWTVariableImageWidget >> map: aDictionary [
	forms := Dictionary new.
	aDictionary keysAndValuesDo: [ :key :imagePath | forms at: key put: (ImageReadWriter formFromFileNamed: imagePath) ]
]

{ #category : #menu }
LWTVariableImageWidget >> menu [
	| menu |
	menu := super menu.
	menu addLine.
	forms
		keysDo: [ :key | 
			key ifNotNil: [ 
			menu
				add: key
				subMenu:
					(MenuMorph new
						add: 'change...' translated
							target: self
							selector: #changeImageAt:
							argument: key;
						add: 'remove' translated
							target: self
							selector: #removeImageAt:
							argument: key;
						yourself) ]].
	menu
		add: 'DEFAULT'
		subMenu:
			(MenuMorph new
				add: 'change...' translated target: self selector: #changeDefaultImage;
				add: 'remove' translated target: self selector: #removeDefaultImage;
				yourself).
	menu add: 'add mapping' target: self selector: #addImage.
	^ menu
]

{ #category : #private }
LWTVariableImageWidget >> path: aString [
	[ forms at: nil put: (Form fromFileNamed: aString) ]
		on: Error
		do: [ :ex |  ].
	self updateImage
]

{ #category : #private }
LWTVariableImageWidget >> rawValue [
	^ value
]

{ #category : #private }
LWTVariableImageWidget >> rawValue: aString [
	value := aString.
	self updateImage
]

{ #category : #operations }
LWTVariableImageWidget >> removeDefaultImage [
	forms at: nil put: nil.
	self updateImage
]

{ #category : #operations }
LWTVariableImageWidget >> removeImageAt: key [
	(UIManager default proceed: 'OK to remove mapping from ' , key , '?')
		ifTrue: [ 
			forms removeKey: key ifAbsent: [  ].
			self updateImage ]
]

{ #category : #updating }
LWTVariableImageWidget >> updateImage [
	form := forms at: value ifAbsent: [ forms at: nil ifAbsent: [ nil ] ].
	self changed
]

{ #category : #accessing }
LWTVariableImageWidget >> value [
	^ value
]

{ #category : #accessing }
LWTVariableImageWidget >> value: aString [
	| oldValue |
	oldValue := value.
	value := aString.
	oldValue ~= value
		ifTrue: [ 
			self updateImage.
			self event: #assigned.
			self event: #changed ]
		ifFalse: [ self event: #assigned ]
]
