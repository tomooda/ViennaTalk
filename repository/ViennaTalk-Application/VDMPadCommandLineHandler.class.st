Class {
	#name : 'VDMPadCommandLineHandler',
	#superclass : 'CommandLineHandler',
	#category : 'ViennaTalk-Application',
	#package : 'ViennaTalk-Application'
}

{ #category : 'accessing' }
VDMPadCommandLineHandler class >> commandName [

	^ 'VDMPad'
]

{ #category : 'activation' }
VDMPadCommandLineHandler >> activateCommand [

	Smalltalk at: #VDMPad ifPresent: [ :vdmpad | vdmpad startService ]
]
