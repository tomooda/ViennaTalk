servicing
ensureServeIn: aBlock
	| isRunning |
	isRunning := self isRunning.
	isRunning
		ifFalse: [ self
				flushServer;
				installHandler ].
	aBlock
		ensure: [ isRunning
				ifFalse: [ self flushServer ] ]