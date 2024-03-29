Class {
	#name : #ViennaVDMSourcePresenter,
	#superclass : #SpCodePresenter,
	#instVars : [
		'animation',
		'module'
	],
	#category : #'ViennaTalk-Browser-Core-Spec2'
}

{ #category : #commands }
ViennaVDMSourcePresenter class >> buildCommandsGroupWith: presenter forRoot: aCmCommandsGroup [

	| group |
	group := (CmCommandGroup named: 'Selection action commands')
		         asSpecGroup.
	group
		description: 'Actions on code selection.';
		beDisplayedAsGroup.

	{
		ViennaEvaluateItCommand.
		ViennaTypeItCommand.
		ViennaExecuteItCommand } do: [ :cmdClass |
		group register: (cmdClass forSpecContext: presenter) ].
	aCmCommandsGroup register: group.
	^ group
]

{ #category : #accessing }
ViennaVDMSourcePresenter >> animation [

	^ animation
]

{ #category : #accessing }
ViennaVDMSourcePresenter >> animation: aBlock [

	animation := aBlock
]

{ #category : #evaluating }
ViennaVDMSourcePresenter >> doEvaluateIt [

	| result |
	result := self
		          evaluateExpression: self selectedTextOrLine
		          ifError: [ :msg |
			          self
				          insertPopoverAfterCurrentSelection:
				          (self newLabel label: msg)
				          style: 'error'.
			          ^ nil ].
	self
		insertPopoverAfterCurrentSelection: (self newLabel label: result)
		style: 'print'
]

{ #category : #evaluating }
ViennaVDMSourcePresenter >> doExecuteIt [

	| result |
	result := self
		          evaluateStatement: self selectedTextOrLine
		          ifError: [ :msg |
			          self
				          insertPopoverAfterCurrentSelection:
				          (self newLabel label: msg)
				          style: 'error'.
			          ^ nil ]
]

{ #category : #evaluating }
ViennaVDMSourcePresenter >> doTypeIt [

	| result |
	result := self selectedText isViennaTracingString
		          ifTrue: [
			          (self selectedText
				           nodeContaining: self selectionInterval
				           ifAbsent: [ nil ]) ifNotNil: [ :node |
				          [ node maximalType printString ]
					          on: ViennaTypeError
					          do: [ :ex |
						          self
							          insertPopoverAfterCurrentSelection:
							          (self newLabel label: ex messageText)
							          style: 'error'.
						          ^ self ] ] ]
		          ifFalse: [
			          self
				          typecheckExpression: self selectedTextOrLine
				          ifError: [ :msg |
					          self
						          insertPopoverAfterCurrentSelection:
						          (self newLabel label: msg)
						          style: 'error'.
					          ^ self ] ].
	self
		insertPopoverAfterCurrentSelection: (self newLabel label: result)
		style: 'print'
]

{ #category : #evaluating }
ViennaVDMSourcePresenter >> evaluateExpression: aString ifError: errorBlock [

	| node |
	node := ViennaVDMParser new expression parse: aString.
	node isPetit2Failure ifTrue: [ ^ errorBlock cull: node printString ].
	node parent: module value.
	[ node typecheck ]
		on: ViennaTypeError
		do: [ :ex | ^ errorBlock cull: ex messageText ].
	^ (animation value ifNil: [ ViennaAnimation default ])
		  plainExecute: node
		  in: (node module ifNotNil: #identifier)
		  ifError: errorBlock
]

{ #category : #evaluating }
ViennaVDMSourcePresenter >> evaluateStatement: aString ifError: errorBlock [

	| node |
	node := ViennaVDMParser new statement parse: aString.
	node isPetit2Failure ifTrue: [ ^ errorBlock cull: node printString ].
	node parent: module value.
	[ node typecheck ]
		on: ViennaTypeError
		do: [ :ex | ^ errorBlock cull: ex messageText ].
	^ (animation value ifNil: [ ViennaTranspiledAnimation new ])
		  plainExecute: node
		  in: node module identifier
		  ifError: errorBlock
]

{ #category : #initialization }
ViennaVDMSourcePresenter >> initialize [

	super initialize.
	self
		withoutSyntaxHighlight;
		withoutSmartCharacters
]

{ #category : #accessing }
ViennaVDMSourcePresenter >> module [

	^ module
]

{ #category : #accessing }
ViennaVDMSourcePresenter >> module: aBlock [

	module := aBlock
]

{ #category : #evaluating }
ViennaVDMSourcePresenter >> typecheckExpression: aString ifError: errorBlock [

	| node |
	node := ViennaVDMParser new expression parse: aString.
	node isPetit2Failure ifTrue: [ ^ errorBlock cull: node printString ].
	node parent: module value.
	^ [ node typecheck printString ]
		  on: ViennaTypeError
		  do: [ :ex | errorBlock cull: ex messageText ]
]
