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
ViennaProfilerTest >> testActFinRdWrDo [

	| obj |
	obj := ViennaProfilerTestTarget new.
	profiler
		act: { {
				{ #Obj. #op }.
				obj.
				#op } }
		fin: { {
				{ #Obj. #op }.
				obj.
				#op } }
		rd: { {
				{ #Obj. #x }.
				obj.
				#x } }
		wr: { {
				{ #Obj. #y }.
				obj.
				#y } }
		do: [
			obj op.
			self
				assert: (ViennaActException signal: #op module: #Obj)
				equals: 1.
			self
				assert: (ViennaFinException signal: #op module: #Obj)
				equals: 1.
			self assert: (ViennaRdException signal: #x module: #Obj) equals: 2.
			self assert: (ViennaWrException signal: #y module: #Obj) equals: 1 ]
]
