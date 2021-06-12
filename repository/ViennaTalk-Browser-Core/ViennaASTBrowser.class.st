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

{ #category : #private }
ViennaASTBrowser >> definitionsFromCategory: aViennaNode [
	aViennaNode isViennaNode
		ifTrue: [ aViennaNode label = 'StateDefinition'
				ifTrue: [ ^ Array with: aViennaNode ].
			^ aViennaNode asArray ].
	^ Array new
]

{ #category : #private }
ViennaASTBrowser >> displayDefinition: aViennaNode [
	aViennaNode
		allDescendantsDo: [ :node | 
			node label = 'TypeDefinition'
				ifTrue: [ ^ node first ].
			node label = 'RecordTypeDefinition'
				ifTrue: [ ^ node first ].
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
		display:
				[ :ast | self class sectionNames at: ast label ifAbsent: [ ast label ] ];
		whenSelectionChangedDo: [ self updateDefinitionList ];
		yourself.
	definitionList := self newList
		beSingleSelection;
		display: [ :ast | self displayDefinition: ast ];
		whenSelectionChangedDo: [ :selection | 
			(selection notNil and: [ ActiveHand shiftPressed ])
				ifTrue: [ self updateAppendSource ]
				ifFalse: [ self updateSource ] ].
	sourceText := self newText
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

{ #category : #updating }
ViennaASTBrowser >> updateAppendSource [
	self definition
		ifNotNil: [ :node | 
			sourceText
				text: sourceText text , String cr asText , node highlightedSource ]
]

{ #category : #updating }
ViennaASTBrowser >> updateCategoryList [
	| newItems oldSelection |
	newItems := self module
		ifNotNil: [ :ast | 
			(ast
				detect: [ :node | node isViennaNode and: [ node label = 'ModuleBody' ] ]
				ifNone: [  ])
				ifNotNil: [ :body | body collect: [ :node | node first ] ]
				ifNil: [ Array new ] ]
		ifNil: [ Array new ].
	oldSelection := categoryList selection selectedItem.
	categoryList items: newItems.
	(newItems includes: oldSelection)
		ifTrue: [ categoryList selectItem: oldSelection ]
		ifFalse: [ categoryList unselectAll ]
]

{ #category : #updating }
ViennaASTBrowser >> updateDefinitionList [
	| newItems oldSelection |
	newItems := self category
		ifNotNil: [ :ast | self definitionsFromCategory: ast ]
		ifNil: [ Array new ].
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
		ifNotNil: [ :node | sourceText text: node highlightedSource ]
]
