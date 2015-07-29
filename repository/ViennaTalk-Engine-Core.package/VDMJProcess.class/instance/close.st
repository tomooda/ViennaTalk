accessing
close
	process
		ifNotNilDo: [:p | 
			process := nil.
			p sigterm.
			p sigkill.
			p terminate].
	reader
		ifNotNilDo: [:r | 
			reader := nil.
			r close].
	writer
		ifNotNilDo: [:w | 
			writer := nil.
			w close].
	executor ifNotNil: [self updateExecutor]