stepping
timeOfLastStateUpdate
	^ timeOfLastStateUpdate
		ifNil: [Time millisecondClockValue]