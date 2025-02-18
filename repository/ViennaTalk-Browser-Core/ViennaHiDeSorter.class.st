Class {
	#name : 'ViennaHiDeSorter',
	#superclass : 'HiDeSorter',
	#category : 'ViennaTalk-Browser-Core-HiDeHo',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'HiDeHo'
}

{ #category : 'utilities' }
ViennaHiDeSorter class >> executionClosureFrom: aViennaEpiLog withEnumerator: aViennaEpiLogEnumerator at: anotherViennaEpiLog [

	| matcher sorter |
	matcher := ViennaExecutionHiDeMatcher new
		           epiLogEnumerator: aViennaEpiLogEnumerator;
		           yourself.
	sorter := self new
		          matcher: matcher;
		          yourself.
	aViennaEpiLogEnumerator from: aViennaEpiLog do: [ :epiLog |
		epiLog isExecutionClosureMember ifTrue: [ sorter add: epiLog ] ].
	^ Array streamContents: [ :stream |
		  (sorter
			   nodeAt: (sorter identityIndexOf: anotherViennaEpiLog)
			   ifAbsent: [ { anotherViennaEpiLog } ]) do: [ :epiLog |
			  stream nextPut: epiLog ] ]
]

{ #category : 'utilities' }
ViennaHiDeSorter class >> semanticClosureFrom: aViennaEpiLog withEnumerator: aViennaEpiLogEnumerator at: anotherViennaEpiLog [

	| matcher sorter |
	matcher := ViennaSemanticHiDeMatcher new
		           epiLogEnumerator: aViennaEpiLogEnumerator;
		           yourself.
	sorter := self new
		          matcher: matcher;
		          yourself.
	aViennaEpiLogEnumerator from: aViennaEpiLog do: [ :epiLog |
		epiLog isSemanticClosureMember ifTrue: [ sorter add: epiLog ] ].
	^ Array streamContents: [ :stream |
		  (sorter
			   nodeAt: (sorter identityIndexOf: anotherViennaEpiLog)
			   ifAbsent: [ { anotherViennaEpiLog } ]) do: [ :epiLog |
			  stream nextPut: epiLog ] ]
]

{ #category : 'utilities' }
ViennaHiDeSorter class >> syntacticClosureFrom: aViennaEpiLog withEnumerator: aViennaEpiLogEnumerator at: anotherViennaEpiLog [

	| matcher sorter |
	matcher := ViennaSyntacticHiDeMatcher new
		           epiLogEnumerator: aViennaEpiLogEnumerator;
		           yourself.
	sorter := self new
		          matcher: matcher;
		          yourself.
	aViennaEpiLogEnumerator from: aViennaEpiLog do: [ :epiLog |
		epiLog isSyntacticClosureMember ifTrue: [ sorter add: epiLog ] ].
	^ Array streamContents: [ :stream |
		  (sorter
			   nodeAt: (sorter identityIndexOf: anotherViennaEpiLog)
			   ifAbsent: [ { anotherViennaEpiLog } ]) do: [ :epiLog |
			  stream nextPut: epiLog ] ]
]

{ #category : 'accessing' }
ViennaHiDeSorter >> nodeAt: anInteger ifAbsent: aBlockClosure [

	^ closure nodeAt: anInteger ifAbsent: aBlockClosure
]
