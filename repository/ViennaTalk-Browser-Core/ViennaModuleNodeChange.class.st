Class {
	#name : 'ViennaModuleNodeChange',
	#superclass : 'ViennaAbstractNodeChange',
	#category : 'ViennaTalk-Browser-Core-Diff',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Diff'
}

{ #category : 'enumerating' }
ViennaModuleNodeChange >> changedGlobalNamesDo: aBlock [

	from ifNil: [
		aBlock value: to identifier.
		^ self ].
	to ifNil: [
		aBlock value: from identifier.
		^ self ].
	from identifier ~= to identifier ifTrue: [
		aBlock value: from identifier.
		aBlock value: to identifier ]
]

{ #category : 'testing' }
ViennaModuleNodeChange >> isViennaModuleNodeChange [

	^ true
]

{ #category : 'printing' }
ViennaModuleNodeChange >> printNamesOn: aStream [

	aStream
		nextPutAll: 'module ';
		nextPutAll: (from ifNil: [ to ]) identifier
]
