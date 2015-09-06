initialize-release
initialize
	super initialize.
	value := 0.
	stepTime := self defaultStepTime.
	stepping := false