Class {
	#name : 'ViennaHiDeSorter',
	#superclass : 'HiDeSorter',
	#category : 'ViennaTalk-Browser-Core-HiDeHo',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'HiDeHo'
}

{ #category : 'utilities' }
ViennaHiDeSorter class >> contextualClosureFrom: aViennaEpiLog withEnumerator: aViennaEpiLogEnumerator [

	| matcher sorter |
	matcher := ViennaContextualHiDeMatcher new
		           epiLogEnumerator: aViennaEpiLogEnumerator;
		           yourself.
	sorter := self new
		          matcher: matcher;
		          yourself.
	aViennaEpiLogEnumerator from: aViennaEpiLog do: [ :epiLog |
		epiLog isSemanticClosureMember ifTrue: [ sorter add: epiLog ] ].
	^ Array streamContents: [ :stream |
		  (sorter
			   nodeAt: (sorter identityIndexOf: aViennaEpiLog)
			   ifAbsent: [ { aViennaEpiLog } ]) do: [ :epiLog |
			  stream nextPut: epiLog ] ]
]

{ #category : 'utilities' }
ViennaHiDeSorter class >> semanticClosureFrom: aViennaEpiLog withEnumerator: aViennaEpiLogEnumerator [

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
			   nodeAt: (sorter identityIndexOf: aViennaEpiLog)
			   ifAbsent: [ { aViennaEpiLog } ]) do: [ :epiLog |
			  stream nextPut: epiLog ] ]
]

{ #category : 'utilities' }
ViennaHiDeSorter class >> syntacticClosureFrom: aViennaEpiLog withEnumerator: aViennaEpiLogEnumerator [

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
			   nodeAt: (sorter identityIndexOf: aViennaEpiLog)
			   ifAbsent: [ { aViennaEpiLog } ]) do: [ :epiLog |
			  stream nextPut: epiLog ] ]
]

{ #category : 'accessing' }
ViennaHiDeSorter >> nodeAt: anInteger ifAbsent: aBlockClosure [

	^ closure nodeAt: anInteger ifAbsent: aBlockClosure
]
