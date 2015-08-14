interpreting
execEvent: eventName at: widgetName
	^ ((scripts at: widgetName ifAbsent: [ ^ self ]) at: eventName ifAbsent: [ ^ self ]) value