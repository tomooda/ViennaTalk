Class {
	#name : 'ViennaFeedTask',
	#superclass : 'FedJsonPoolTask',
	#category : 'ViennaTalk-Engine-Core',
	#package : 'ViennaTalk-Engine-Core'
}

{ #category : 'class access' }
ViennaFeedTask class >> workerClass [

	^ ViennaFeedWorkerPool
]
