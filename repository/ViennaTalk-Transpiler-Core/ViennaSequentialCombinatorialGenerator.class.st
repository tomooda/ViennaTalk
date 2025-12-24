Class {
	#name : 'ViennaSequentialCombinatorialGenerator',
	#superclass : 'ViennaCombinatorialGenerator',
	#instVars : [
		'subgenerators',
		'isDone'
	],
	#category : 'ViennaTalk-Transpiler-Core-CombinatorialTesting',
	#package : 'ViennaTalk-Transpiler-Core',
	#tag : 'CombinatorialTesting'
}

{ #category : 'instance creation' }
ViennaSequentialCombinatorialGenerator class >> withAll: aCollectionOfViennaCombinatorialGenerator [

	^ self new
		  subgenerators: aCollectionOfViennaCombinatorialGenerator asArray;
		  yourself
]

{ #category : 'initialization' }
ViennaSequentialCombinatorialGenerator >> initialize [

	super initialize.
	subgenerators := Array new.
	isDone := true
]

{ #category : 'copying' }
ViennaSequentialCombinatorialGenerator >> postCopy [

	super postCopy.
	subgenerators := subgenerators collect: #copy
]

{ #category : 'operations' }
ViennaSequentialCombinatorialGenerator >> reset [

	subgenerators do: #reset.
	isDone := false
]

{ #category : 'operations' }
ViennaSequentialCombinatorialGenerator >> step: aDictionary [
	"step to the next trace path"

	isDone ifTrue: [ ^ false ].
	subgenerators do: [ :generator |
		(generator step: aDictionary) ifTrue: [ ^ true ].
		generator reset ].
	isDone := true.
	^ false
]

{ #category : 'accessing' }
ViennaSequentialCombinatorialGenerator >> subgenerators [

	^ subgenerators
]

{ #category : 'accessing' }
ViennaSequentialCombinatorialGenerator >> subgenerators: anArrayOfViennaCombinatorialGenerator [

	subgenerators := anArrayOfViennaCombinatorialGenerator.
	isDone := false
]

{ #category : 'operations' }
ViennaSequentialCombinatorialGenerator >> value: aDictionary [

	isDone ifTrue: [ ^ nil ].
	subgenerators do: [ :generator | generator value: aDictionary ]
]
