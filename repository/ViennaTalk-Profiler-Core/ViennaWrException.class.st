Class {
	#name : 'ViennaWrException',
	#superclass : 'ViennaProfilingException',
	#category : 'ViennaTalk-Profiler-Core',
	#package : 'ViennaTalk-Profiler-Core'
}

{ #category : 'accessing' }
ViennaWrException >> value: aProfiler [

	^ aProfiler numWr: identifier module: module
]
