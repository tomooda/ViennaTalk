Class {
	#name : #ViennaInlineBlockStatement,
	#superclass : #ViennaInline,
	#instVars : [
		'blockNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaInlineBlockStatement >> blockNode [
	^ blockNode ifNil: [ blockNode := self findBlockNode ]
]

{ #category : #accessing }
ViennaInlineBlockStatement >> blockNode: aViennaNode [
	blockNode := aViennaNode
]

{ #category : #accessing }
ViennaInlineBlockStatement >> blockVariables: aViennaNode [

	aViennaNode isViennaBlockStatementNode ifFalse: [ ^ Array new ].
	^ Array streamContents: [ :stream |
		  aViennaNode do: [ :statement |
			  statement isViennaDclStatementNode ifTrue: [
				  statement do: [ :assignment |
					  assignment label = 'AssignmentDefinition' ifTrue: [
						  stream nextPut: assignment first ] ] ] ] ]
]

{ #category : #operations }
ViennaInlineBlockStatement >> check [

	self blockNode ifNil: [ ^ false ].
	self blockNode parent isViennaBlockStatementNode ifFalse: [ ^ false ].
	(self blockVariables: self blockNode) ifNotEmpty: [ :innerVars |
		(self blockVariables: self blockNode parent) ifNotEmpty: [
			:outerVars |
			(innerVars intersect: outerVars) ifNotEmpty: [ ^ false ] ] ].
	^ true
]

{ #category : #operations }
ViennaInlineBlockStatement >> execute [

	^ self
		  replaceNode: self blockNode parent
		  with:
			  (ViennaBlockStatementNode withAll:
				   (Array streamContents: [ :stream |
					    self blockNode parent do: [ :statement |
						    statement isViennaDclStatementNode ifTrue: [
							    stream nextPut: statement ] ].
					    self blockNode do: [ :statement |
						    statement isViennaDclStatementNode ifTrue: [
							    stream nextPut: statement ] ].
					    self blockNode parent do: [ :outerStatement |
						    outerStatement isViennaDclStatementNode ifFalse: [
							    self blockNode == outerStatement
								    ifTrue: [
									    self blockNode do: [ :innerStatement |
										    innerStatement isViennaDclStatementNode ifFalse: [
											    stream nextPut: innerStatement ] ] ]
								    ifFalse: [ stream nextPut: outerStatement ] ] ] ]))
]

{ #category : #accessing }
ViennaInlineBlockStatement >> findBlockNode [

	ast ifNil: [ ^ nil ].
	^ ast detectParent: #isViennaBlockStatementNode ifNone: [ nil ]
]

{ #category : #accessing }
ViennaInlineBlockStatement >> name [
	^ 'Inline '
		, (self shortDescription: self blockNode source) asText allBold
]

{ #category : #accessing }
ViennaInlineBlockStatement >> sortingOrder [
	^ 6.5
]
