Class {
	#name : #ViennaASTBrowser,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'moduleList',
		'categoryList',
		'definitionList',
		'sourceText',
		'playground'
	],
	#classVars : [
		'SectionNames'
	],
	#category : #'ViennaTalk-Browser-Core'
}

{ #category : #specs }
ViennaASTBrowser class >> defaultSpec [
	^ SpPanedLayout newVertical
		position: 0.5;
		add:
			(SpBoxLayout newHorizontal
				add: #moduleList;
				add: #categoryList;
				add: #definitionList);
		add: #sourceText
]

{ #category : #accessing }
ViennaASTBrowser class >> sectionNames [
	^ SectionNames
		ifNil: [ SectionNames := Dictionary new
				at: 'Module' put: '- all -';
				at: 'TypeDefinitions' put: 'types';
				at: 'ValueDefinitions' put: 'values';
				at: 'StateDefinition' put: 'state';
				at: 'FunctionDefinitions' put: 'functions';
				at: 'OperationDefinitions' put: 'operations';
				yourself ]
]

{ #category : #accessing }
ViennaASTBrowser >> category [
	^ categoryList selection selectedItem
]

{ #category : #accessing }
ViennaASTBrowser >> definition [
	^ definitionList selection selectedItem
]

{ #category : #accessing }
ViennaASTBrowser >> definitionBase [
	| node |
	node := self definition.
	node ifNil: [ ^ nil ].
	(#('AccessTypeDefinition' 'AccessValueDefinition')
		includes: node label)
		ifTrue: [ ^ node second ].
	(#('AccessFunctionDefinition' 'AccessOperationDefinition')
		includes: node label)
		ifTrue: [ ^ node second first ].
	^ node
]

{ #category : #menus }
ViennaASTBrowser >> definitionListContextMenu [
	| menu |
	menu := self newMenu.
	self definitionBase
		ifNotNil: [ :definition | 
			| node |
			node := definition.
			[ node notNil ]
				whileTrue: [ menu
						addGroup: [ :group | 
							ViennaRefactoring
								on: node
								do: [ :refactoring | 
									group
										addItem: [ :item | 
											item
												name: refactoring name;
												action: [ refactoring execute.
													self
														updateModuleList;
														updateCategoryList;
														updateDefinitionList;
														updateSource ] ] ] ].
					node := node parent ] ].
	^ menu
]

{ #category : #private }
ViennaASTBrowser >> definitionsFromCategory: aViennaNode [
	aViennaNode isViennaNode
		ifTrue: [ aViennaNode label = 'Module'
				ifTrue: [ ^ ((self module
						ifNotNil: [ :ast | 
							(ast
								detect: [ :node | node isViennaNode and: [ node label = 'ModuleBody' ] ]
								ifNone: [  ])
								ifNotNil: [ :body | body collect: [ :node | node first ] ]
								ifNil: [ Array new ] ]
						ifNil: [ Array new ])
						collect: [ :def | self definitionsFromCategory: def ])
						inject: #()
						into: [ :array :each | array , each ] ].
			aViennaNode label = 'StateDefinition'
				ifTrue: [ ^ aViennaNode second asArray  ].
			^ aViennaNode asArray ].
	^ Array new
]

{ #category : #private }
ViennaASTBrowser >> displayDefinition: aViennaNode [
	aViennaNode
		allDescendantsDo: [ :node | 
			(#('Module' 'TypeDefinitions' 'ValueDefinitions' 'FunctionDefinitions' 'OperationDefinitions')
				includes: node label)
				ifTrue: [ ^ ' - all - ' ].
			node label = 'FunctionsDefinition'
				ifTrue: [ ^ ' - all - ' ].
			node label = 'TypeDefinition'
				ifTrue: [ ^ node first ].
			node label = 'RecordTypeDefinition'
				ifTrue: [ ^ node first ].
			node label = 'Field'
				ifTrue: [ ^ aViennaNode first ].
			node label = 'ValueDefinition'
				ifTrue: [ ^ node first source ].
			node label = 'StateDefinition'
				ifTrue: [ ^ node first ].
			node label = 'ExplicitFunctionDefinition'
				ifTrue: [ ^ node first ].
			node label = 'ImplicitFunctionDefinition'
				ifTrue: [ ^ node first ].
			node label = 'ExplicitOperationDefinition'
				ifTrue: [ ^ node first ].
			node label = 'ImplicitOperationDefinition'
				ifTrue: [ ^ node first ] ].
	^ '-'
]

{ #category : #initialization }
ViennaASTBrowser >> initializePresenters [
	super initializePresenter.
	moduleList := self newList
		beSingleSelection;
		display: [ :ast | ast first ];
		whenSelectionChangedDo: [ self updateCategoryList ];
		yourself.
	categoryList := self newList
		beSingleSelection;
		display: [ :ast | 
			ast
				ifNotNil: [ self class sectionNames at: ast label ifAbsent: [ ast label ] ]
				ifNil: [ '-' ] ];
		whenSelectionChangedDo: [ self updateDefinitionList ];
		yourself.
	definitionList := self newList
		beSingleSelection;
		contextMenu: [ self definitionListContextMenu ];
		display:
				[ :ast | ast ifNotNil: [ self displayDefinition: ast ] ifNil: [ '-' ] ];
		whenSelectionChangedDo: [ :selection | 
			(selection notNil and: [ ActiveHand shiftPressed ])
				ifTrue: [ self updateAppendSource ]
				ifFalse: [ self updateSource ] ].
	sourceText := self newText
		contextMenu: [ self sourceTextContextMenu ];
		yourself.
	self
		whenBuiltDo: [ :w | 
			| f |
			f := TextStyle defaultFont.
			w widget
				allMorphsDo: [ :m | 
					(m respondsTo: #font:)
						ifTrue: [ m font: f ] ] ]
]

{ #category : #initialization }
ViennaASTBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Browser'
]

{ #category : #accessing }
ViennaASTBrowser >> modelChanged [
	self updateModuleList
]

{ #category : #accessing }
ViennaASTBrowser >> module [
	^ moduleList selection selectedItem
]

{ #category : #menus }
ViennaASTBrowser >> sourceTextContextMenu [
	| menu |
	menu := self newMenu.
	(sourceText text string asViennaTracingString
		nodeContaining: sourceText selectionInterval
		ifAbsent: [ nil ])
		ifNotNil: [ :node | 
			menu
				addGroup: [ :group | 
					ViennaRefactoring
						on: node
						do: [ :refactoring | 
							group
								addItem: [ :item | 
									item
										name: refactoring name;
										action: [ refactoring execute.
											self
												updateModuleList;
												updateCategoryList;
												updateDefinitionList;
												updateSource ] ] ] ] ].
	^ menu
]

{ #category : #updating }
ViennaASTBrowser >> updateAppendSource [
	self definition
		ifNotNil: [ :node | 
			sourceText
				text: sourceText text , String cr asText , node tracingHighlightedSource ]
]

{ #category : #updating }
ViennaASTBrowser >> updateCategoryList [
	| newItems oldSelection |
	newItems := (Array with: self module)
		,
			(self module
				ifNotNil: [ :ast | 
					(ast
						detect: [ :node | node isViennaNode and: [ node label = 'ModuleBody' ] ]
						ifNone: [  ])
						ifNotNil: [ :body | body collect: [ :node | node first ] ]
						ifNil: [ Array new ] ]
				ifNil: [ Array new ]).
	oldSelection := categoryList selection selectedItem.
	categoryList items: newItems.
	(newItems includes: oldSelection)
		ifTrue: [ categoryList selectItem: oldSelection ]
		ifFalse: [ categoryList unselectAll ]
]

{ #category : #updating }
ViennaASTBrowser >> updateDefinitionList [
	| newItems oldSelection |
	newItems := (Array with: self category)
		,
			(self category
				ifNotNil: [ :ast | self definitionsFromCategory: ast ]
				ifNil: [ Array new ]).
	oldSelection := definitionList selection selectedItem.
	definitionList items: newItems.
	(newItems includes: oldSelection)
		ifTrue: [ definitionList selectItem: oldSelection ]
		ifFalse: [ definitionList unselectAll ]
]

{ #category : #updating }
ViennaASTBrowser >> updateModuleList [
	| newItems oldSelection |
	newItems := self model
		ifNotNil: [ :ast | ast asArray ]
		ifNil: [ Array new ].
	oldSelection := moduleList selection selectedItem.
	moduleList items: newItems.
	(newItems includes: oldSelection)
		ifTrue: [ moduleList selectItem: oldSelection ]
		ifFalse: [ moduleList unselectAll ]
]

{ #category : #updating }
ViennaASTBrowser >> updateSource [
	self definition
		ifNotNil: [ :node | sourceText text: node tracingHighlightedSource ]
]
