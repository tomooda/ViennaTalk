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

{ #category : 'operations' }
ViennaStateProbeBrowser >> addExpressionProbe: aString in: aViennaModuleNode [

	| index probes |
	index := probeList selectedIndex.
	index = 0 ifTrue: [ index := probeList items size + 1 ].
	probes := probeList items asOrderedCollection.
	probes
		add: aViennaModuleNode identifier -> aString
		beforeIndex: index.
	probeList
		items: probes;
		selectIndex: index + 1.
	^ self
]

{ #category : 'operations' }
ViennaStateProbeBrowser >> addExpressionProbeIn: aViennaModuleNode [

	| expressionString |
	expressionString := ''.
	[
		| expressionNode |
		expressionString := [
			                    self
				                    request:
				                    'probe expression in '
				                    , aViennaModuleNode identifier
				                    initialAnswer: expressionString
				                    title: 'Add a probe' ]
			                    on: SpCancelledInteractionError
			                    do: [ :ex | ex return: nil ].
		expressionString ifNil: [ ^ self ].
		expressionNode := ViennaVDMParser current expression parse:
			                  expressionString.
		expressionNode isPetit2Success
			ifTrue: [
					expressionNode parent: aViennaModuleNode.
					[
						expressionNode typecheck.
						^ self
							  addExpressionProbe: expressionString
							  in: aViennaModuleNode ]
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
												  self addExpressionProbe: expr in: aViennaModuleNode ] ] ] ];
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
													  addExpressionProbe: fieldNode identifier
													  in: aViennaModuleNode ] ] ] ];
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

{ #category : 'initialization' }
ViennaStateProbeBrowser >> initializePresenters [

	probeList := self newTable
		             beSingleSelection;
		             activateOnDoubleClick;
		             addColumn:
			             (SpStringTableColumn
				              title: 'module'
				              evaluated: [ :assoc | assoc key ]);
		             addColumn: (SpStringTableColumn
				              title: 'expression'
				              evaluated: [ :assoc | assoc value ]);
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
ViennaStateProbeBrowser >> probes [

	| probes |
	probes := Dictionary new.
	probeList items do: [ :assoc |
			(probes at: assoc key ifAbsentPut: [ OrderedCollection new ]) add:
				assoc value ].
	^ probes
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

{ #category : 'accessing' }
ViennaStateProbeBrowser >> windowTitle [

	^ 'Abstract State Probers'
]
