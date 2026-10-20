Class {
	#name : 'ViennaEngineForVDMPad',
	#superclass : 'ViennaTranspilingEngine',
	#category : 'ViennaTalk-VDMPad-Core-Engine',
	#package : 'ViennaTalk-VDMPad-Core',
	#tag : 'Engine'
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
