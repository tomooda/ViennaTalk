accessing
sourceAt: anInteger ifAbsent: errorBlock
	sources
		do: [ :assoc | 
			(assoc key includes: anInteger)
				ifTrue: [ ^ assoc value ] ].
	^ errorBlock value