Class {
	#name : 'ViennaEpiLogArtifactTimelineEnumerator',
	#superclass : 'ViennaEpiLogEnumerator',
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'testing' }
ViennaEpiLogArtifactTimelineEnumerator >> accepts: aViennaEpiLog [

	^ aViennaEpiLog isPredEpiLog
]

{ #category : 'accessing' }
ViennaEpiLogArtifactTimelineEnumerator >> diffSet: aViennaEpiLog [

	^ aViennaEpiLog diffSetFromPred
]

{ #category : 'accessing' }
ViennaEpiLogArtifactTimelineEnumerator >> icon [

	^ Smalltalk ui iconNamed: #objects
]

{ #category : 'accessing' }
ViennaEpiLogArtifactTimelineEnumerator >> prevFrom: aViennaEpiLog [

	^ aViennaEpiLog pred
]
