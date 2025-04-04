Class {
	#name : 'ViennaProfilerTest',
	#superclass : 'TestCase',
	#instVars : [
		'profiler'
	],
	#category : 'ViennaTalk-Profiler-Tests',
	#package : 'ViennaTalk-Profiler-Tests'
}

{ #category : 'running' }
ViennaProfilerTest >> setUp [

	profiler := ViennaProfiler new
]

{ #category : 'running' }
ViennaProfilerTest >> testActRdWrDo [

	| obj |
	obj := ViennaProfilerTestTarget new.
	profiler
		act: { {
				obj.
				#op } }
		rd: { {
				obj.
				#x } }
		wr: { {
				obj.
				#y } }
		do: [ obj op ].
	self
		assert: (profiler numAct: #op module: #ViennaProfilerTestTarget)
		equals: 1.
	self
		assert: (profiler numRd: #x module: #ViennaProfilerTestTarget)
		equals: 2.
	self
		assert: (profiler numWr: #y module: #ViennaProfilerTestTarget)
		equals: 1
]
