Class {
	#name : #ViennaFlattenBlockStatement,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'blockNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaFlattenBlockStatement >> blockNode [
	^ blockNode ifNil: [ blockNode := self findBlockNode ]
]

{ #category : #accessing }
ViennaFlattenBlockStatement >> blockNode: aViennaNode [
	blockNode := aViennaNode
]

{ #category : #accessing }
ViennaFlattenBlockStatement >> blockVariables: aViennaNode [
	aViennaNode label = 'BlockStatement'
		ifFalse: [ ^ #() ].
	^ Array
		streamContents: [ :stream | 
			aViennaNode
				do: [ :statement | 
					statement label = 'DclStatement'
						ifTrue: [ statement
								do: [ :assignment | 
									assignment label = 'AssignmentDefinition'
										ifTrue: [ stream nextPut: assignment first ] ] ] ] ]
]

{ #category : #operations }
ViennaFlattenBlockStatement >> check [
	self blockNode ifNil: [ ^ false ].
	self blockNode parent label = 'BlockStatement'
		ifFalse: [ ^ false ].
	(self blockVariables: self blockNode)
		ifNotEmpty: [ :innerVars | 
			(self blockVariables: self blockNode parent)
				ifNotEmpty:
					[ :outerVars | (innerVars intersect: outerVars) ifNotEmpty: [ ^ false ] ] ].
	^ true
]

{ #category : #operations }
ViennaFlattenBlockStatement >> execute [
	^ self
		replaceNode: self blockNode parent
		with:
			(ViennaNode
				label: 'BlockStatement'
				withAll:
					(Array
						streamContents: [ :stream | 
							self blockNode parent
								do: [ :statement | 
									statement label = 'DclStatement'
										ifTrue: [ stream nextPut: statement ] ].
							self blockNode
								do: [ :statement | 
									statement label = 'DclStatement'
										ifTrue: [ stream nextPut: statement ] ].
							self blockNode parent
								do: [ :outerStatement | 
									outerStatement label = 'DclStatement'
										ifFalse: [ self blockNode == outerStatement
												ifTrue: [ self blockNode
														do: [ :innerStatement | 
															innerStatement label = 'DclStatement'
																ifFalse: [ stream nextPut: innerStatement ] ] ]
												ifFalse: [ stream nextPut: outerStatement ] ] ] ]))
]

{ #category : #accessing }
ViennaFlattenBlockStatement >> findBlockNode [
	ast ifNil: [ ^ nil ].
	^ ast parentLabelled: 'BlockStatement' ifAbsent: [ nil ]
]

{ #category : #accessing }
ViennaFlattenBlockStatement >> name [
	^ 'flatten block ', ast source asText allBold
]

{ #category : #accessing }
ViennaFlattenBlockStatement >> sortingOrder [
	^ 6.5
]
