evaluating
evaluate: expression specification: specification states: states module: module vdm10: vdm10 rtc: rtc
	| engine |
	lock
		critical: [ 
			engines ifEmpty: [ ^ self error: 'no engine available' ].
			ringBufferIndex := ringBufferIndex \\ engines size + 1.
			engine := engines at: ringBufferIndex ].
	^ engine
		evaluate: expression
		specification: specification
		states: states
		module: module
		vdm10: vdm10
		rtc: rtc