accessing
buttonWidget
	^ buttonWidget ifNil: [ buttonWidget := LWTMouseSensor button ]