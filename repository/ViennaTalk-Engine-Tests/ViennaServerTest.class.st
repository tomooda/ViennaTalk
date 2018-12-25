Class {
	#name : #ViennaServerTest,
	#superclass : #TestCase,
	#instVars : [
		'fixture'
	],
	#category : 'ViennaTalk-Engine-Tests'
}

{ #category : #running }
ViennaServerTest >> setUp [
	fixture := ViennaServer new
]

{ #category : #private }
ViennaServerTest >> stateFromArray: anArray [
	| state |
	state := Dictionary new: anArray size.
	anArray
		do: [ :moduleAndBinds | 
			| binds |
			binds := Dictionary new: moduleAndBinds value size.
			state at: moduleAndBinds key put: binds.
			moduleAndBinds value do: [ :assoc | binds add: assoc ] ].
	^ state
]

{ #category : #'tests-empty' }
ViennaServerTest >> test0 [
	self
		testExpression: ''
		specification: ''
		states: Dictionary new
		resultValue: ''
		resultStates: Dictionary new
]

{ #category : #'tests-empty' }
ViennaServerTest >> test20times [
	| sem count |
	sem := Semaphore forMutualExclusion .
	count := 0.
	20 timesRepeat: [
		[self
		testExpression: '1+2'
		specification: ''
		states: Dictionary new
		resultValue: '3'
		resultStates: Dictionary new.
		sem critical: [ count := count + 1]] forkAt: Processor userBackgroundPriority ].
	[ count < 20 ] whileTrue: [ (Delay forMilliseconds: 100) wait ]
]

{ #category : #private }
ViennaServerTest >> testExpression: expression specification: specification states: states resultValue: resultValue resultStates: resultStates [ 
	(fixture
		evaluate: expression
		specification: specification
		states: states
		vdm10: true
		rtc: true)
		in: [:triple | 
			self assert: resultValue equals: triple first.
			self assert: resultStates equals: triple second.
			self assert: resultValue isNil equals: triple third notEmpty]
]
