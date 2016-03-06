accessing
value: aString
	value ~= aString
		ifTrue: [ 
			value := aString.
			self changed.
			self event: #assigned.
			self event: #changed ]
		ifFalse: [ self event: #assigned ]