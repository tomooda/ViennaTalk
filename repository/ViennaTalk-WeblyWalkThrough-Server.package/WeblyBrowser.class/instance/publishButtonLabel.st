web api services
publishButtonLabel
	^ self isPublished
		ifTrue: [ 'Stop' ]
		ifFalse: [ 'Publish' ]