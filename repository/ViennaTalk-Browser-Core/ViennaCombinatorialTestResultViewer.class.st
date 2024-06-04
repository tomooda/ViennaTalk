Class {
	#name : 'ViennaCombinatorialTestResultViewer',
	#superclass : 'SpPresenter',
	#instVars : [
		'testResult',
		'sourceText',
		'failureList'
	],
	#category : 'ViennaTalk-Browser-Core-TestRunner',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'TestRunner'
}

{ #category : 'layout' }
ViennaCombinatorialTestResultViewer class >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.4;
		  add: #sourceText;
		  add: #failureList;
		  yourself
]

{ #category : 'instance creation' }
ViennaCombinatorialTestResultViewer class >> on: aViennaCombinatorialTestResultItem [

	^ self new
		  testResult: aViennaCombinatorialTestResultItem;
		  yourself
]

{ #category : 'menus' }
ViennaCombinatorialTestResultViewer >> failureListContextMenu [

	| menu |
	menu := self newMenu.
	failureList selectedItem ifNotNil: [ :failure |
		menu addItem: [ :item |
			item
				name: 'Debug';
				action: [ failure exception debug ] ] ].
	^ menu
]

{ #category : 'initialization' }
ViennaCombinatorialTestResultViewer >> initializePresenters [

	super initializePresenters.
	sourceText := self newVDMSource.
	failureList := self newTable
		               contextMenu: [ self failureListContextMenu ];
		               yourself
]

{ #category : 'initialization' }
ViennaCombinatorialTestResultViewer >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter initialExtent: 700 @ 400
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultViewer >> testResult [

	^ testResult
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultViewer >> testResult: aViennaCombinatorialTestResultItem [

	testResult := aViennaCombinatorialTestResultItem.
	self testResultChanged
]

{ #category : 'updating' }
ViennaCombinatorialTestResultViewer >> testResultChanged [

	self
		updateSourceText;
		updateFailureList
]

{ #category : 'accessing' }
ViennaCombinatorialTestResultViewer >> title [

	^ 'Combinatorial Test Failures'
]

{ #category : 'updating' }
ViennaCombinatorialTestResultViewer >> updateFailureList [

	testResult ifNotNil: [
		testResult failures ifNotEmpty: [ :failures |
			failureList
				columns: (failures first env keys collect: [ :var |
							 SpStringTableColumn
								 title: var
								 evaluated: [ :failure | (failure env at: var) viennaString ] ]);
				items: failures.
			^ self ] ].
	failureList
		columns: {  };
		items: {  }
]

{ #category : 'updating' }
ViennaCombinatorialTestResultViewer >> updateSourceText [

	sourceText text: (testResult
			 ifNotNil: [ testResult traceNode highlightedSource ]
			 ifNil: [ Text new ])
]
