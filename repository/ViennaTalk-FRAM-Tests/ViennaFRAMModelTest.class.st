Class {
	#name : 'ViennaFRAMModelTest',
	#superclass : 'TestCase',
	#instVars : [
		'parser',
		'model'
	],
	#category : 'ViennaTalk-FRAM-Tests',
	#package : 'ViennaTalk-FRAM-Tests'
}

{ #category : 'running' }
ViennaFRAMModelTest >> setUp [

	model := ViennaFRAMModel new
]

{ #category : 'tests' }
ViennaFRAMModelTest >> testLoadSpec [

	| spec |
	model
		newFunctionNamed: 'find pedestrian';
		newOutputOf: 'find pedestrian' named: 'new pedestrian'.
	spec := ViennaVDMParser current parse: 'operations
	--@FRAM OUTPUT current count
	--@FRAM INPUT new pedestrian
	inc : () ==> nat
	inc() == (count := count + 1; return count)'.
	model loadSpec: spec.
	self assert: model functions size equals: 2.
	self assert: model functions second name equals: 'inc'.
	self assert: model functions second isTechnological.
	self assert: model inputs size equals: 1.
	self assert: model inputs first name = 'new pedestrian'.
	self assert: model inputs first function equals: 1.
	self assert: model outputs size equals: 2.
	self assert: model outputs second name = 'current count'.
	self assert: model outputs second function equals: 1
]
