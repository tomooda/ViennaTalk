Class {
	#name : 'ViennaEpiLogModuleMatcher',
	#superclass : 'ViennaEpiLogMatcher',
	#instVars : [
		'moduleName'
	],
	#category : 'ViennaTalk-Browser-Core-EpiLog',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'EpiLog'
}

{ #category : 'accessing' }
ViennaEpiLogModuleMatcher >> moduleName [

	^ moduleName ifNil: [ '-' ]
]

{ #category : 'accessing' }
ViennaEpiLogModuleMatcher >> moduleName: aString [

	moduleName := aString
]

{ #category : 'accessing' }
ViennaEpiLogModuleMatcher >> name [

	^ self moduleName
]

{ #category : 'accessing' }
ViennaEpiLogModuleMatcher >> order [

	^ 10
]

{ #category : 'evaluation' }
ViennaEpiLogModuleMatcher >> value: aViennaEpiLog [

	^ aViennaEpiLog hasChangeAtModule: self moduleName
]
