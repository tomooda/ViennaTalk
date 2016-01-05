testing
isPublished
	^ self class server isRunning and: [ self class server delegate == self ]