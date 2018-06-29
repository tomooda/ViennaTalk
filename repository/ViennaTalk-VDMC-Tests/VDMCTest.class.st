Class {
	#name : #VDMCTest,
	#superclass : #TestCase,
	#instVars : [
		'vdmc'
	],
	#category : 'ViennaTalk-VDMC-Tests'
}

{ #category : #running }
VDMCTest >> setUp [
	vdmc := VDMC new
]

{ #category : #tests }
VDMCTest >> testAt [
	vdmc specification: '
	state S of 
		x : int 
		init s == s = mk_S(0) 
	end'.
	vdmc init.
	self assert: (vdmc at: 'DEFAULT`x') equals: 0.
]

{ #category : #tests }
VDMCTest >> testAtPut [
	vdmc specification: '
	state S of 
		x : int 
		init s == s = mk_S(0)
	end
	operations
		get : () ==> int
		get() == return x;'.
	vdmc at: 'DEFAULT`x' put: 10.
	self assert: (vdmc evaluate: 'get()') equals: 10.
]

{ #category : #tests }
VDMCTest >> testEval1 [
	self assert: (vdmc evaluate: '1+2') equals: 3
]

{ #category : #tests }
VDMCTest >> testEval2 [
	vdmc specification: 'values one = 1;'.
	self assert: (vdmc evaluate: 'one + 2') equals: 3.
]

{ #category : #tests }
VDMCTest >> testSpecification [
	| spec |
	spec := 'values one = 1;'.
	vdmc specification: spec copy.
	self assert: vdmc specification equals: spec.
]
