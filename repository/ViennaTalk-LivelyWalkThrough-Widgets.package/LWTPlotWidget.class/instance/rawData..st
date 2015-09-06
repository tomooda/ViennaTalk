private
rawData: aString
	value := aString.
	self
		data:
			([ ViennaReader new parse: aString ]
				on: Error
				do: [ :ex | nil ])