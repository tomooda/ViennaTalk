accessing
padWidget
	^ padWidget ifNil: [ padWidget := LWTMouseSensor pad ]