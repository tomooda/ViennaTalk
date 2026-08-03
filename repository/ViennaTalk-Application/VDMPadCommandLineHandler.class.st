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
VDMPadCommandLineHandler >> activate [

	Smalltalk at: #VDMPad ifPresent: [ :vdmpad | vdmpad startService ]
]
