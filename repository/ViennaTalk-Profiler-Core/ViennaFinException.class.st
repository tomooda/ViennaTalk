Class {
	#name : 'ViennaFinException',
	#superclass : 'ViennaProfilingException',
	#category : 'ViennaTalk-Profiler-Core',
	#package : 'ViennaTalk-Profiler-Core'
}

{ #category : 'accessing' }
ViennaFinException >> value: aProfiler [

	^ aProfiler numFin: identifier module: module
]
