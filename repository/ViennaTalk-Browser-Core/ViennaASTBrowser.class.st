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

{ #category : #refactoring }
ViennaASTBrowser >> convertExplicitFunctionIntoOperation: aViennaNode [
	ViennaConvertExplicitFunctionIntoOperation new
		ast: aViennaNode;
		execute.
	self
		updateDefinitionList;
		updateSource
]

{ #category : #accessing }
ViennaASTBrowser >> definition [
	^ definitionList selection selectedItem
]

{ #category : #menus }
ViennaASTBrowser >> definitionListContextMenu [
	| menu |
	menu := self newMenu.
	menu
		addGroup: [ :group | 
			self definition
				ifNotNil: [ :def | 
					def label = 'AccessTypeDefinition'
						ifTrue: [ group
								addItem: [ :item | 
									item
										name: 'rename';
										action: [ self renameType: def second first inModule: def module ] ] ].
					def label = 'AccessValueDefinition'
						ifTrue: [ group
								addItem: [ :item | 
									item
										name: 'rename';
										action: [ def second first patternIdentifierNames
												ifNotEmpty: [ :identifiers | 
													(identifiers size = 1
														ifTrue: [ identifiers first ]
														ifFalse: [ (UIManager default
																chooseFrom: identifiers
																message: 'choose identifier to rename')
																ifNotNil: #trim
																ifNil: [ '' ] ])
														ifNotEmpty: [ :oldName | self renameValue: oldName inModule: def module ] ] ] ] ].
					(def label = 'AccessFunctionDefinition'
						and: [ def second first label = 'ExplicitFunctionDefinition' ])
						ifTrue: [ group
								addItem: [ :item | 
									item
										name: 'rename';
										action: [ self
												renameExplicitFunction: def second first first
												inModule: def module ] ];
								addItem: [ :item | 
									item
										name: 'convert into operation';
										action: [ self convertExplicitFunctionIntoOperation: def ] ] ].
					(def label = 'AccessFunctionDefinition'
						and: [ def second first label = 'ImplicitFunctionDefinition' ])
						ifTrue: [ group
								addItem: [ :item | 
									item
										name: 'rename';
										action: [ self
												renameImplicitFunction: def second first first
												inModule: def module ] ] ].
					def label = 'StateDefinition'
						ifTrue: [ group
								addItem: [ :item | 
									item
										name: 'rename';
										action: [ self renameStateConstructor: def first inModule: def module ] ] ].
					def label = 'Field'
						ifTrue: [ group
								addItem: [ :item | 
									item
										name: 'rename';
										action: [ self renameStateVariable: def first inModule: def module ] ] ].
					(def label = 'AccessOperationDefinition'
						and: [ def second first label = 'ExplicitOperationDefinition' ])
						ifTrue: [ group
								addItem: [ :item | 
									item
										name: 'rename';
										action: [ self
												renameExplicitOperation: def second first first
												inModule: def module ] ] ].
					(def label = 'AccessOperationDefinition'
						and: [ def second first label = 'ImplicitOperationDefinition' ])
						ifTrue: [ group
								addItem: [ :item | 
									item
										name: 'rename';
										action: [ self
												renameImplicitOperation: def second first first
												inModule: def module ] ] ] ] ].
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

{ #category : #refactoring }
ViennaASTBrowser >> renameExplicitFunction: aString inModule: aViennaNode [
	(UIManager default request: 'rename function' initialAnswer: aString)
		ifNotNil: [ :ans | 
			ans trim
				ifNotEmpty: [ :newName | 
					ViennaRenameExplicitFunction new
						ast: aViennaNode;
						oldName: aString;
						newName: newName;
						execute.
					self
						updateDefinitionList;
						updateSource ] ]
]

{ #category : #refactoring }
ViennaASTBrowser >> renameExplicitOperation: aString inModule: aViennaNode [
	(UIManager default request: 'rename operation' initialAnswer: aString)
		ifNotNil: [ :ans | 
			ans trim
				ifNotEmpty: [ :newName | 
					ViennaRenameExplicitOperation new
						ast: aViennaNode;
						oldName: aString;
						newName: newName;
						execute.
					self
						updateDefinitionList;
						updateSource ] ]
]

{ #category : #refactoring }
ViennaASTBrowser >> renameImplicitFunction: aString inModule: aViennaNode [
	(UIManager default request: 'rename function' initialAnswer: aString)
		ifNotNil: [ :ans | 
			ans trim
				ifNotEmpty: [ :newName | 
					ViennaRenameImplicitFunction new
						ast: aViennaNode;
						oldName: aString;
						newName: newName;
						execute.
					self
						updateDefinitionList;
						updateSource ] ]
]

{ #category : #refactoring }
ViennaASTBrowser >> renameImplicitOperation: aString inModule: aViennaNode [
	(UIManager default request: 'rename operation' initialAnswer: aString)
		ifNotNil: [ :ans | 
			ans trim
				ifNotEmpty: [ :newName | 
					ViennaRenameImplicitOperation new
						ast: aViennaNode;
						oldName: aString;
						newName: newName;
						execute.
					self
						updateDefinitionList;
						updateSource ] ]
]

{ #category : #refactoring }
ViennaASTBrowser >> renameLocal: aViennaNode [
	| oldName |
	oldName := aViennaNode first.
	(UIManager default request: 'rename local' initialAnswer: oldName)
		ifNotNil: [ :ans | 
			ans trim
				ifNotEmpty: [ :newName | 
					ViennaRenameLocal new
						ast: aViennaNode;
						oldName: oldName;
						newName: newName;
						execute.
					self updateDefinitionList.
					self updateSource ] ]
]

{ #category : #refactoring }
ViennaASTBrowser >> renameStateConstructor: aString inModule: aViennaNode [
	(UIManager default
		request: 'rename state constructor'
		initialAnswer: aString)
		ifNotNil: [ :ans | 
			ans trim
				ifNotEmpty: [ :newName | 
					ViennaRenameStateConstructor new
						ast: aViennaNode;
						oldName: aString;
						newName: newName;
						execute.
					self
						updateDefinitionList;
						updateSource ] ]
]

{ #category : #refactoring }
ViennaASTBrowser >> renameStateVariable: aString inModule: aViennaNode [
	(UIManager default
		request: 'rename state variable'
		initialAnswer: aString)
		ifNotNil: [ :ans | 
			ans trim
				ifNotEmpty: [ :newName | 
					ViennaRenameStateVariable new
						ast: aViennaNode;
						oldName: aString;
						newName: newName;
						execute.
					self
						updateDefinitionList;
						updateSource ] ]
]

{ #category : #refactoring }
ViennaASTBrowser >> renameType: aString inModule: aViennaNode [
	(UIManager default request: 'rename type' initialAnswer: aString)
		ifNotNil: [ :ans | 
			ans trim
				ifNotEmpty: [ :newName | 
					ViennaRenameType new
						ast: aViennaNode;
						oldName: aString;
						newName: newName;
						execute.
					self
						updateDefinitionList;
						updateSource ] ]
]

{ #category : #refactoring }
ViennaASTBrowser >> renameValue: aString inModule: aViennaNode [
	(UIManager default request: 'rename value' initialAnswer: aString)
		ifNotNil: [ :ans | 
			ans trim
				ifNotEmpty: [ :newName | 
					ViennaRenameValue new
						ast: aViennaNode;
						oldName: aString;
						newName: newName;
						execute.
					self
						updateDefinitionList;
						updateSource ] ]
]

{ #category : #menus }
ViennaASTBrowser >> selectNode: aViennaNode [
	sourceText
		selectionInterval: (sourceText text string intervalForSource: aViennaNode)
]

{ #category : #menus }
ViennaASTBrowser >> selectScope: aViennaNode [
	self selectNode: (ViennaRefactoring new scopeOf: aViennaNode)
]

{ #category : #menus }
ViennaASTBrowser >> sourceTextContextMenu [
	| menu |
	menu := self newMenu.
	(sourceText text string asViennaTracingString
		nodeContaining: sourceText selectionInterval
		ifAbsent: [ nil ])
		ifNotNil: [ :node | 
			node label = 'LocalName'
				ifTrue: [ menu
						addItem: [ :item | 
							item
								name: 'rename local';
								action: [ self renameLocal: node ] ] ].
			node label = 'PatternIdentifier'
				ifTrue: [ menu
						addItem: [ :item | 
							item
								name: 'rename local';
								action: [ self renameLocal: node ] ] ] ].
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
