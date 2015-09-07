event handling
handleMouseDown: aMouseEvent
	| point |
	aMouseEvent wasHandled: true.
	point := aMouseEvent position.
	(fieldWidget bounds containsPoint: point)
		ifTrue: [ LWTFieldWidget new openInHand ].
	(plotWidget bounds containsPoint: point)
		ifTrue: [ LWTPlotWidget new openInHand ].
	(imageWidget bounds containsPoint: point)
		ifTrue: [ LWTImageWidget new openInHand ].
	(variableImageWidget bounds containsPoint: point)
		ifTrue: [ LWTVariableImageWidget new openInHand ].
	(buttonWidget bounds containsPoint: point)
		ifTrue: [ LWTMouseSensor button openInHand ].
	(padWidget bounds containsPoint: point)
		ifTrue: [ LWTMouseSensor pad openInHand ].
	(areaWidget bounds containsPoint: point)
		ifTrue: [ LWTMouseSensor area openInHand ].
	(remoteWidget bounds containsPoint: point)
		ifTrue: [ LWTRemoteWidget new openInHand ]