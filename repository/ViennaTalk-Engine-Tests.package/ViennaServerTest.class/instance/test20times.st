tests-empty
test20times
	| sem count |
	sem := Semaphore forMutualExclusion .
	count := 0.
	20 timesRepeat: [
		[self
		testExpression: '1+2'
		specification: ''
		states: Dictionary new
		resultValue: '3'
		resultStates: Dictionary new.
		sem critical: [ count := count + 1]] forkAt: Processor userBackgroundPriority ].
	[ count < 20 ] whileTrue: [ (Delay forMilliseconds: 100) wait ]