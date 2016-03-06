private
path: aString
	[ forms at: nil put: (Form fromFileNamed: aString) ]
		on: Error
		do: [ :ex |  ].
	self updateImage