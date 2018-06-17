private
startupProcess
	Smalltalk os isWindows
		ifTrue: [ ^ self error: 'ViennaVDMJ can not run on Windows Platform. Use ViennaClient instead.' ]
		ifFalse: [ 
			self class vdmjPath exists
				ifFalse: [ 
					self class
						installVDMJ;
						installJson4VDMJ ].
			self class json4vdmjPath exists
				ifFalse: [ self class installJson4VDMJ ].
			self class jsonicPath exists
				ifFalse: [ self class installJsonic ] ].
	process := self forkProcess.
	reader := process stdoutStream.
	writer := process stdinStream.
	self register