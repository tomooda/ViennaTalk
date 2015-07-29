private
ensureStartupProcess
	(reader isNil
			or: [reader closed
					or: [process isNil
							or: [process isRunning not]]])
		ifTrue: [self startupProcess]