Class {
	#name : 'ViennaStateProbeEditor',
	#superclass : 'SpPresenter',
	#instVars : [
		'specification',
		'probes',
		'moduleList',
		'probeList',
		'addProbeButton',
		'removeProbeButton',
		'editProbeButton'
	],
	#category : 'ViennaTalk-Transpiler-ExecutionTrace-Spec2',
	#package : 'ViennaTalk-Transpiler-ExecutionTrace',
	#tag : 'Spec2'
}

{ #category : 'operations' }
ViennaStateProbeEditor >> addExpressionProbe [

	self selectedModuleDo: [ :moduleNode |
			| expressionString |
			expressionString := ''.
			[
				| expressionNode |
				expressionString := [
					                    self
						                    request:
						                    'probe expression in '
						                    , moduleNode identifier
						                    initialAnswer: expressionString
						                    title: 'Add a probe' ]
					                    on: SpCancelledInteractionError
					                    do: [ :ex | ex return: nil ].
				expressionString ifNil: [ ^ self ].
				expressionNode := ViennaVDMParser current expression parse:
					                  expressionString.
				expressionNode isPetit2Success
					ifTrue: [
							expressionNode parent: moduleNode.
							[
								expressionNode typecheck.
								^ self addExpressionProbe: expressionString ]
								on: ViennaTypeError
								do: [ :ex | self alert: ex messageText ] ]
					ifFalse: [ self alert: 'Syntax error' ] ] repeat ]
]

{ #category : 'operations' }
ViennaStateProbeEditor >> addExpressionProbe: aString [

	self selectedModuleDo: [ :moduleNode |
			| index |
			index := probeList selectedIndex.
			index = 0 ifTrue: [ index := probeList items size + 1 ].
			(probes
				 at: moduleNode identifier
				 ifAbsentPut: [ OrderedCollection new ])
				add: aString
				beforeIndex: index.
			self updateProbeList.
			^ self ]
]

{ #category : 'operations' }
ViennaStateProbeEditor >> addProbe [

	self addProbeMenu openWithSpecAtPointer
]

{ #category : 'menus' }
ViennaStateProbeEditor >> addProbeMenu [

	^ self newMenu
		  addGroup: [ :group |
				  group
					  addItem: [ :item |
							  item
								  name: 'state variable';
								  subMenu: self addStateVariableProbeMenu ];
					  addItem: [ :item |
							  item
								  name: 'pure operation';
								  subMenu: self addPureOperationProbeMenu ] ];
		  addGroup: [ :group |
				  group addItem: [ :item |
						  item
							  name: 'Enter an expression...';
							  action: [ self addExpressionProbe ] ] ];
		  yourself
]

{ #category : 'menus' }
ViennaStateProbeEditor >> addPureOperationProbeMenu [

	^ self newMenu
		  addGroup: [ :group |
				  self pureZeroArgOperationsDo: [ :defNode |
							  group addItem: [ :item |
										  | expr |
										  expr := defNode identifier , '()'.
										  item
											  name: expr;
											  action: [ self addExpressionProbe: expr ] ] ] ];
		  yourself
]

{ #category : 'menus' }
ViennaStateProbeEditor >> addStateVariableProbeMenu [

	^ self newMenu
		  addGroup: [ :group |
				  self stateVariablesDo: [ :fieldNode |
							  group addItem: [ :item |
										  item
											  name: fieldNode identifier;
											  action: [ self addExpressionProbe: fieldNode identifier ] ] ] ];
		  yourself
]

{ #category : 'layout' }
ViennaStateProbeEditor >> defaultLayout [
	"#moduleList . #probeList . #addProbeButton . #removeProbeButton . #editProbeButton "

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.3;
		  add: moduleList;
		  add: (SpBoxLayout newVertical
				   add: probeList expand: true;
				   add: (SpBoxLayout newHorizontal
						    add: addProbeButton width: self class buttonHeight;
						    add: removeProbeButton width: self class buttonHeight;
						    add: editProbeButton width: self class buttonHeight;
						    yourself)
				   expand: false;
				   yourself);
		  yourself
]

{ #category : 'operations' }
ViennaStateProbeEditor >> editProbe [

	self selectedModuleDo: [ :moduleNode |
			| expressionString |
			expressionString := probeList selectedItem ifNil: [ '' ].
			[
				| expressionNode |
				expressionString := self
					                    request:
					                    'probe expression in '
					                    , moduleNode identifier
					                    initialAnswer: expressionString
					                    title: 'Add a probe'.
				expressionString ifNil: [ ^ self ].
				expressionNode := ViennaVDMParser current expression parse:
					                  expressionString.
				expressionNode isPetit2Success
					ifTrue: [
							expressionNode parent: moduleNode.
							[
								| index |
								expressionNode typecheck.
								index := probeList selectedIndex.
								index = 0 ifTrue: [ index := probeList items size + 1 ].
								(probes
									 at: moduleNode identifier
									 ifAbsentPut: [ OrderedCollection new ])
									add: expressionString
									beforeIndex: index.
								self updateProbeList.
								^ self ]
								on: ViennaTypeError
								do: [ :ex | self alert: ex messageText ] ]
					ifFalse: [ self alert: 'Syntax error' ] ] repeat ]
]

{ #category : 'initialization' }
ViennaStateProbeEditor >> initialize [

	probes := Dictionary new.
	super initialize
]

{ #category : 'initialization' }
ViennaStateProbeEditor >> initializePresenters [

	moduleList := self newList
		              whenSelectionChangedDo: [ self selectedModuleChanged ];
		              yourself.
	probeList := self newList
		             whenSelectionChangedDo: [ self selectedProbeChanged ];
		             yourself.
	addProbeButton := self newButton
		                  icon: (self iconNamed: #add);
		                  action: [ self addProbe ];
		                  disable;
		                  yourself.
	removeProbeButton := self newButton
		                     icon: (self iconNamed: #remove);
		                     action: [ self removeProbe ];
		                     disable;
		                     yourself.
	editProbeButton := self newButton
		                   icon: (self iconNamed: #edit);
		                   action: [ self editProbe ];
		                   disable;
		                   yourself
]

{ #category : 'accessing' }
ViennaStateProbeEditor >> probes [

	^ probes
]

{ #category : 'enumerating' }
ViennaStateProbeEditor >> pureZeroArgOperationsDo: aBlock [

	self selectedModuleDo: [ :moduleNode |
			moduleNode toplevelDefinitionsDo: [ :toplevelDefinitionNode |
					((toplevelDefinitionNode isViennaExplicitOperationDefinitionNode
						  or: [
							  toplevelDefinitionNode
								  isViennaExtendedExplicitOperationDefinitionNode ]) and: [
							 toplevelDefinitionNode isPureOperation and: [
								 toplevelDefinitionNode parameters isEmpty ] ]) ifTrue: [
						aBlock value: toplevelDefinitionNode ] ] ]
]

{ #category : 'operations' }
ViennaStateProbeEditor >> removeProbe [

	moduleList selectedItem ifNotNil: [ :moduleName |
			| index |
			index := probeList selectedIndex.
			index = 0 ifTrue: [ ^ nil ].
			probes at: moduleName ifPresent: [ :collection |
					collection removeIndex: index.
					self updateProbeList ] ]
]

{ #category : 'updating' }
ViennaStateProbeEditor >> selectedModuleChanged [

	self updateProbeList
]

{ #category : 'accessing' }
ViennaStateProbeEditor >> selectedModuleDo: aBlock [

	moduleList selectedItem ifNotNil: [ :moduleName |
			(specification moduleNamed: moduleName) ifNotNil: [ :node |
				^ aBlock value: node ] ].
	^ nil
]

{ #category : 'updating' }
ViennaStateProbeEditor >> selectedProbeChanged [

	self updateButtons
]

{ #category : 'accessing' }
ViennaStateProbeEditor >> specification [

	^ specification
]

{ #category : 'accessing' }
ViennaStateProbeEditor >> specification: aViennaModularDocumentNode [

	specification := aViennaModularDocumentNode.
	self specificationChanged
]

{ #category : 'updating' }
ViennaStateProbeEditor >> specificationChanged [

	self updateModuleList
]

{ #category : 'enumerating' }
ViennaStateProbeEditor >> stateVariablesDo: aBlock [

	self selectedModuleDo: [ :moduleNode |
			moduleNode stateDefinition ifNotNil: [ :stateDefinitionNode |
				stateDefinitionNode fieldsDo: aBlock ] ]
]

{ #category : 'updating' }
ViennaStateProbeEditor >> updateButtons [

	| moduleSelected probeSelected |
	moduleSelected := moduleList selectedItem notNil.
	probeSelected := probeList selectedItem notNil.
	addProbeButton enabled: moduleSelected.
	removeProbeButton enabled: probeSelected.
	editProbeButton enabled: probeSelected
]

{ #category : 'updating' }
ViennaStateProbeEditor >> updateModuleList [

	moduleList items:
		(specification ifNotNil: #moduleNames ifNil: [ #(  ) ])
]

{ #category : 'updating' }
ViennaStateProbeEditor >> updateProbeList [

	probeList items: (moduleList selectedItem
			 ifNotNil: [ :moduleName |
				 probes at: moduleName ifAbsentPut: [ OrderedCollection new ] ]
			 ifNil: [ #(  ) ])
]

{ #category : 'accessing' }
ViennaStateProbeEditor >> windowTitle [

	^ 'Abstract State Probers'
]
