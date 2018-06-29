Class {
	#name : #ViennaAnimationTest,
	#superclass : #TestCase,
	#instVars : [
		'animation'
	],
	#category : 'ViennaTalk-Animation-Tests'
}

{ #category : #running }
ViennaAnimationTest >> setUp [
	animation := ViennaAnimation default
]

{ #category : #tests }
ViennaAnimationTest >> testAt [
	animation specification: '
	state S of 
		x : int 
		init s == s = mk_S(0) 
	end'.
	animation init.
	self assert: (animation at: 'DEFAULT`x') equals: 0.
]

{ #category : #tests }
ViennaAnimationTest >> testAtPut [
	animation specification: '
	state S of 
		x : int 
		init s == s = mk_S(0)
	end
	operations
		get : () ==> int
		get() == return x;'.
	animation at: 'DEFAULT`x' put: 10.
	self assert: (animation evaluate: 'get()') equals: 10.
]

{ #category : #tests }
ViennaAnimationTest >> testEval1 [
	self assert: (animation evaluate: '1+2') equals: 3
]

{ #category : #tests }
ViennaAnimationTest >> testEval2 [
	animation specification: 'values one = 1;'.
	self assert: (animation evaluate: 'one + 2') equals: 3.
]

{ #category : #tests }
ViennaAnimationTest >> testSpecification [
	| spec |
	spec := 'values one = 1;'.
	animation specification: spec copy.
	self assert: animation specification equals: spec.
]
