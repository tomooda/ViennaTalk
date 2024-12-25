Class {
	#name : 'ViennaEpiLogConstructionLineEnumerator',
	#superclass : 'ViennaEpiLogEnumerator',
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'accessing' }
ViennaEpiLogConstructionLineEnumerator >> diffSet: aViennaEpiLog [

	^ aViennaEpiLog diffSetFromPred
]

{ #category : 'accessing' }
ViennaEpiLogConstructionLineEnumerator >> prevFrom: aViennaEpiLog [

	^ aViennaEpiLog pred
]
