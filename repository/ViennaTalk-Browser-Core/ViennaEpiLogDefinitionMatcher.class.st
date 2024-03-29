Class {
	#name : #ViennaEpiLogDefinitionMatcher,
	#superclass : #ViennaEpiLogMatcher,
	#instVars : [
		'moduleName',
		'identifier'
	],
	#category : #'ViennaTalk-Browser-Core-EpiLog'
}

{ #category : #accessing }
ViennaEpiLogDefinitionMatcher >> identifier [

	^ identifier ifNil: [ '-' ]
]

{ #category : #accessing }
ViennaEpiLogDefinitionMatcher >> identifier: anObject [

	identifier := anObject
]

{ #category : #accessing }
ViennaEpiLogDefinitionMatcher >> moduleName [

	^ moduleName ifNil: [ '-' ]
]

{ #category : #accessing }
ViennaEpiLogDefinitionMatcher >> moduleName: anObject [

	moduleName := anObject
]

{ #category : #accessing }
ViennaEpiLogDefinitionMatcher >> name [

	^ self moduleName , '`' , self identifier
]

{ #category : #accessing }
ViennaEpiLogDefinitionMatcher >> order [

	^ 20
]

{ #category : #evaluation }
ViennaEpiLogDefinitionMatcher >> value: aViennaEpiLog [

	^ aViennaEpiLog hasChangeAt: self identifier module: self moduleName
]
