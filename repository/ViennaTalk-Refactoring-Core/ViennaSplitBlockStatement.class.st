Class {
	#name : #ViennaSplitBlockStatement,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'blockNode',
		'newHeadStatementIndex'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaSplitBlockStatement >> blockNode [
	^ blockNode ifNil: [ blockNode := self findBlockNode ]
]

{ #category : #accessing }
ViennaSplitBlockStatement >> blockNode: aViennaNode [
	blockNode := aViennaNode
]

{ #category : #operations }
ViennaSplitBlockStatement >> check [
	self blockNode ifNil: [ ^ false ].
	self newHeadStatementIndex ifNil: [ ^ false ].
	self blockNode
		do: [ :dclStatement | 
			dclStatement label = 'DclStatement'
				ifTrue: [ dclStatement
						do: [ :assignmentDefinition | 
							assignmentDefinition label = 'AssignmentDefinition'
								ifTrue: [ | varName |
									varName := assignmentDefinition first.
									(((self newHeadStatementIndex to: self blockNode size)
										anySatisfy:
											[ :index | self hasFreeOccurrencesOf: varName in: (self blockNode at: index) ])
										and: [ assignmentDefinition third notNil
												or: [ (1 to: self newHeadStatementIndex - 1)
														anySatisfy:
															[ :index | self hasFreeOccurrencesOf: varName in: (self blockNode at: index) ] ] ])
										ifTrue: [ ^ false ] ] ] ] ].
	^ true
]

{ #category : #operations }
ViennaSplitBlockStatement >> execute [
	| dummy newBlockStatement |
	dummy := self
		replaceNode: self blockNode
		with: (ViennaNode label: 'DUMMY').
	newBlockStatement := ViennaNode
		label: 'BlockStatement'
		withAll:
			(Array
				streamContents: [ :statementStream | 
					(Array
						streamContents: [ :assignmentStream | 
							self blockNode
								do: [ :dclStatement | 
									dclStatement label = 'DclStatement'
										ifTrue: [ dclStatement
												do: [ :assignmentDefinition | 
													assignmentDefinition label = 'AssignmentDefinition'
														ifTrue: [ | varName |
															varName := assignmentDefinition first.
															((self newHeadStatementIndex to: self blockNode size)
																anySatisfy:
																	[ :index | self hasFreeOccurrencesOf: varName in: (self blockNode at: index) ])
																ifTrue: [ assignmentStream nextPut: assignmentDefinition ] ] ] ] ] ])
						ifNotEmpty: [ :assignments | 
							statementStream
								nextPut: (ViennaNode label: 'DclStatement' withAll: assignments) ].
					self newHeadStatementIndex to: self blockNode size do: [ :index | statementStream nextPut: (self blockNode at: index) ] ]).
	self blockNode removeAfterIndex: self newHeadStatementIndex.
	^ self
		replaceNode: dummy
		with:
			(ViennaNode
				label: 'BlockStatement'
				with: self blockNode
				with: newBlockStatement)
]

{ #category : #accessing }
ViennaSplitBlockStatement >> findBlockNode [
	ast ifNil: [ ^ nil ].
	^ ast parentLabelled: 'BlockStatement' ifAbsent: [ nil ]
]

{ #category : #accessing }
ViennaSplitBlockStatement >> findNewHeadStatementIndex [
	1 to: (self blockNode ifNil: [ ^ nil ]) size do: [ :index | 
		(ast includesParent: (self blockNode at: index))
			ifTrue: [ ^ index ] ].
	^ nil
]

{ #category : #accessing }
ViennaSplitBlockStatement >> name [
	^ 'Split block before '
		,
			(self
				shortDescription: (self blockNode at: self newHeadStatementIndex) source)
				asText allBold
]

{ #category : #accessing }
ViennaSplitBlockStatement >> newHeadStatementIndex [
	^ newHeadStatementIndex
		ifNil: [ newHeadStatementIndex := self findNewHeadStatementIndex ]
]

{ #category : #accessing }
ViennaSplitBlockStatement >> newHeadStatementIndex: anInteger [
	newHeadStatementIndex := anInteger
]

{ #category : #accessing }
ViennaSplitBlockStatement >> sortingOrder [
	^ 6.3
]
