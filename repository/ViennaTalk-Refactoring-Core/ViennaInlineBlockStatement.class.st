Class {
	#name : 'ViennaInlineBlockStatement',
	#superclass : 'ViennaInline',
	#instVars : [
		'blockNode'
	],
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaInlineBlockStatement >> blockNode [
	^ blockNode ifNil: [ blockNode := self findBlockNode ]
]

{ #category : 'accessing' }
ViennaInlineBlockStatement >> blockNode: aViennaNode [
	blockNode := aViennaNode
]

{ #category : 'accessing' }
ViennaInlineBlockStatement >> blockVariables: aViennaNode [

	aViennaNode isViennaBlockStatementNode ifFalse: [ ^ Array new ].
	^ Array streamContents: [ :stream |
		  aViennaNode do: [ :statement |
			  statement isViennaDclStatementNode ifTrue: [
				  statement do: [ :assignment |
					  assignment isViennaAssignmentDefinitionNode ifTrue: [
						  stream nextPut: assignment identifier ] ] ] ] ]
]

{ #category : 'operations' }
ViennaInlineBlockStatement >> check [

	self blockNode ifNil: [ ^ false ].
	self blockNode parent isViennaBlockStatementNode ifFalse: [ ^ false ].
	self blockNode
		allDescendantsSuchThat: #isViennaReturnStatementNode
		do: [ :node | ^ false ].
	self blockNode dclStatement ifNotNil: [ :dcl1 |
		self blockNode parent dclStatement ifNotNil: [ :dcl2 |
			| identifiers1 |
			identifiers1 := dcl1 uniqueBoundIdentifiers asSet.
			(dcl2 uniqueBoundIdentifiers anySatisfy: [ :identifier2 |
				 identifiers1 includes: identifier2 ]) ifTrue: [ ^ false ] ] ].
	^ true
]

{ #category : 'operations' }
ViennaInlineBlockStatement >> execute [

	| assignmentDefinitions |
	assignmentDefinitions := Array streamContents: [ :stream |
		                         self blockNode parent dclStatement
			                         ifNotNil: [ :dclStatement |
				                         dclStatement do: [ :assignmentDefinition |
					                         stream nextPut: assignmentDefinition ] ].
		                         self blockNode dclStatement ifNotNil: [
			                         :dclStatement |
			                         dclStatement do: [ :assignmentDefinition |
				                         stream nextPut:
					                         assignmentDefinition
						                         withoutInitialization ] ] ].
	^ self
		  replaceNode: self blockNode parent
		  with:
			  (ViennaBlockStatementNode withAll:
				   (Array streamContents: [ :stream |
					    assignmentDefinitions ifNotEmpty: [
						    stream nextPut:
							    (ViennaDclStatementNode withAll: assignmentDefinitions) ].
					    self blockNode parent do: [ :outerStatement |
						    outerStatement isViennaDclStatementNode ifFalse: [
							    self blockNode == outerStatement
								    ifTrue: [
									    self blockNode do: [ :innerStatement |
										    innerStatement isViennaDclStatementNode
											    ifTrue: [
												    innerStatement do: [ :assignmentDefinition |
													    assignmentDefinition asViennaAssignStatementNode
														    ifNotNil: [ :assignStatement |
														    stream nextPut: assignStatement ] ] ]
											    ifFalse: [ stream nextPut: innerStatement ] ] ]
								    ifFalse: [ stream nextPut: outerStatement ] ] ] ]))
]

{ #category : 'accessing' }
ViennaInlineBlockStatement >> findBlockNode [

	ast ifNil: [ ^ nil ].
	ast isViennaBlockStatementNode ifTrue: [ ^ ast ].
	^ ast detectParent: #isViennaBlockStatementNode ifNone: [ nil ]
]

{ #category : 'accessing' }
ViennaInlineBlockStatement >> name [
	^ 'Inline '
		, (self shortDescription: self blockNode source) asText allBold
]

{ #category : 'accessing' }
ViennaInlineBlockStatement >> sortingOrder [
	^ 6.5
]
