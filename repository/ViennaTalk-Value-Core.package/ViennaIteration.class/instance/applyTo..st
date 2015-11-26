accessing
applyTo: anArray
	| result |
	result := anArray.
	n
		timesRepeat: [ 
			result := result isArray
				ifTrue: [ block applyTo: result ]
				ifFalse: [ block value: result ] ].
	^ result