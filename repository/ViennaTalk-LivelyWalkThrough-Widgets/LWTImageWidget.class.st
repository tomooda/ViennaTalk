Class {
	#name : #LWTImageWidget,
	#superclass : #LWTWidget,
	#instVars : [
		'form',
		'path'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Widgets'
}

{ #category : #events }
LWTImageWidget >> availableEventSelectors [
	^ #(#changed)
]

{ #category : #accessing }
LWTImageWidget >> basename [
	^ 'Image'
]

{ #category : #operations }
LWTImageWidget >> changeImage [
	(UIManager default chooseFullFileNameMatching: nil label: 'Select an image file')
		ifNotNil: [ :filename | self value: filename asString ]
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

{ #category : #'initialize-release' }
LWTImageWidget >> initialize [
	super initialize.
	self extent: 200 @ 200
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
	self value: nil
]

{ #category : #accessing }
LWTImageWidget >> value [
	^ path ifNil: [ String new ]
]

{ #category : #accessing }
LWTImageWidget >> value: aString [
	path ~= aString
		ifTrue: [ 
			path := aString.
			form := [ ImageReadWriter formFromFileNamed: path ]
				on: Error
				do: [ :ex | nil ].
			self changed.
			self event: #changed ]
]
