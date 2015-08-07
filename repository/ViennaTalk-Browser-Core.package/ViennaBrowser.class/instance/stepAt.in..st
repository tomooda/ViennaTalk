stepping
stepAt: millisecondClockValue in: aWindow
	millisecondClockValue - self timeOfLastStateUpdate > (1000.0 / self updateFrequency)
		ifTrue: [ 
			self updateState.
			self updateContents.
			timeOfLastStateUpdate := millisecondClockValue ]