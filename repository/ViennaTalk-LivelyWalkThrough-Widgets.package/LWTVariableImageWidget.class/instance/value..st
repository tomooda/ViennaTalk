accessing
value: aString
	| oldValue |
	oldValue := value.
	value := aString.
	oldValue ~= value
		ifTrue: [ 
			self updateImage.
			self event: #changed ]