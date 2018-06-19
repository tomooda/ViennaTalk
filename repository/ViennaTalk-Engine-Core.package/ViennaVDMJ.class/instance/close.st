accessing
close
	process
		ifNotNil: [ :p | 
			process := nil.
			[ p sigterm.
			p sigkill.
			p terminate ]
				on: Error
				do: [ :ex |  ] ].
	reader
		ifNotNil: [ :r | 
			reader := nil.
			r close ].
	writer
		ifNotNil: [ :w | 
			writer := nil.
			w close ].
	self unregister