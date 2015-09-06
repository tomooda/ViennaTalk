stepping
startStepping
	self
		startStepping: #stepAt:
		at: Time millisecondClockValue
		arguments: nil
		stepTime: 1000