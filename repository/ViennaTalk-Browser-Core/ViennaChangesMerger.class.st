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
		'mergedChanges'
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
	remote := 'module A exports all definitions values v1 = 1; v2:nat = 2 end A'
		          asViennaDocumentAst.
	local := 'module A exports all definitions values v1 = 1; v2:nat1 = 2 end A'
		         asViennaDocumentAst.
	(self
		 remoteChanges:
			 ((ViennaNodeDiffSet from: base to: remote) condenseChanges
				  select: #isViennaTopLevelDefinitionNodeChange)
		 localChanges:
			 ((ViennaNodeDiffSet from: base to: remote) condenseChanges
				  select: #isViennaTopLevelDefinitionNodeChange)) open
]

{ #category : 'instance creation' }
ViennaChangesMerger class >> remoteChanges: anArrayOfViennaTopLevelDefinitionNodeChange localChanges: anotherArrayOfViennaTopLevelDefinitionNodeChange [

	^ self new
		  remoteChanges: anArrayOfViennaTopLevelDefinitionNodeChange;
		  localChanges: anotherArrayOfViennaTopLevelDefinitionNodeChange;
		  yourself
]

{ #category : 'layout' }
ViennaChangesMerger >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.25;
		  add: baseDefinitionList;
		  add: (SpPanedLayout newHorizontal
				   add: (SpPanedLayout newVertical
						    add: remoteSourceText;
						    add: localSourceText;
						    yourself);
				   add: mergedSourceText);
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
	localSourceText := self newVDMSource.
	remoteSourceText := self newVDMSource.
	mergedSourceText := self newVDMSource
		                    whenTextChangedDo: [
			                    | highlighter |
			                    highlighter := ViennaVDMHighlighter new.
			                    mergedSourceText
				                    highlightWith: highlighter
				                    parser: highlighter topLevelDefinitionList ];
		                    whenSubmitDo: [ :text |
			                    self acceptMergedSourceText ];
		                    yourself
]

{ #category : 'initialization' }
ViennaChangesMerger >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter
		title: 'Vienna Changes Merger';
		initialExtent: 800 @ 600
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
ViennaChangesMerger >> remoteChanges [

	^ remoteChanges
]

{ #category : 'accessing' }
ViennaChangesMerger >> remoteChanges: anArrayOfViennaTopLevelDefinitionNodeChange [

	remoteChanges := anArrayOfViennaTopLevelDefinitionNodeChange.
	self updateBaseDefinitionList
]

{ #category : 'updating' }
ViennaChangesMerger >> updateBaseDefinitionList [

	| baseDefinitions |
	baseDefinitions := remoteChanges collect: #from.
	baseDefinitions := baseDefinitions , (localChanges
		                    collect: #from
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
		((baseDefinitionList selectedItem ifNotNil: [ :base |
			  (localChanges
				   detect: [ :change | change from = base ]
				   ifNone: [ nil ]) ifNotNil: [ :change |
				  change to highlightedSource ] ]) ifNil: [ '' ])
]

{ #category : 'updating' }
ViennaChangesMerger >> updateMergedSourceText [

	mergedSourceText text:
		((baseDefinitionList selectedItem ifNotNil: [ :base |
			  (mergedChanges
				   detect: [ :change | change from = base ]
				   ifNone: [ nil ]) ifNotNil: [ :change |
				  change to highlightedSource ] ]) ifNil: [ '' ])
]

{ #category : 'updating' }
ViennaChangesMerger >> updateRemoteSourceText [

	remoteSourceText text:
		((baseDefinitionList selectedItem ifNotNil: [ :base |
			  (remoteChanges
				   detect: [ :change | change from = base ]
				   ifNone: [ nil ]) ifNotNil: [ :change |
				  change to highlightedSource ] ]) ifNil: [ '' ])
]
