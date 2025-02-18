Class {
	#name : 'ViennaEpiLogSyntacticClosureMatcher',
	#superclass : 'ViennaEpiLogMatcher',
	#instVars : [
		'closure'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaEpiLogSyntacticClosureMatcher class >> fromEpiLog: aViennaEpiLog enumerator: aViennaEpiLogEnumerator at: anotherViennaEpiLog [

	^ self new
		  initializeWithEpiLog: aViennaEpiLog
		  enumerator: aViennaEpiLogEnumerator
		  at: anotherViennaEpiLog;
		  yourself
]

{ #category : 'accessing' }
ViennaEpiLogSyntacticClosureMatcher >> closure [

	^ closure
]

{ #category : 'accessing' }
ViennaEpiLogSyntacticClosureMatcher >> closure: aCollectionOfViennaEpiLog [

	closure := aCollectionOfViennaEpiLog
]

{ #category : 'initialization' }
ViennaEpiLogSyntacticClosureMatcher >> initializeWithEpiLog: aViennaEpiLog enumerator: aViennaEpiLogEnumerator at: anotherViennaEpiLog [

	closure := ViennaHiDeSorter
		           syntacticClosureFrom: aViennaEpiLog
		           withEnumerator: aViennaEpiLogEnumerator
		           at: anotherViennaEpiLog
]

{ #category : 'accessing' }
ViennaEpiLogSyntacticClosureMatcher >> name [

	^ 'syntactic closure'
]

{ #category : 'accessing' }
ViennaEpiLogSyntacticClosureMatcher >> order [

	^ 5
]

{ #category : 'evaluation' }
ViennaEpiLogSyntacticClosureMatcher >> value: aViennaEpiLog [

	^ closure includes: aViennaEpiLog
]
