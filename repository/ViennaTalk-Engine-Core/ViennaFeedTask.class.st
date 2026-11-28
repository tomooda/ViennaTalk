Class {
	#name : 'ViennaFeedTask',
	#superclass : 'FedPoolTask',
	#traits : 'TFedJson',
	#classTraits : 'TFedJson classTrait',
	#category : 'ViennaTalk-Engine-Core',
	#package : 'ViennaTalk-Engine-Core'
}

{ #category : 'class access' }
ViennaFeedTask class >> workerClass [

	^ ViennaFeedWorkerPool
]
