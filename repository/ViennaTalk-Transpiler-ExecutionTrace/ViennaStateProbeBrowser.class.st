Class {
	#name : 'ViennaStateProbeBrowser',
	#superclass : 'SpPresenter',
	#instVars : [
		'specification',
		'probeList',
		'addProbeButton',
		'removeProbeButton'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Spec2',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Spec2'
}

{ #category : 'accessing' }
ViennaStateProbeBrowser >> abstractStateProbes: aCollectionOfViennaAbstractStateProbe [

	probeList items:
		(aCollectionOfViennaAbstractStateProbe collect: [ :probe |
				 self
					 newItemWithName: probe name
					 module: probe moduleName
					 expression: probe source ])
]

{ #category : 'operations' }
ViennaStateProbeBrowser >> addExpressionProbeIn: aViennaModuleNode [

	| expressionString |
	expressionString := ''.
	[
		| expressionNode |
		expressionString := self
			                    request:
			                    'probe expression in '
			                    , aViennaModuleNode identifier
			                    initialAnswer: expressionString
			                    title: 'Add a probe'.
		expressionString ifNil: [ ^ self ].
		expressionNode := ViennaVDMParser current expression parse:
			                  expressionString.
		expressionNode isPetit2Success
			ifTrue: [
					expressionNode parent: aViennaModuleNode.
					[
						expressionNode typecheck.
						^ self
							  addProbeWithModule: aViennaModuleNode identifier
							  expression: expressionString ]
						on: ViennaTypeError
						do: [ :ex | self alert: ex messageText ] ]
			ifFalse: [ self alert: 'Syntax error' ] ] repeat
]

{ #category : 'operations' }
ViennaStateProbeBrowser >> addProbe [

	self addProbeMenu openWithSpecAtPointer
]

{ #category : 'menus' }
ViennaStateProbeBrowser >> addProbeMenu [

	^ self newMenu addGroup: [ :group |
			  specification modulesDo: [ :moduleNode |
					  group addItem: [ :item |
							  item
								  name: moduleNode identifier;
								  subMenu: (self addProbeMenu: moduleNode) ] ] ] yourself
]

{ #category : 'menus' }
ViennaStateProbeBrowser >> addProbeMenu: aViennaModuleNode [

	^ self newMenu
		  addGroup: [ :group |
				  group
					  addItem: [ :item |
							  item
								  name: 'state variable';
								  subMenu: (self addStateVariableProbeMenu: aViennaModuleNode) ];
					  addItem: [ :item |
							  item
								  name: 'pure operation';
								  subMenu: (self addPureOperationProbeMenu: aViennaModuleNode) ] ];
		  addGroup: [ :group |
				  group addItem: [ :item |
						  item
							  name: 'Enter an expression...';
							  action: [ self addExpressionProbeIn: aViennaModuleNode ] ] ];
		  yourself
]

{ #category : 'operations' }
ViennaStateProbeBrowser >> addProbeWithModule: aString expression: anotherString [

	| name |
	name := anotherString.
	[
		name := self
			        request: 'Abstract field name'
			        initialAnswer: name
			        title: 'Add a probe'.
		name ifNil: [ ^ self ].
		name := name trim.
		name ifNotEmpty: [
				(probeList items anySatisfy: [ :item |
					 name = (self nameInItem: item) ])
					ifTrue: [ self alert: name , ' is already used.' ]
					ifFalse: [
							^ self
								  addProbeWithName: name
								  module: aString
								  expression: anotherString ] ] ] repeat
]

{ #category : 'operations' }
ViennaStateProbeBrowser >> addProbeWithName: aString module: anotherString expression: yetAnotherString [

	| index probes |
	index := probeList selectedIndex.
	index = 0 ifTrue: [ index := probeList items size + 1 ].
	probes := probeList items asOrderedCollection.
	probes
		add: (self
				 newItemWithName: aString
				 module: anotherString
				 expression: yetAnotherString)
		beforeIndex: index.
	probeList
		items: probes;
		selectIndex: index + 1.
	^ self
]

{ #category : 'menus' }
ViennaStateProbeBrowser >> addPureOperationProbeMenu: aViennaModuleNode [

	^ self newMenu
		  addGroup: [ :group |
				  self
					  pureZeroArgOperationsIn: aViennaModuleNode
					  do: [ :defNode |
							  group addItem: [ :item |
										  | expr |
										  expr := defNode identifier , '()'.
										  item
											  name: expr;
											  action: [
												  self
													  addProbeWithModule: aViennaModuleNode identifier
													  expression: expr ] ] ] ];
		  yourself
]

{ #category : 'menus' }
ViennaStateProbeBrowser >> addStateVariableProbeMenu: aViennaModuleNode [

	^ self newMenu
		  addGroup: [ :group |
				  self stateVariablesIn: aViennaModuleNode do: [ :fieldNode |
							  group addItem: [ :item |
										  item
											  name: fieldNode identifier;
											  action: [
													  self
														  addProbeWithModule: aViennaModuleNode identifier
														  expression: fieldNode identifier ] ] ] ];
		  yourself
]

{ #category : 'layout' }
ViennaStateProbeBrowser >> defaultLayout [
	"#moduleList . #probeList . #addProbeButton . #removeProbeButton . #editProbeButton "

	^ SpBoxLayout newVertical
		  add: probeList expand: true;
		  add: (SpBoxLayout newHorizontal
				   add: addProbeButton width: self class buttonHeight;
				   add: removeProbeButton width: self class buttonHeight;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : 'accessing' }
ViennaStateProbeBrowser >> expressionInItem: anArray [

	^ anArray third
]

{ #category : 'initialization' }
ViennaStateProbeBrowser >> initializePresenters [

	probeList := self newTable
		             beSingleSelection;
		             activateOnDoubleClick;
		             addColumn: (SpStringTableColumn
				              title: 'name'
				              evaluated: [ :item | self nameInItem: item ]);
		             addColumn: (SpStringTableColumn
				              title: 'module'
				              evaluated: [ :item | self moduleInItem: item ]);
		             addColumn: (SpStringTableColumn
				              title: 'expression'
				              evaluated: [ :item | self expressionInItem: item ]);
		             whenSelectionChangedDo: [ self selectedProbeChanged ];
		             whenActivatedDo: [ probeList unselectAll ];
		             yourself.
	addProbeButton := self newButton
		                  icon: (self iconNamed: #add);
		                  action: [ self addProbe ];
		                  enable;
		                  yourself.
	removeProbeButton := self newButton
		                     icon: (self iconNamed: #remove);
		                     action: [ self removeProbe ];
		                     disable;
		                     yourself
]

{ #category : 'accessing' }
ViennaStateProbeBrowser >> moduleInItem: anArray [

	^ anArray second
]

{ #category : 'accessing' }
ViennaStateProbeBrowser >> nameInItem: anArray [

	^ anArray first
]

{ #category : 'accessing' }
ViennaStateProbeBrowser >> newItemWithName: aString module: anotherString expression: yetAnotherString [

	^ {
		  aString.
		  anotherString.
		  yetAnotherString }
]

{ #category : 'accessing' }
ViennaStateProbeBrowser >> probes [

	^ probeList items
]

{ #category : 'accessing' }
ViennaStateProbeBrowser >> probesWithTranspiledSpecification: aViennaTranspiledModularDocument [

	^ Array streamContents: [ :stream |
			  self
				  withTranspiledSpecification: aViennaTranspiledModularDocument
				  probesDo: [ :probe | stream nextPut: probe ] ]
]

{ #category : 'enumerating' }
ViennaStateProbeBrowser >> pureZeroArgOperationsIn: aViennaModuleNode do: aBlock [

	aViennaModuleNode toplevelDefinitionsDo: [ :toplevelDefinitionNode |
			((toplevelDefinitionNode isViennaExplicitOperationDefinitionNode
				  or: [
					  toplevelDefinitionNode
						  isViennaExtendedExplicitOperationDefinitionNode ]) and: [
					 toplevelDefinitionNode isPureOperation and: [
						 toplevelDefinitionNode parameters isEmpty ] ]) ifTrue: [
				aBlock value: toplevelDefinitionNode ] ]
]

{ #category : 'operations' }
ViennaStateProbeBrowser >> removeProbe [

	| index probes |
	index := probeList selectedIndex.
	index = 0 ifTrue: [ ^ nil ].
	probes := probeList items asOrderedCollection.
	probes removeAt: index.
	probeList
		items: probes;
		selectIndex: (index min: probes size)
]

{ #category : 'ui requests' }
ViennaStateProbeBrowser >> request: request initialAnswer: initialAnwser title: title [

	| answer |
	answer := self application newRequest
		          title: title;
		          label: request;
		          text: initialAnwser;
		          openModal.

	^ answer
]

{ #category : 'updating' }
ViennaStateProbeBrowser >> selectedProbeChanged [

	self updateButtons
]

{ #category : 'accessing' }
ViennaStateProbeBrowser >> specification [

	^ specification
]

{ #category : 'accessing' }
ViennaStateProbeBrowser >> specification: aViennaModularDocumentNode [

	specification := aViennaModularDocumentNode.
	self specificationChanged
]

{ #category : 'updating' }
ViennaStateProbeBrowser >> specificationChanged [

	self updateProbeList
]

{ #category : 'enumerating' }
ViennaStateProbeBrowser >> stateVariablesIn: aViennaModuleNode do: aBlock [

	aViennaModuleNode stateDefinition ifNotNil: [ :stateDefinitionNode |
		stateDefinitionNode fieldsDo: aBlock ]
]

{ #category : 'updating' }
ViennaStateProbeBrowser >> updateButtons [

	| probeSelected |
	probeSelected := probeList selectedItem notNil.
	addProbeButton enable.
	removeProbeButton enabled: probeSelected
]

{ #category : 'updating' }
ViennaStateProbeBrowser >> updateProbeList [

	probeList items: (Array streamContents: [ :stream |
				 specification ifNotNil: [
						 specification modulesDo: [ :module |
								 module stateDefinition ifNotNil: [ :stateDefinition |
										 stateDefinition fieldsDo: [ :field |
												 | identifier |
												 identifier := field identifier.
												 stream nextPut: (self
														  newItemWithName: identifier
														  module: module identifier
														  expression: identifier) ] ] ] ] ])
]

{ #category : 'accessing' }
ViennaStateProbeBrowser >> windowTitle [

	^ 'Abstract State Probers'
]

{ #category : 'enumerating' }
ViennaStateProbeBrowser >> withTranspiledSpecification: aViennaTranspiledModularDocument probesDo: aBlock [

	probeList items do: [ :item |
			(ViennaAbstractStateProbe
				 name: (self nameInItem: item)
				 receiver:
				 (aViennaTranspiledModularDocument at: (self moduleInItem: item))
				 source: (self expressionInItem: item)) ifCompiledDo: aBlock ]
]
