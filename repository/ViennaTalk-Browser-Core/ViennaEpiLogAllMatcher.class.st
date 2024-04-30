Class {
	#name : 'ViennaEpiLogAllMatcher',
	#superclass : 'ViennaEpiLogMatcher',
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'accessing' }
ViennaEpiLogAllMatcher >> name [

	^ '-- all --'
]

{ #category : 'accessing' }
ViennaEpiLogAllMatcher >> order [

	^ 0
]

{ #category : 'evaluation' }
ViennaEpiLogAllMatcher >> value: aViennaEpiLog [

	^ true
]
