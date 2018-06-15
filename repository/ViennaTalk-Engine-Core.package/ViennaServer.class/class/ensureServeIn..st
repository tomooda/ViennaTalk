servicing
ensureServeIn: aBlock
	| isRunning |
	isRunning := self isRunning.
	isRunning
		ifFalse: [ self installHandler ].
	aBlock
		ensure: [ isRunning
				ifFalse: [ self flushServer ] ]