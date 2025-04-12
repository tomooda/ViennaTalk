Class {
	#name : 'ViennaMutation',
	#superclass : 'Object',
	#category : 'ViennaTalk-Mutation-Core',
	#package : 'ViennaTalk-Mutation-Core'
}

{ #category : 'testing' }
ViennaMutation class >> isAbstract [

	^ self = ViennaMutation
]

{ #category : 'mutating' }
ViennaMutation >> allMutationsTo: aViennaNode [

	^ Array streamContents: [ :stream |
		  self
			  allMutationsTo: aViennaNode
			  do: [ :node | stream nextPut: node ] ]
]

{ #category : 'mutating' }
ViennaMutation >> allMutationsTo: aViennaNode do: aBlock [

	(Array streamContents: [ :stream |
		 aViennaNode
			 allDescendantsSuchThat: [ :node | self canMutate: node ]
			 do: [ :node | stream nextPut: node ] ]) do: [ :n |
		| node document |
		node := n copyWhole.
		document := node document.
		node parent replace: node with: (self mutate: node).
		aBlock value: (document
				 forgetTypecheck;
				 yourself) ]
]

{ #category : 'testing' }
ViennaMutation >> canMutate: aViennaNode [

	^ self subclassResponsibility
]

{ #category : 'mutating' }
ViennaMutation >> mutate: aViennaNode [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaMutation >> name [

	^ self subclassResponsibility
]

{ #category : 'mutating' }
ViennaMutation >> randomMutationFrom: aViennaNode [

	(Array streamContents: [ :stream |
		 aViennaNode document copyFragment
			 allDescendantsSuchThat: [ :node | self canMutate: node ]
			 do: [ :node | stream nextPut: node ] ]) ifNotEmpty: [ :nodes |
		| node document |
		node := nodes atRandom.
		document := node document.
		node parent replace: node with: (self mutate: node).
		^ document
			  forgetTypecheck;
			  yourself ]
]
