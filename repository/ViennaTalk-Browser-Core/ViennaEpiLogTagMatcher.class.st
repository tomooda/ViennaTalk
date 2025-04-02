Class {
	#name : 'ViennaEpiLogTagMatcher',
	#superclass : 'ViennaEpiLogMatcher',
	#instVars : [
		'tag',
		'icon'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaEpiLogTagMatcher class >> on: aString [

	^ self new
		  tag: aString;
		  yourself
]

{ #category : 'accessing' }
ViennaEpiLogTagMatcher >> icon [

	^ icon ifNil: [
		  | form fillColor a |
		  fillColor := Color white.
		  form := Form extent: 24 @ 24 depth: 32.
		  a := 8.
		  form getCanvas
			  drawPolygon: {
					  (4 @ 4).
					  (4 + a @ 4).
					  (23 @ (23 - a)).
					  (23 - a @ 23).
					  (4 @ (a + 4)) }
			  color: Color white
			  borderWidth: 1
			  borderColor: Color black;
			  flush.
		  icon := form scaledToSize: 16 @ 16 ]
]

{ #category : 'accessing' }
ViennaEpiLogTagMatcher >> name [

	^ tag asString
]

{ #category : 'accessing' }
ViennaEpiLogTagMatcher >> order [

	^ 30
]

{ #category : 'accessing' }
ViennaEpiLogTagMatcher >> tag [

	^ tag
]

{ #category : 'accessing' }
ViennaEpiLogTagMatcher >> tag: aString [

	tag := aString
]

{ #category : 'evaluation' }
ViennaEpiLogTagMatcher >> value: aViennaEpiLog [

	^ aViennaEpiLog hasTag: tag
]
