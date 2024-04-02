Class {
	#name : #ViennaModuleNodeChange,
	#superclass : #ViennaAbstractNodeChange,
	#category : #'ViennaTalk-Browser-Core-Diff'
}

{ #category : #printing }
ViennaModuleNodeChange >> printNamesOn: aStream [

	aStream
		nextPutAll: 'module ';
		nextPutAll: (from ifNil: [ to ]) identifier
]
