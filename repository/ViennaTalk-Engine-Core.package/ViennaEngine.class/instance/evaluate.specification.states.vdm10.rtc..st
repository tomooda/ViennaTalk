evaluating
evaluate: expression specification: specification states: states vdm10: vdm10 rtc: rtc
	^ self
		evaluate: expression
		specification: specification
		states: states
		module: 'DEFAULT'
		vdm10: vdm10
		rtc: rtc