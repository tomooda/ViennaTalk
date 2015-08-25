accessing
value: aVDMValue
	| oldValue |
	oldValue := value.
	value := aVDMValue.
	self
		data:
			([ ViennaReader new parse: aVDMValue ]
				on: Error
				do: [ :ex | nil ]).
	value ~= oldValue
		ifTrue: [ 
			self changed.
			self event: #changed ]