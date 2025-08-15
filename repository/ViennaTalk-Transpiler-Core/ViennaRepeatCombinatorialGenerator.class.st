Class {
	#name : 'ViennaRepeatCombinatorialGenerator',
	#superclass : 'ViennaCombinatorialGenerator',
	#instVars : [
		'range',
		'index',
		'subgenerator',
		'subgenerators'
	],
	#category : 'ViennaTalk-Transpiler-Core-CombinatorialTesting',
	#package : 'ViennaTalk-Transpiler-Core',
	#tag : 'CombinatorialTesting'
}

{ #category : 'instance creation' }
ViennaRepeatCombinatorialGenerator class >> range: aCollectionOfInteger with: aViennaCombinatorialGenerator [

	^ self new
		  range: aCollectionOfInteger;
		  subgenerator: aViennaCombinatorialGenerator;
		  yourself
]

{ #category : 'initialization' }
ViennaRepeatCombinatorialGenerator >> initialize [

	super initialize.
	range := 1 to: 1.
	index := 1.
	subgenerators := nil
]

{ #category : 'copying' }
ViennaRepeatCombinatorialGenerator >> postCopy [

	super postCopy.
	subgenerator := subgenerator ifNotNil: #copy.
	subgenerators := subgenerators ifNotNil: [
		                 subgenerators collect: #copy ]
]

{ #category : 'accessing' }
ViennaRepeatCombinatorialGenerator >> range [

	^ range
]

{ #category : 'accessing' }
ViennaRepeatCombinatorialGenerator >> range: aCollectionOfInteger [

	range := aCollectionOfInteger.
	self reset
]

{ #category : 'operations' }
ViennaRepeatCombinatorialGenerator >> reset [
	"reset the enumeration of the trace paths"

	index := 1.
	subgenerators := nil.
	(range notNil and: [ subgenerator notNil ]) ifTrue: [
		self stepSubgenerators ]
]

{ #category : 'operations' }
ViennaRepeatCombinatorialGenerator >> step: aDictionary [
	"step to the next trace path, and answers whether the trace path is available or not"

	subgenerators ifNil: [ ^ false ].
	subgenerators do: [ :generator |
		(generator step: aDictionary) ifTrue: [ ^ true ].
		generator reset ].
	^ self stepSubgenerators
]

{ #category : 'operations' }
ViennaRepeatCombinatorialGenerator >> stepSubgenerators [

	range size < index ifTrue: [
		subgenerators := nil.
		^ false ].
	subgenerators := Array streamContents: [ :stream |
		                 (range at: index) timesRepeat: [
			                 stream nextPut: (subgenerator copy
					                  reset;
					                  yourself) ] ].
	index := index + 1.
	^ true
]

{ #category : 'accessing' }
ViennaRepeatCombinatorialGenerator >> subgenerator [

	^ subgenerator
]

{ #category : 'accessing' }
ViennaRepeatCombinatorialGenerator >> subgenerator: anObject [

	subgenerator := anObject.
	self reset
]

{ #category : 'operations' }
ViennaRepeatCombinatorialGenerator >> value: aDictionary [
	"execute the current trace path, or nil if all the combination has been exhausted"

	subgenerators ifNil: [ ^ nil ].
	subgenerators do: [ :generator | generator value: aDictionary ]
]
