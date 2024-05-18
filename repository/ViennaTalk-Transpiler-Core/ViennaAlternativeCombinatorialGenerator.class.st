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

{ #category : 'initialization' }
ViennaAlternativeCombinatorialGenerator >> peek [

	^ (subgenerators at: index ifAbsent: [ ^ nil ]) peek
]

{ #category : 'accessing' }
ViennaAlternativeCombinatorialGenerator >> reset [

	subgenerators do: #reset.
	index := 1
]

{ #category : 'accessing' }
ViennaAlternativeCombinatorialGenerator >> step [

	index <= subgenerators size ifTrue: [
		((subgenerators at: index)
			 step;
			 peek) ifNil: [ index := index + 1 ] ]
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
