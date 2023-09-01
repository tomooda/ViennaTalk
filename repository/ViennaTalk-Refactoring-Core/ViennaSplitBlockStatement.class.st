Class {
	#name : #ViennaSplitBlockStatement,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'definitionNode',
		'newHeadStatementIndex'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaSplitBlockStatement >> check [

	self definitionNode ifNil: [ ^ false ].
	self newHeadStatementIndex ifNil: [ ^ false ].
	self newHeadStatementIndex = 1 ifTrue: [ ^ false ].
	(self newHeadStatementIndex = 2 and: [
		 self definitionNode dclStatement notNil ]) ifTrue: [ ^ false ].
	^ true
]

{ #category : #accessing }
ViennaSplitBlockStatement >> definitionNode [

	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #operations }
ViennaSplitBlockStatement >> execute [

	| dclStatement newBlockStatement1 newBlockStatement2 |
	dclStatement := self definitionNode dclStatement.
	newBlockStatement1 := ViennaBlockStatementNode withAll:
		                      (((dclStatement ifNil: [ 1 ] ifNotNil: [ 2 ])
		                        to: self newHeadStatementIndex - 1)
			                       collect: [ :index |
			                       (self definitionNode at: index) copyFragment ]).
	newBlockStatement2 := ViennaBlockStatementNode withAll:
		                      ((self newHeadStatementIndex to:
		                        self definitionNode size) collect: [ :index |
			                       (self definitionNode at: index) copyFragment ]).
	^ self
		  replaceNode: self definitionNode
		  with: (ViennaBlockStatementNode withAll:
				   (dclStatement ifNil: [ {  } ] ifNotNil: [ { dclStatement } ])
				   , {
						   newBlockStatement1.
						   newBlockStatement2 })
]

{ #category : #accessing }
ViennaSplitBlockStatement >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	^ ast detectParent: #isViennaBlockStatementNode ifNone: [ nil ]
]

{ #category : #accessing }
ViennaSplitBlockStatement >> findNewHeadStatementIndex [

	1 to: (self definitionNode ifNil: [ ^ nil ]) size do: [ :index |
		(ast includesParent: (self definitionNode at: index)) ifTrue: [
			^ index ] ].
	^ nil
]

{ #category : #accessing }
ViennaSplitBlockStatement >> name [

	^ 'Split block'
]

{ #category : #accessing }
ViennaSplitBlockStatement >> newHeadStatementIndex [
	^ newHeadStatementIndex
		ifNil: [ newHeadStatementIndex := self findNewHeadStatementIndex ]
]

{ #category : #accessing }
ViennaSplitBlockStatement >> sortingOrder [
	^ 6.3
]
