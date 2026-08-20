Class {
	#name : 'VDMPadApplication',
	#superclass : 'ClapApplication',
	#category : 'ViennaTalk-Application',
	#package : 'ViennaTalk-Application'
}

{ #category : 'commandline' }
VDMPadApplication class >> vdmpad [

	<commandline>
	^ (ClapCommandSpec id: #VDMPad)
		  description: 'Web IDE for VDM-SL';
		  commandClass: self;
		  addHelp;
		  yourself
]

{ #category : 'execution' }
VDMPadApplication >> execute [

	Smalltalk at: #VDMPad ifPresent: [ :vdmpad | vdmpad startService ]
]
