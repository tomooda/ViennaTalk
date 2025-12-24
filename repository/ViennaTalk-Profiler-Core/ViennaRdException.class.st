Class {
	#name : 'ViennaRdException',
	#superclass : 'ViennaProfilingException',
	#category : 'ViennaTalk-Profiler-Core',
	#package : 'ViennaTalk-Profiler-Core'
}

{ #category : 'accessing' }
ViennaRdException >> value: aProfiler [

	^ aProfiler numRd: identifier module: module
]
