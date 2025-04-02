Class {
	#name : 'ViennaEpiLogBranchMatcher',
	#superclass : 'ViennaEpiLogMatcher',
	#instVars : [
		'branches'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'instance creation' }
ViennaEpiLogBranchMatcher class >> from: aViennaEpiLog [

	^ self new
		  initializeWith: aViennaEpiLog;
		  yourself
]

{ #category : 'accessing' }
ViennaEpiLogBranchMatcher >> icon [

	^ Smalltalk ui iconNamed: #branch
]

{ #category : 'initialization' }
ViennaEpiLogBranchMatcher >> initializeWith: aViennaEpiLog [

	branches := IdentitySet new.
	aViennaEpiLog hideStorage chronicle do: [ :epiLog |
		epiLog isRevertionEpiLog ifTrue: [ branches add: epiLog destination ] ]
]

{ #category : 'accessing' }
ViennaEpiLogBranchMatcher >> name [

	^ 'BRANCHES'
]

{ #category : 'accessing' }
ViennaEpiLogBranchMatcher >> order [

	^ 61
]

{ #category : 'evaluation' }
ViennaEpiLogBranchMatcher >> value: aViennaEpiLog [

	^ branches includes: aViennaEpiLog
]
