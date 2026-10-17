Class {
	#name : 'ViennaFeedApplication',
	#superclass : 'ClapApplication',
	#category : 'ViennaTalk-Application',
	#package : 'ViennaTalk-Application'
}

{ #category : 'accessing' }
ViennaFeedApplication class >> requestExtension [

	^ 'request'
]

{ #category : 'accessing' }
ViennaFeedApplication class >> responseExtension [

	^ 'response'
]

{ #category : 'commandline' }
ViennaFeedApplication class >> vdmpad [

	<commandline>
	^ (ClapCommandSpec id: #VDMPad)
		  description: 'Web IDE for VDM-SL';
		  commandClass: self;
		  addHelp;
		  yourself
]

{ #category : 'accessing' }
ViennaFeedApplication class >> withRequestExtension: aFileReference [

	^ aFileReference withExtension: self requestExtension
]

{ #category : 'accessing' }
ViennaFeedApplication class >> withResponseExtension: aFileReference [

	^ aFileReference withExtension: self responseExtension
]

{ #category : 'execution' }
ViennaFeedApplication >> execute [

	Smalltalk at: #VDMPad ifPresent: [ :vdmpad | vdmpad startService ].
	self context doNotObeyExits
]
