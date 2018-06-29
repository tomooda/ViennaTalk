Class {
	#name : #LivelyWalkThrough,
	#superclass : #Model,
	#instVars : [
		'director'
	],
	#category : 'ViennaTalk-LivelyWalkThrough-Core'
}

{ #category : #'instance creation' }
LivelyWalkThrough class >> default [
	^ self on: LWTDirector default
]

{ #category : #'instance creation' }
LivelyWalkThrough class >> on: aLWTDirector [
	^ self new director: aLWTDirector
]

{ #category : #'instance creation' }
LivelyWalkThrough class >> vdmj [
	"LivelyWalkThrough vdmj open"

	^ self on: LWTDirector vdmj
]

{ #category : #'user interface' }
LivelyWalkThrough >> build [
	| pane utilsPane |
	pane := BorderedMorph new
		extent: 800 @ 400;
		color: Color transparent;
		changeProportionalLayout;
		yourself.
	utilsPane := LazyTabGroupMorph new.
	utilsPane
		addLazyPage: self buildVDMBrowserPane label: 'VDM';
		addLazyPage: self buildLivetalkBrowserPane label: 'Livetalk'.
	utilsPane selectedPageIndex: 1.
	pane
		addMorph: self director
		fullFrame:
			((0 @ 0 corner: 0.6 @ 1) asLayoutFrame
				bottomRightOffset: -3 @ 0;
				yourself).
	pane
		addMorph: utilsPane
		fullFrame:
			((0.6 @ 0 corner: 1 @ 1) asLayoutFrame
				topLeftOffset: 3 @ 0;
				yourself).
	pane addPaneSplitters.
	^ pane
]

{ #category : #'user interface' }
LivelyWalkThrough >> buildLivetalkBrowserPane [
	^ (LWTLivetalkBrowser on: self director) build
]

{ #category : #'user interface' }
LivelyWalkThrough >> buildVDMBrowserPane [
	^ (ViennaBrowser on: self director vdmc) build
]

{ #category : #accessing }
LivelyWalkThrough >> director [
	^ director
]

{ #category : #accessing }
LivelyWalkThrough >> director: aLWTDirector [
	director := aLWTDirector
]

{ #category : #'user interface' }
LivelyWalkThrough >> open [
	^ self openLabel: 'Lively Walk-Through'
]

{ #category : #'user interface' }
LivelyWalkThrough >> openLabel: aString [
	self build openInWindowLabeled: aString
]
