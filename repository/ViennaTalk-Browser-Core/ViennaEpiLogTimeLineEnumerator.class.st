Class {
	#name : 'ViennaEpiLogTimeLineEnumerator',
	#superclass : 'ViennaEpiLogEnumerator',
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'testing' }
ViennaEpiLogTimeLineEnumerator >> accepts: aViennaEpiLog [

	^ true
]

{ #category : 'accessing' }
ViennaEpiLogTimeLineEnumerator >> diffSet: aViennaEpiLog [

	^ aViennaEpiLog diffSetFromPrev
]

{ #category : 'accessing' }
ViennaEpiLogTimeLineEnumerator >> prevFrom: aViennaEpiLog [

	^ aViennaEpiLog prev
]
