Class {
	#name : 'ViennaFeedEngineForVDMPad',
	#superclass : 'ViennaFeedEngine',
	#category : 'ViennaTalk-VDMPad-Core-Feed',
	#package : 'ViennaTalk-VDMPad-Core',
	#tag : 'Feed'
}

{ #category : 'accessing' }
ViennaFeedEngineForVDMPad class >> engineType [

	^ nil
]

{ #category : 'accessing' }
ViennaFeedEngineForVDMPad class >> priority [

	^ -1
]

{ #category : 'class access' }
ViennaFeedEngineForVDMPad >> taskClass [

	^ ViennaFeedTaskForVDMPad
]
