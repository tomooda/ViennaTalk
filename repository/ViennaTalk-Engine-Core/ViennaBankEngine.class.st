Class {
	#name : #ViennaBankEngine,
	#superclass : #ViennaEngine,
	#instVars : [
		'engines',
		'ringBufferIndex'
	],
	#category : 'ViennaTalk-Engine-Core'
}

{ #category : #'adding/removing' }
ViennaBankEngine >> add: aViennaBankEngine [
	^ engines add: aViennaBankEngine
]

{ #category : #enumerating }
ViennaBankEngine >> enginesDo: aBlock [
	engines do: aBlock
]

{ #category : #evaluating }
ViennaBankEngine >> evaluate: expression specification: specification states: states vdm10: vdm10 rtc: rtc [
	engines ifEmpty: [ ^ self error: 'no engine available' ].
	ringBufferIndex := ringBufferIndex \\ engines size + 1.
	^ (engines at: ringBufferIndex)
		evaluate: expression
		specification: specification
		states: states
		vdm10: vdm10
		rtc: rtc
]

{ #category : #'initialize-release' }
ViennaBankEngine >> initialize [
	super initialize.
	engines := OrderedCollection new.
	ringBufferIndex := 0
]

{ #category : #'adding/removing' }
ViennaBankEngine >> remove: aViennaBankEngine ifAbsent: errorBlock [
	^ engines remove: aViennaBankEngine ifAbsent: errorBlock
]
