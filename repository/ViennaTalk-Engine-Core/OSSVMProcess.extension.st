Extension { #name : #OSSVMProcess }

{ #category : #'*ViennaTalk-Engine-Core' }
OSSVMProcess class >> shutDown: quitting [
	Smalltalk platform isWindows not
		ifTrue: [ ^ self ].
	self vmProcess shutDown: quitting
]

{ #category : #'*ViennaTalk-Engine-Core' }
OSSVMProcess class >> startUp: resuming [
	
	Smalltalk platform isWindows ifTrue: [ ^self ].
	resuming ifTrue: [ 
		"To understand why the #stopWaiting, first read the comment of 
		OSSVMProcess shutDown:
		It could happen that when the shutDown happened, the child process
		was in the wait of #waitForExitPollingEvery:doing:. Therefore, until the
		next cycle of the loop it won't do the queryExitStatus. So we may still 
		have this problem in image startup. So just in case we run it too in the startup code.
		 "
		self vmProcess activeChildren do: [ :each | each stopWaiting ].
		self initializeVMProcessInstance.
		]
]