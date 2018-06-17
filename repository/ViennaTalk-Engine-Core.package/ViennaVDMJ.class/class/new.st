instance creation
new
	Smalltalk os isWindows
		ifTrue: [ ^ self
				error: 'ViennaVDMJ does not support windows platforms. Please use ViennaClient instead.' ].
	self isInstalled
		ifFalse: [ self install.
			self isInstalled
				ifFalse: [ ^ self error: 'ViennaVDMJ requires VDMJ, Json4VDMJ and jsonic.' ] ].
	^ super new