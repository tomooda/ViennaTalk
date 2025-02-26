Class {
	#name : 'ViennaEpiLogUserTimelineEnumerator',
	#superclass : 'ViennaEpiLogEnumerator',
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'testing' }
ViennaEpiLogUserTimelineEnumerator >> accepts: aViennaEpiLog [

	^ true
]

{ #category : 'accessing' }
ViennaEpiLogUserTimelineEnumerator >> diffSet: aViennaEpiLog [

	^ aViennaEpiLog diffSetFromPrev
]

{ #category : 'accessing' }
ViennaEpiLogUserTimelineEnumerator >> icon [

	^ Smalltalk ui iconNamed: #userProfile
]

{ #category : 'accessing' }
ViennaEpiLogUserTimelineEnumerator >> prevFrom: aViennaEpiLog [

	^ aViennaEpiLog prev
]
