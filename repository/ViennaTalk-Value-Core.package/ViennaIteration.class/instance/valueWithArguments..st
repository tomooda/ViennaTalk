accessing
valueWithArguments: anArray
	| result |
	result := anArray.
	n
		timesRepeat: [ 
			result isArray
				ifFalse: [ result := Array with: result ].
			result := fun isCollection
				ifTrue: [ fun at: result first ]
				ifFalse: [ fun valueWithArguments: result ] ].
	^ result