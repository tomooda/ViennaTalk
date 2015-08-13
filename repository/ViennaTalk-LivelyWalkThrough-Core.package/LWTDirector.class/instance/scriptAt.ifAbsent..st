accessing-scripts
scriptAt: aString ifAbsent: errorBlock
	self
		scriptsDo: [ :script | 
			script name = aString
				ifTrue: [ ^ script ] ].
	^ errorBlock value