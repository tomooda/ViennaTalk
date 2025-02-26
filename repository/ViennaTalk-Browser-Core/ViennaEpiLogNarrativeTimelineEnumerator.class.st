Class {
	#name : 'ViennaEpiLogNarrativeTimelineEnumerator',
	#superclass : 'ViennaEpiLogEnumerator',
	#instVars : [
		'narrative'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaEpiLogNarrativeTimelineEnumerator class >> on: aHiDeNarrative [

	^ self new
		  narrative: aHiDeNarrative;
		  yourself
]

{ #category : 'testing' }
ViennaEpiLogNarrativeTimelineEnumerator >> accepts: aViennaEpiLog [

	^ narrative includes: aViennaEpiLog
]

{ #category : 'accessing' }
ViennaEpiLogNarrativeTimelineEnumerator >> diffSet: aViennaEpiLog [

	^ ViennaNodeDiffSet
		  from: ((self prevFrom: aViennaEpiLog)
				   ifNotNil: #specification
				   ifNil: [ ViennaModularDocumentNode new ])
		  to: aViennaEpiLog specification
]

{ #category : 'accessing' }
ViennaEpiLogNarrativeTimelineEnumerator >> from: aViennaEpiLog do: aBlock [

	(narrative includes: aViennaEpiLog)
		ifTrue: [ super from: aViennaEpiLog do: aBlock ]
		ifFalse: [ narrative do: aBlock ]
]

{ #category : 'accessing' }
ViennaEpiLogNarrativeTimelineEnumerator >> icon [

	^ Smalltalk ui iconNamed: #folder
]

{ #category : 'accessing' }
ViennaEpiLogNarrativeTimelineEnumerator >> name [

	^ narrative name
]

{ #category : 'accessing' }
ViennaEpiLogNarrativeTimelineEnumerator >> narrative [

	^ narrative
]

{ #category : 'accessing' }
ViennaEpiLogNarrativeTimelineEnumerator >> narrative: aHiDeNarrative [

	narrative := aHiDeNarrative
]

{ #category : 'accessing' }
ViennaEpiLogNarrativeTimelineEnumerator >> prevFrom: aViennaEpiLog [

	^ (narrative ifNotNil: #asArray) ifNotNil: [ :epiLogs |
		  | index |
		  index := epiLogs indexOf: aViennaEpiLog.
		  (index between: 1 and: epiLogs size - 1)
			  ifTrue: [ epiLogs at: index + 1 ]
			  ifFalse: [ nil ] ]
]
