Class {
	#name : 'ViennaEpiLogImpactClosureMatcher',
	#superclass : 'ViennaEpiLogMatcher',
	#instVars : [
		'closure'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaEpiLogImpactClosureMatcher class >> fromEpiLog: aViennaEpiLog enumerator: aViennaEpiLogEnumerator [

	^ self new
		  initializeWithEpiLog: aViennaEpiLog
		  enumerator: aViennaEpiLogEnumerator;
		  yourself
]

{ #category : 'accessing' }
ViennaEpiLogImpactClosureMatcher >> closure [

	^ closure
]

{ #category : 'accessing' }
ViennaEpiLogImpactClosureMatcher >> closure: aCollectionOfViennaEpiLog [

	closure := aCollectionOfViennaEpiLog
]

{ #category : 'initialization' }
ViennaEpiLogImpactClosureMatcher >> initializeWithEpiLog: aViennaEpiLog enumerator: aViennaEpiLogEnumerator [

	closure := ViennaHiDeSorter
		           contextualClosureFrom: aViennaEpiLog
		           withEnumerator: aViennaEpiLogEnumerator
]

{ #category : 'accessing' }
ViennaEpiLogImpactClosureMatcher >> name [

	^ 'impact closure'
]

{ #category : 'accessing' }
ViennaEpiLogImpactClosureMatcher >> order [

	^ 5
]

{ #category : 'evaluation' }
ViennaEpiLogImpactClosureMatcher >> value: aViennaEpiLog [

	^ closure includes: aViennaEpiLog
]
