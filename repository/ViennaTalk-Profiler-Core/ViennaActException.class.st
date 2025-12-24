Class {
	#name : 'ViennaActException',
	#superclass : 'ViennaProfilingException',
	#category : 'ViennaTalk-Profiler-Core',
	#package : 'ViennaTalk-Profiler-Core'
}

{ #category : 'accessing' }
ViennaActException >> value: aProfiler [

	^ aProfiler numAct: identifier module: module
]
