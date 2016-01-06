private
startupProcess
	| pipe1 pipe2 input output desc |
	OSProcess accessor canAccessSystem
		ifFalse: [ ^ nil ].
	Smalltalk os isWindows
		ifTrue: [ ^ self error: 'ViennaVDMJ can not run on Windows Platform. Use ViennaClient instead.' ]
		ifFalse: [ 
			self vdmjPath exists
				ifFalse: [ 
					self
						installVDMJ;
						installJson4VDMJ ].
			self json4vdmjPath exists
				ifFalse: [ self installJson4VDMJ ].
			self jsonicPath exists
				ifFalse: [ self installJsonic ] ].
	pipe1 := OSPipe blockingPipe.
	pipe2 := OSPipe nonBlockingPipe.
	input := pipe1 reader.
	output := pipe2 writer.
	writer := pipe1 writer.
	reader := pipe2 reader.
	desc := Array with: input with: output with: output.
	process := self forkProcess: desc.
	input close.
	output close.
	self updateExecutor