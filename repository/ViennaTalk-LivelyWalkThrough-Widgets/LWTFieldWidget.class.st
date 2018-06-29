Class {
	#name : #LWTFieldWidget,
	#superclass : #LWTWidget,
	#category : 'ViennaTalk-LivelyWalkThrough-Widgets'
}

{ #category : #defaults }
LWTFieldWidget >> defaultNameColor [
	^ Color lightGray
]

{ #category : #defaults }
LWTFieldWidget >> defaultNameFont [
	^ TextStyle default defaultFont
]

{ #category : #drawing }
LWTFieldWidget >> drawOn: aCanvas [
	aCanvas
		frameAndFillRectangle: self bounds
		fillColor: Color white
		borderWidth: 1
		borderColor: Color lightGray.
	aCanvas
		drawString: self name
		at: self position + self nameOffset
		font: self nameFont
		color: self nameColor
]
