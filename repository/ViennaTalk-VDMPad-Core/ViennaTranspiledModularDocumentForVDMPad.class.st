Class {
	#name : 'ViennaTranspiledModularDocumentForVDMPad',
	#superclass : 'ViennaTranspiledModularDocumentForExecutionTracing',
	#instVars : [
		'_steps',
		'_max_steps'
	],
	#category : 'ViennaTalk-VDMPad-Core',
	#package : 'ViennaTalk-VDMPad-Core'
}

{ #category : 'accessing' }
ViennaTranspiledModularDocumentForVDMPad >> _max_steps [

	^ _max_steps
]

{ #category : 'accessing' }
ViennaTranspiledModularDocumentForVDMPad >> _max_steps: anInteger [

	_max_steps := anInteger
]

{ #category : 'private' }
ViennaTranspiledModularDocumentForVDMPad >> _step: anObject [

	_max_steps < (_steps := _steps + 1) ifTrue: [
		^ ViennaNumStepsExceeded signal: self ].
	Processor yield.
	^ anObject
]

{ #category : 'accessing' }
ViennaTranspiledModularDocumentForVDMPad >> _steps [

	^ _steps
]

{ #category : 'accessing' }
ViennaTranspiledModularDocumentForVDMPad >> _steps: anInteger [

	_steps := anInteger
]

{ #category : 'defaults' }
ViennaTranspiledModularDocumentForVDMPad >> defaultMaxSteps [

	^ 10000
]

{ #category : 'initialize' }
ViennaTranspiledModularDocumentForVDMPad >> initialize [

	super initialize.
	_max_steps := self defaultMaxSteps.
	_steps := 0
]

{ #category : 'initialize' }
ViennaTranspiledModularDocumentForVDMPad >> initialize: anInteger [

	super initialize: anInteger.
	_max_steps := self defaultMaxSteps.
	_steps := 0
]
