Class {
	#name : 'ViennaASTTextAttribute',
	#superclass : 'ViennaTextAttribute',
	#instVars : [
		'node',
		'isDominant'
	],
	#category : 'ViennaTalk-Parser-Highlighters',
	#package : 'ViennaTalk-Parser-Highlighters'
}

{ #category : 'instance creation' }
ViennaASTTextAttribute class >> node: aViennaNode [

	^ self new
		  node: aViennaNode;
		  yourself
]

{ #category : 'accessing' }
ViennaASTTextAttribute >> basicDominates: another [

	^ node notNil and: [
			  | anotherNode |
			  anotherNode := another node.
			  anotherNode isNil or: [ node hasParentSuchThat: [ :p | anotherNode == p ] ] ]
]

{ #category : 'accessing' }
ViennaASTTextAttribute >> dominates: another [

	^ self class == another class and: [
			  (another basicDominates: self) ifTrue: [ isDominant := false ].
			  self basicDominates: another ]
]

{ #category : 'accessing' }
ViennaASTTextAttribute >> node [

	^ node
]

{ #category : 'accessing' }
ViennaASTTextAttribute >> node: aViennaNode [

	node := aViennaNode
]

{ #category : 'initialization' }
ViennaASTTextAttribute >> reset [

	isDominant := true
]
