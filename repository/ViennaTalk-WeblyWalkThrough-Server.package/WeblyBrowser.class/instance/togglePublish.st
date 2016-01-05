web api services
togglePublish
	self isPublished
		ifTrue: [ 
			WeblyWalkThrough stopService.
			portField enable.
			publishButton color: self publishButtonOffColor ]
		ifFalse: [ 
			portField disable.
			WeblyWalkThrough startService.
			publishButton color: self publishButtonOnColor ].
	self changed: #isPublished.
	self changed: #publishButtonLabel.
	publishButton changed