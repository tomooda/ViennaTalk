Class {
	#name : #ViennaClientTest,
	#superclass : #TestCase,
	#instVars : [
		'fixture'
	],
	#category : 'ViennaTalk-Engine-Tests'
}

{ #category : #running }
ViennaClientTest >> setUp [
	fixture := ViennaClient on: 'http://localhost:8088/'.
	ViennaServer installHandler
]

{ #category : #private }
ViennaClientTest >> stateFromArray: anArray [
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

{ #category : #tests }
ViennaClientTest >> testBadSpec [
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}}).
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
]

{ #category : #private }
ViennaClientTest >> testExpression: expression specification: specification states: states resultValue: resultValue resultStates: resultStates [
	ViennaServer
		ensureServeIn: [ 
			(fixture
				evaluate: expression
				specification: specification
				states: states
				vdm10: true
				rtc: true)
				in: [ :triple | 
					self assert: resultValue equals: triple first.
					self assert: resultStates equals: triple second.
					self assert: resultValue isNil equals: triple third notEmpty ] ]
]

{ #category : #tests }
ViennaClientTest >> testOKSpec [
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}})
		resultValue: '1'
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '1'}}).
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
		resultValue: '442'
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '442'}})
]
