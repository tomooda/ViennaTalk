Class {
	#name : 'ViennaBankEngine',
	#superclass : 'ViennaEngine',
	#instVars : [
		'engines',
		'ringBufferIndex',
		'lock'
	],
	#category : 'ViennaTalk-Engine-VDMJ',
	#package : 'ViennaTalk-Engine-VDMJ'
}

{ #category : 'accessing' }
ViennaBankEngine class >> engineType [

	^ nil
]

{ #category : 'instance creation' }
ViennaBankEngine class >> new: anInteger [

	| bank |
	bank := self new.
	anInteger timesRepeat: [ bank add: ViennaVDMJ default ].
	^ bank
]

{ #category : 'accessing' }
ViennaBankEngine class >> priority [

	^ -1
]

{ #category : 'adding/removing' }
ViennaBankEngine >> add: aViennaBankEngine [
	lock critical: [ ^ engines add: aViennaBankEngine ]
]

{ #category : 'accessing' }
ViennaBankEngine >> close [
	engines do: [ :engine | engine close ]
]

{ #category : 'enumerating' }
ViennaBankEngine >> enginesDo: aBlock [
	engines do: aBlock
]

{ #category : 'evaluating' }
ViennaBankEngine >> evaluate: expression specification: specification states: states module: module [
	| engine |
	lock
		critical: [ 
			engines ifEmpty: [ ^ self error: 'no engine available' ].
			ringBufferIndex := ringBufferIndex \\ engines size + 1.
			engine := engines at: ringBufferIndex ].
	^ engine
		evaluate: expression
		specification: specification
		states: states
		module: module
]

{ #category : 'initialize-release' }
ViennaBankEngine >> initialize [
	super initialize.
	lock := Semaphore forMutualExclusion.
	engines := OrderedCollection new.
	ringBufferIndex := 0
]

{ #category : 'adding/removing' }
ViennaBankEngine >> remove: aViennaBankEngine ifAbsent: errorBlock [
	lock critical: [ ^ engines remove: aViennaBankEngine ifAbsent: errorBlock ]
]
