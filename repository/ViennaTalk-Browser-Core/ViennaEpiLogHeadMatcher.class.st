Class {
	#name : 'ViennaEpiLogHeadMatcher',
	#superclass : 'ViennaEpiLogMatcher',
	#instVars : [
		'heads',
		'head',
		'icon'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaEpiLogHeadMatcher class >> from: aViennaEpiLog [

	^ self new
		  initializeWith: aViennaEpiLog;
		  yourself
]

{ #category : 'accessing' }
ViennaEpiLogHeadMatcher >> icon [

	<script: 'ViennaEpiLogHeadMatcher new icon inspect'>
	^ icon ifNil: [
		  | form fillColor a |
		  fillColor := Color white.
		  form := Form extent: 24 @ 24 depth: 32.
		  a := 8.
		  form getCanvas
			  line: 12 @ 10
			  to: 12 @ 24
			  width: 4
			  color: Color blue muchDarker;
			  fillOval: (Rectangle center: 12 @ 10 extent: 8 @ 8)
			  color: Color cyan
			  borderWidth: 2
			  borderColor: Color blue muchDarker;
			  fillOval: (Rectangle center: 12 @ 20 extent: 8 @ 8)
			  color: Color cyan
			  borderWidth: 2
			  borderColor: Color blue muchDarker;
			  flush.
		  icon := form scaledToSize: 16 @ 16 ]
]

{ #category : 'accessing' }
ViennaEpiLogHeadMatcher >> initializeWith: aViennaEpiLog [

	| chronicle |
	heads := IdentitySet withAll:
		         (chronicle := aViennaEpiLog hideStorage chronicle).
	chronicle do: [ :epiLog | heads remove: epiLog prev ifAbsent: [  ] ].
	heads add: aViennaEpiLog
]

{ #category : 'accessing' }
ViennaEpiLogHeadMatcher >> name [

	^ 'HEAD'
]

{ #category : 'accessing' }
ViennaEpiLogHeadMatcher >> order [

	^ 60
]

{ #category : 'evaluation' }
ViennaEpiLogHeadMatcher >> value: aViennaEpiLog [

	^ heads includes: aViennaEpiLog
]
