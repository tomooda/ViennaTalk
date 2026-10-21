Class {
	#name : 'VDMPadTask',
	#superclass : 'FedPoolTask',
	#traits : 'TFedJson',
	#classTraits : 'TFedJson classTrait',
	#category : 'ViennaTalk-VDMPad-Core-Feed',
	#package : 'ViennaTalk-VDMPad-Core',
	#tag : 'Feed'
}

{ #category : 'request handling-api' }
VDMPadTask class >> eval: aJsonObject [

	^ self value: (aJsonObject
			   at: 'api' put: 'eval';
			   yourself)
]

{ #category : 'class access' }
VDMPadTask class >> workerClass [

	^ VDMPadWorkerPool
]
