Class {
	#name : 'ViennaProfilingException',
	#superclass : 'Exception',
	#instVars : [
		'module',
		'identifier'
	],
	#category : 'ViennaTalk-Profiler-Core',
	#package : 'ViennaTalk-Profiler-Core'
}

{ #category : 'signalling' }
ViennaProfilingException class >> signal: aString module: anotherString [

	^ self new
		  module: anotherString asSymbol;
		  identifier: aString asSymbol;
		  signal
]

{ #category : 'handling' }
ViennaProfilingException >> defaultAction [

	^ 0
]

{ #category : 'accessing' }
ViennaProfilingException >> identifier [

	^ identifier
]

{ #category : 'accessing' }
ViennaProfilingException >> identifier: aString [

	identifier := aString asSymbol
]

{ #category : 'accessing' }
ViennaProfilingException >> module [

	^ module
]

{ #category : 'accessing' }
ViennaProfilingException >> module: aString [

	module := aString asSymbol
]

{ #category : 'accessing' }
ViennaProfilingException >> value: aProfiler [

	^ self subclassResponsibility
]
