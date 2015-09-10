accessing
value: aString
	| oldValue |
	oldValue := value.
	value := aString.
	oldValue ~= value
		ifTrue: [ 
			self updateImage.
			self event: #assigned.
			self event: #changed ]
		ifFalse: [ self event: #assigned ]