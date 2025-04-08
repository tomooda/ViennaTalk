Class {
	#name : 'ViennaChangesMerger',
	#superclass : 'SpPresenter',
	#instVars : [
		'baseDefinitionList',
		'localSourceText',
		'remoteSourceText',
		'mergedSourceText',
		'localChanges',
		'remoteChanges',
		'mergedChanges',
		'useLocalChangeButton',
		'useRemoteChangeButton'
	],
	#category : 'ViennaTalk-Browser-Core-Browsers',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Browsers'
}

{ #category : 'examples' }
ViennaChangesMerger class >> example [

	| parser base remote local |
	parser := ViennaVDMParser current topLevelDefinitionList.
	base := 'module A exports all definitions values v1 = 1; v2 = 2 end A'
		        asViennaDocumentAst.
	remote := 'module A exports all definitions values v1:nat = 1; v2:nat = 2 end A'
		          asViennaDocumentAst.
	local := 'module A exports all definitions values v1 = 1; v2:nat1 = 2; v3 = 3 end A'
		         asViennaDocumentAst.
	(self
		 remoteChanges:
			 ((ViennaNodeDiffSet from: base to: remote) condenseChanges
				  select: #isViennaTopLevelDefinitionNodeChange)
		 localChanges:
			 ((ViennaNodeDiffSet from: base to: local) condenseChanges select:
				  #isViennaTopLevelDefinitionNodeChange)) open
]

{ #category : 'instance creation' }
ViennaChangesMerger class >> remoteChanges: anArrayOfViennaTopLevelDefinitionNodeChange localChanges: anotherArrayOfViennaTopLevelDefinitionNodeChange [

	^ self new
		  remoteChanges: anArrayOfViennaTopLevelDefinitionNodeChange;
		  localChanges: anotherArrayOfViennaTopLevelDefinitionNodeChange;
		  yourself
]

{ #category : 'operations' }
ViennaChangesMerger >> accept: aViennaNode [

	| base |
	base := self baseDefinition.
	(aViennaNode isNil or: [ base isNil ]) ifTrue: [ ^ nil ].
	(mergedChanges
		 detect: [ :change | change from = base ]
		 ifNone: [ nil ])
		ifNotNil: [ :change | change to: aViennaNode ]
		ifNil: [
			mergedChanges := mergedChanges copyWith:
				                 (ViennaTopLevelDefinitionNodeChange
					                  from: base
					                  to: aViennaNode) ].
	baseDefinitionList refresh.
	self updateMergedSourceText
]

{ #category : 'operations' }
ViennaChangesMerger >> acceptLocalSourceText [

	| ast |
	ast := self baseDefinition parser parse:
		       localSourceText text asString.
	ast isPetit2Success ifTrue: [ self accept: ast ]
]

{ #category : 'operations' }
ViennaChangesMerger >> acceptMergedSourceText [

	| ast |
	ast := self baseDefinition parser parse:
		       mergedSourceText text asString.
	ast isPetit2Success ifTrue: [ self accept: ast ]
]

{ #category : 'operations' }
ViennaChangesMerger >> acceptRemoteSourceText [

	| ast |
	ast := self baseDefinition parser parse:
		       remoteSourceText text asString.
	ast isPetit2Success ifTrue: [ self accept: ast ]
]

{ #category : 'accessing' }
ViennaChangesMerger >> baseDefinition [

	^ baseDefinitionList selectedItem
]

{ #category : 'layout' }
ViennaChangesMerger >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.3;
		  add: (SpBoxLayout newVertical
				   add: 'conflicts' expand: false;
				   add: baseDefinitionList;
				   yourself);
		  add: (SpPanedLayout newHorizontal
				   add: (SpPanedLayout newVertical
						    add: (SpBoxLayout newVertical
								     add: 'remote' expand: false;
								     add: remoteSourceText;
								     add:
									     (SpBoxLayout newHorizontal
										      add: useRemoteChangeButton
										      expand: false)
								     expand: false;
								     yourself);
						    add: (SpBoxLayout newVertical
								     add: 'local' expand: false;
								     add: localSourceText;
								     add:
									     (SpBoxLayout newHorizontal
										      add: useLocalChangeButton
										      expand: false)
								     expand: false;
								     yourself);
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: 'resolved' expand: false;
						    add: mergedSourceText;
						    yourself);
				   yourself);
		  yourself
]

{ #category : 'testing' }
ViennaChangesMerger >> hasResolved: aViennaTopLevelDefinitionNode [

	^ mergedChanges contains: [ :change |
		  change from = aViennaTopLevelDefinitionNode ]
]

{ #category : 'highlighting' }
ViennaChangesMerger >> highlightLocalSourceText [

	
]

{ #category : 'highlighting' }
ViennaChangesMerger >> highlightMergedSourceText [

	
]

{ #category : 'highlighting' }
ViennaChangesMerger >> highlightRemoteSourceText [

	
]

{ #category : 'initialization' }
ViennaChangesMerger >> initialize [

	super initialize.
	localChanges := Array new.
	remoteChanges := Array new.
	mergedChanges := Array new
]

{ #category : 'initialization' }
ViennaChangesMerger >> initializePresenters [

	super initializePresenters.
	baseDefinitionList := self newTable
		                      beSingleSelection;
		                      whenSelectionChangedDo: [
			                      self
				                      updateRemoteSourceText;
				                      updateLocalSourceText;
				                      updateMergedSourceText;
				                      updateButtons ];
		                      addColumn: ((SpStringTableColumn
				                        title: 'module'
				                        evaluated: [ :node |
					                        node module
						                        ifNotNil: #identifier
						                        ifNil: [ '-' ] ])
				                       displayColor: [ :node |
					                       (self hasResolved: node)
						                       ifTrue: [ Color lightGray ]
						                       ifFalse: [ Color black ] ];
				                       yourself);
		                      addColumn: ((SpStringTableColumn
				                        title: 'identifiers'
				                        evaluated: [ :node |
					                        ',' join: node identifiers ])
				                       displayColor: [ :node |
					                       (self hasResolved: node)
						                       ifTrue: [ Color lightGray ]
						                       ifFalse: [ Color black ] ];
				                       yourself).
	localSourceText := self newVDMSource
		                   whenTextChangedDo: [
			                   localSourceText highlightWith:
					                   localSourceText highlighter
						                   topLevelDefinitionList ];
		                   whenSubmitDo: [ :text |
			                   self acceptLocalSourceText ];
		                   yourself.
	useLocalChangeButton := self newButton
		                        label: 'Use local';
		                        icon: (self iconNamed: #right);
		                        action: [ self acceptLocalSourceText ];
		                        yourself.
	remoteSourceText := self newVDMSource
		                    whenTextChangedDo: [
			                    remoteSourceText highlightWith:
					                    remoteSourceText highlighter
						                    topLevelDefinitionList ];
		                    whenSubmitDo: [ :text |
			                    self acceptRemoteSourceText ];
		                    yourself.
	useRemoteChangeButton := self newButton
		                         label: 'Use remote';
		                         icon: (self iconNamed: #right);
		                         action: [ self acceptRemoteSourceText ];
		                         yourself.
	mergedSourceText := self newVDMSource
		                    whenTextChangedDo: [
			                    mergedSourceText highlightWith:
					                    mergedSourceText highlighter
						                    topLevelDefinitionList ];
		                    whenSubmitDo: [ :text |
			                    self acceptMergedSourceText ];
		                    yourself
]

{ #category : 'initialization' }
ViennaChangesMerger >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter
		title: 'Vienna Changes Merger';
		initialExtent: 800 @ 400
]

{ #category : 'accessing' }
ViennaChangesMerger >> localChanges [

	^ localChanges
]

{ #category : 'accessing' }
ViennaChangesMerger >> localChanges: anArrayOfViennaTopLevelDefinitionNodeChange [

	localChanges := anArrayOfViennaTopLevelDefinitionNodeChange.
	self updateBaseDefinitionList
]

{ #category : 'accessing' }
ViennaChangesMerger >> localDefinition [

	^ self baseDefinition ifNotNil: [ :base |
		  (localChanges
			   detect: [ :change |
			   change from == base or: [ change to == base ] ]
			   ifNone: [ nil ]) ifNotNil: [ :change | change to ] ]
]

{ #category : 'accessing' }
ViennaChangesMerger >> mergedDefinition [

	^ self baseDefinition ifNotNil: [ :base |
		  (mergedChanges
			   detect: [ :change |
			   change from = base or: [ change to == base ] ]
			   ifNone: [ nil ]) ifNotNil: [ :change | change to ] ]
]

{ #category : 'accessing' }
ViennaChangesMerger >> remoteChanges [

	^ remoteChanges
]

{ #category : 'accessing' }
ViennaChangesMerger >> remoteChanges: anArrayOfViennaTopLevelDefinitionNodeChange [

	remoteChanges := anArrayOfViennaTopLevelDefinitionNodeChange.
	self updateBaseDefinitionList
]

{ #category : 'accessing' }
ViennaChangesMerger >> remoteDefinition [

	^ self baseDefinition ifNotNil: [ :base |
		  (remoteChanges
			   detect: [ :change |
			   change from = base or: [ change to == base ] ]
			   ifNone: [ nil ]) ifNotNil: [ :change | change to ] ]
]

{ #category : 'updating' }
ViennaChangesMerger >> updateBaseDefinitionList [

	| baseDefinitions |
	baseDefinitions := remoteChanges collect: [ :change |
		                   change from ifNil: [ change to ] ].
	baseDefinitions := baseDefinitions , (localChanges
		                    collect: [ :change |
		                    change from ifNil: [ change to ] ]
		                    thenSelect: [ :node |
		                    (baseDefinitions includes: node) not ]).
	baseDefinitionList items: baseDefinitions
]

{ #category : 'updating' }
ViennaChangesMerger >> updateButtons [

	
]

{ #category : 'updating' }
ViennaChangesMerger >> updateLocalSourceText [

	localSourceText text:
		(self localDefinition ifNotNil: #source ifNil: [ '' ])
]

{ #category : 'updating' }
ViennaChangesMerger >> updateMergedSourceText [

	mergedSourceText text:
		(self mergedDefinition ifNotNil: #source ifNil: [ '' ])
]

{ #category : 'updating' }
ViennaChangesMerger >> updateRemoteSourceText [

	remoteSourceText text:
		(self remoteDefinition ifNotNil: #source ifNil: [ '' ])
]

{ #category : 'operations' }
ViennaChangesMerger >> useLocalChange [

	self acceptLocalSourceText
]

{ #category : 'operations' }
ViennaChangesMerger >> useRemoteChange [

	self acceptRemoteSourceText
]
