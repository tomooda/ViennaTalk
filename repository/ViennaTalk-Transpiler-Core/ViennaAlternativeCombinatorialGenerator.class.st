Class {
	#name : 'ViennaAlternativeCombinatorialGenerator',
	#superclass : 'ViennaCombinatorialGenerator',
	#instVars : [
		'subgenerators',
		'index'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'instance creation' }
ViennaAlternativeCombinatorialGenerator class >> withAll: aCollectionOfViennaCombinatorialGenerator [

	^ self new
		  subgenerators: aCollectionOfViennaCombinatorialGenerator asArray;
		  yourself
]

{ #category : 'initialization' }
ViennaAlternativeCombinatorialGenerator >> initialize [

	super initialize.
	subgenerators := Array new.
	index := 1
]

{ #category : 'copying' }
ViennaAlternativeCombinatorialGenerator >> postCopy [

	super postCopy.
	subgenerators := subgenerators collect: #copy
]

{ #category : 'operations' }
ViennaAlternativeCombinatorialGenerator >> reset [

	subgenerators do: #reset.
	index := 1
]

{ #category : 'operations' }
ViennaAlternativeCombinatorialGenerator >> step: aDictionary [

	^ index <= subgenerators size and: [
		  ((subgenerators at: index) step: aDictionary copy) or: [
			  (index := index + 1) <= subgenerators size ] ]
]

{ #category : 'accessing' }
ViennaAlternativeCombinatorialGenerator >> subgenerators [

	^ subgenerators
]

{ #category : 'accessing' }
ViennaAlternativeCombinatorialGenerator >> subgenerators: anArrayOfViennaCombinatorialGenerator [

	subgenerators := anArrayOfViennaCombinatorialGenerator.
	index := 1
]

{ #category : 'operations' }
ViennaAlternativeCombinatorialGenerator >> value: aDictionary [

	^ (subgenerators at: index ifAbsent: [ ^ nil ]) value:
		  aDictionary copy
]
