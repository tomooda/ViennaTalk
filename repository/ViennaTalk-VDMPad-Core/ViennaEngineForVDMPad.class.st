Class {
	#name : 'ViennaEngineForVDMPad',
	#superclass : 'ViennaTranspilingEngine',
	#category : 'ViennaTalk-VDMPad-Core',
	#package : 'ViennaTalk-VDMPad-Core'
}

{ #category : 'accessing' }
ViennaEngineForVDMPad class >> engineType [

	^ nil
]

{ #category : 'accessing' }
ViennaEngineForVDMPad class >> priority [

	^ -1
]

{ #category : 'class access' }
ViennaEngineForVDMPad >> animationClass [

	^ ViennaAnimationForVDMPad
]
