accessing
close
	process
		ifNotNil: [ :p | 
			process := nil.
			p sigterm.
			p sigkill.
			p terminate ].
	reader
		ifNotNil: [ :r | 
			reader := nil.
			r close ].
	writer
		ifNotNil: [ :w | 
			writer := nil.
			w close ].
	self unregister