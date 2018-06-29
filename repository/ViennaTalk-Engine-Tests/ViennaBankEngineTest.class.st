Class {
	#name : #ViennaBankEngineTest,
	#superclass : #TestCase,
	#instVars : [
		'fixture'
	],
	#category : 'ViennaTalk-Engine-Tests'
}

{ #category : #tests }
ViennaBankEngineTest >> test20times [
	| bank sem count |
	bank := ViennaBankEngine new.
	5 timesRepeat: [ bank add: ViennaVDMJ new ].
	sem := Semaphore forMutualExclusion.
	count := 0.
	20
		timesRepeat: [ 
			[ 
			(bank evaluate: '1+2' specification: '' states: Dictionary new)
				in: [ :triple | 
					self assert: '3' equals: triple first.
					self assert: Dictionary new equals: triple second.
					self assert: triple third isEmpty ].
			sem critical: [ count := count + 1 ] ] forkAt: Processor userBackgroundPriority ].
	[ count < 20 ] whileTrue: [ (Delay forMilliseconds: 100) wait ]
]
