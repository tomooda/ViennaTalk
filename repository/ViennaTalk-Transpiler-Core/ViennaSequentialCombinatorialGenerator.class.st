Class {
	#name : 'ViennaSequentialCombinatorialGenerator',
	#superclass : 'ViennaCombinatorialGenerator',
	#instVars : [
		'subgenerators',
		'isDone'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
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

{ #category : 'accessing' }
ViennaSequentialCombinatorialGenerator >> peek [

	| values |
	isDone ifTrue: [ ^ nil ].
	values := subgenerators collect: #peek.
	^ [ :env | values do: [ :valuable | valuable value: env ] ]
]

{ #category : 'accessing' }
ViennaSequentialCombinatorialGenerator >> reset [

	subgenerators do: #reset.
	isDone := false
]

{ #category : 'accessing' }
ViennaSequentialCombinatorialGenerator >> step [
	"step to the next trace path"

	isDone ifTrue: [ ^ self ].
	subgenerators do: [ :generator |
		generator step.
		generator peek ifNotNil: [ ^ self ].
		generator reset ].
	isDone := true
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
