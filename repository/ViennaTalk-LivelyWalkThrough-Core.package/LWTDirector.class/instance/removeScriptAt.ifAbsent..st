accessing-scripts
removeScriptAt: aString ifAbsent: errorBlock
	self
		scriptsDo: [ :script | 
			script name = aString
				ifTrue: [ 
					(scripts at: script widgetName) removeKey: script event.
					^ script ] ].
	^ errorBlock value