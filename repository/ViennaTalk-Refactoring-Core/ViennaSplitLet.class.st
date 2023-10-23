Class {
	#name : #ViennaSplitLet,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'definitionNode',
		'newHeadLocalDefinitionIndex'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaSplitLet >> check [

	self definitionNode ifNil: [ ^ false ].
	^ self newHeadLocalDefinitionIndex >= 2
]

{ #category : #accessing }
ViennaSplitLet >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #operations }
ViennaSplitLet >> execute [

	| innerLet localDefinitions |
	innerLet := self definitionNode copyFragment.
	localDefinitions := self definitionNode localDefinitionList collect:
		                    #copyFragment.
	self definitionNode localDefinitionList:
		(ViennaLocalDefinitionListNode withAll:
			 (localDefinitions
				  copyFrom: 1
				  to: self newHeadLocalDefinitionIndex - 1)).
	innerLet localDefinitionList:
		(ViennaLocalDefinitionListNode withAll: (localDefinitions
				  copyFrom: self newHeadLocalDefinitionIndex
				  to: localDefinitions size)).
	innerLet body: self definitionNode body.
	self definitionNode body: innerLet
]

{ #category : #accessing }
ViennaSplitLet >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	^ ast detectParent: #isViennaLetNode ifNone: [ nil ]
]

{ #category : #accessing }
ViennaSplitLet >> findNewHeadLocalDefinitionIndex [

	1 to: (self definitionNode ifNil: [ ^ 0 ]) localDefinitionList size
		do: [ :index |
			(ast includesParent:
				 (self definitionNode localDefinitionList at: index)) ifTrue: [
				^ index ] ].
	^ 0
]

{ #category : #accessing }
ViennaSplitLet >> name [
	^ 'Split let'
]

{ #category : #accessing }
ViennaSplitLet >> newHeadLocalDefinitionIndex [

	^ newHeadLocalDefinitionIndex ifNil: [
		  newHeadLocalDefinitionIndex := self
			                                 findNewHeadLocalDefinitionIndex ]
]

{ #category : #accessing }
ViennaSplitLet >> sortingOrder [
	^ 3.63
]
