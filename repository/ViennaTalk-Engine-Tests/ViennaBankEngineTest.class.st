Class {
	#name : #ViennaBankEngineTest,
	#superclass : #TestCase,
	#instVars : [
		'fixture'
	],
	#category : #'ViennaTalk-Engine-Tests'
}

{ #category : #tests }
ViennaBankEngineTest >> test5times [
	| bank |
	bank := ViennaBankEngine new.
	5 timesRepeat: [ bank add: ViennaVDMJ new ].
	5
		timesRepeat: [ (bank evaluate: '1+2' specification: '' states: Dictionary new)
				in: [ :triple | 
					self assert: '3' equals: triple first.
					self assert: Dictionary new equals: triple second.
					self assert: triple third isEmpty ] ]
]
