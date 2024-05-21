Class {
	#name : 'ViennaConcurrentCombinatorialGenerator',
	#superclass : 'ViennaCombinatorialGenerator',
	#instVars : [
		'permutations',
		'index'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'instance creation' }
ViennaConcurrentCombinatorialGenerator class >> withAll: aCollectionOfViennaCombinatorialGenerator [

                ^ self new subgenerators:
                     aCollectionOfViennaCombinatorialGenerator
]

{ #category : 'operations' }
ViennaConcurrentCombinatorialGenerator >> reset [

	index := 1.
	permutations ifNotEmpty: [ permutations first do: #reset ]
]

{ #category : 'operations' }
ViennaConcurrentCombinatorialGenerator >> step: aDictionary [
	"step to the next trace path, and answers whether the trace path is available or not"

	| subgenerators |
	subgenerators := permutations at: index ifAbsent: [ ^ false ].
	subgenerators do: [ :generator |
		(generator step: aDictionary) ifTrue: [ ^ true ].
		generator reset ].
	index := index + 1.
	^ index <= permutations size
]

{ #category : 'accessing' }
ViennaConcurrentCombinatorialGenerator >> subgenerators: aCollectionOfViennaCombinatorialGenerator [

	permutations := Array streamContents: [ :stream |
		                aCollectionOfViennaCombinatorialGenerator asArray
			                permutationsDo: [ :perm |
			                stream nextPut: perm copy ] ].
	index := 1
]

{ #category : 'operations' }
ViennaConcurrentCombinatorialGenerator >> value: aDictionary [

	| subgenerators |
	subgenerators := permutations at: index ifAbsent: [ ^ nil ].
	subgenerators do: [ :generator | generator value: aDictionary ]
]
