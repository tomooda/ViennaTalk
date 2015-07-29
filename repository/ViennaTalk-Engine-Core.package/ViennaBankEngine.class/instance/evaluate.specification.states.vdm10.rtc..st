evaluating
evaluate: expression specification: specification states: states vdm10: vdm10 rtc: rtc
	engines ifEmpty: [ ^ self error: 'no engine available' ].
	ringBufferIndex := ringBufferIndex \\ engines size + 1.
	^ (engines at: ringBufferIndex)
		evaluate: expression
		specification: specification
		states: states
		vdm10: vdm10
		rtc: rtc