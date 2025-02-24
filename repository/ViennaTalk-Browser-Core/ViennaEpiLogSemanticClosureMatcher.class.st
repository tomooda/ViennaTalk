Class {
	#name : 'ViennaEpiLogSemanticClosureMatcher',
	#superclass : 'ViennaEpiLogMatcher',
	#instVars : [
		'closure'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaEpiLogSemanticClosureMatcher class >> fromEpiLog: aViennaEpiLog enumerator: aViennaEpiLogEnumerator at: anotherViennaEpiLog [

	^ self new
		  initializeWithEpiLog: aViennaEpiLog
		  enumerator: aViennaEpiLogEnumerator
		  at: anotherViennaEpiLog;
		  yourself
]

{ #category : 'accessing' }
ViennaEpiLogSemanticClosureMatcher >> closure [

	^ closure
]

{ #category : 'accessing' }
ViennaEpiLogSemanticClosureMatcher >> closure: aCollectionOfViennaEpiLog [

	closure := aCollectionOfViennaEpiLog
]

{ #category : 'accessing' }
ViennaEpiLogSemanticClosureMatcher >> icon [

	^ Smalltalk ui iconNamed: #exception
]

{ #category : 'initialization' }
ViennaEpiLogSemanticClosureMatcher >> initializeWithEpiLog: aViennaEpiLog enumerator: aViennaEpiLogEnumerator at: anotherViennaEpiLog [

	closure := ViennaHiDeSorter
		           semanticClosureFrom: aViennaEpiLog
		           withEnumerator: aViennaEpiLogEnumerator
		           at: anotherViennaEpiLog
]

{ #category : 'accessing' }
ViennaEpiLogSemanticClosureMatcher >> name [

	^ 'semantic closure'
]

{ #category : 'accessing' }
ViennaEpiLogSemanticClosureMatcher >> order [

	^ 71
]

{ #category : 'evaluation' }
ViennaEpiLogSemanticClosureMatcher >> value: aViennaEpiLog [

	^ closure includes: aViennaEpiLog
]
