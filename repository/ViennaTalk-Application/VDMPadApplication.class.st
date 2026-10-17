Class {
	#name : 'VDMPadApplication',
	#superclass : 'ClapApplication',
	#category : 'ViennaTalk-Application',
	#package : 'ViennaTalk-Application'
}

{ #category : 'commandline' }
VDMPadApplication class >> feed [

	<commandline>
	^ (ClapCommandSpec id: #feed)
		  description: 'A worker process for evaluation and execution of VDM-SL';
		  commandClass: self;
		  addHelp;
		  yourself
]

{ #category : 'execution' }
VDMPadApplication >> execute [

	Smalltalk at: #VDMPad ifPresent: [ :vdmpad | vdmpad startService ].
	self context doNotObeyExits
]
