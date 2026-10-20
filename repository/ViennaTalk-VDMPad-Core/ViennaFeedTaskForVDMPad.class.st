Class {
	#name : 'ViennaFeedTaskForVDMPad',
	#superclass : 'ViennaFeedTask',
	#category : 'ViennaTalk-VDMPad-Core-Feed',
	#package : 'ViennaTalk-VDMPad-Core',
	#tag : 'Feed'
}

{ #category : 'class access' }
ViennaFeedTaskForVDMPad class >> workerClass [

	^ ViennaFeedWorkerPoolForVDMPad
]
