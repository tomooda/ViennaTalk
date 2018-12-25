Class {
	#name : #ViennaBankEngine,
	#superclass : #ViennaEngine,
	#instVars : [
		'engines',
		'ringBufferIndex',
		'lock'
	],
	#category : 'ViennaTalk-Engine-Core'
}

{ #category : #'adding/removing' }
ViennaBankEngine >> add: aViennaBankEngine [
	lock critical: [ ^ engines add: aViennaBankEngine ]
]

{ #category : #accessing }
ViennaBankEngine >> close [
	engines do: [ :engine | engine close ]
]

{ #category : #enumerating }
ViennaBankEngine >> enginesDo: aBlock [
	engines do: aBlock
]

{ #category : #evaluating }
ViennaBankEngine >> evaluate: expression specification: specification states: states module: module vdm10: vdm10 rtc: rtc [
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
		vdm10: vdm10
		rtc: rtc
]

{ #category : #'initialize-release' }
ViennaBankEngine >> initialize [
	super initialize.
	lock := Semaphore forMutualExclusion.
	engines := OrderedCollection new.
	ringBufferIndex := 0
]

{ #category : #'adding/removing' }
ViennaBankEngine >> remove: aViennaBankEngine ifAbsent: errorBlock [
	lock critical: [ ^ engines remove: aViennaBankEngine ifAbsent: errorBlock ]
]
