Class {
	#name : 'ViennaEpiLogExecutionClosureMatcher',
	#superclass : 'ViennaEpiLogMatcher',
	#instVars : [
		'closure'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaEpiLogExecutionClosureMatcher class >> fromEpiLog: aViennaEpiLog enumerator: aViennaEpiLogEnumerator at: anotherViennaEpiLog [

	^ self new
		  initializeWithEpiLog: aViennaEpiLog
		  enumerator: aViennaEpiLogEnumerator
		  at: anotherViennaEpiLog;
		  yourself
]

{ #category : 'accessing' }
ViennaEpiLogExecutionClosureMatcher >> closure [

	^ closure
]

{ #category : 'accessing' }
ViennaEpiLogExecutionClosureMatcher >> closure: aCollectionOfViennaEpiLog [

	closure := aCollectionOfViennaEpiLog
]

{ #category : 'accessing' }
ViennaEpiLogExecutionClosureMatcher >> icon [

	^ Smalltalk ui iconNamed: #exception
]

{ #category : 'initialization' }
ViennaEpiLogExecutionClosureMatcher >> initializeWithEpiLog: aViennaEpiLog enumerator: aViennaEpiLogEnumerator at: anotherViennaEpiLog [

	closure := ViennaHiDeSorter
		           executionClosureFrom: aViennaEpiLog
		           withEnumerator: aViennaEpiLogEnumerator
		           at: anotherViennaEpiLog
]

{ #category : 'accessing' }
ViennaEpiLogExecutionClosureMatcher >> name [

	^ 'execution closure'
]

{ #category : 'accessing' }
ViennaEpiLogExecutionClosureMatcher >> order [

	^ 72
]

{ #category : 'evaluation' }
ViennaEpiLogExecutionClosureMatcher >> value: aViennaEpiLog [

	^ closure includes: aViennaEpiLog
]
