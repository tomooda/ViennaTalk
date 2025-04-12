Class {
	#name : 'ViennaMutationTestResultViewer',
	#superclass : 'SpPresenter',
	#instVars : [
		'resultSummaryLabel',
		'resultList',
		'sourceText',
		'displayedResult'
	],
	#category : 'ViennaTalk-Browser-Core-Testing',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Testing'
}

{ #category : 'operations' }
ViennaMutationTestResultViewer >> addMutation: aViennaMutation baseSpecification: aViennaNode mutatedSpecification: anotherViennaNode [

	| item |
	item := ViennaMutationTestResultItem
		        mutation: aViennaMutation
		        from: aViennaNode
		        to: anotherViennaNode.
	resultList items: (resultList items copyWith: item)
]

{ #category : 'layout' }
ViennaMutationTestResultViewer >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: resultSummaryLabel expand: false;
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.4;
				   add: resultList;
				   add: sourceText;
				   yourself);
		  yourself
]

{ #category : 'initialization' }
ViennaMutationTestResultViewer >> initializePresenters [

	super initializePresenters.
	resultSummaryLabel := self newLabel
		                      label: 'Mutant testing';
		                      yourself.
	resultList := self newTable
		              beSingleSelection;
		              beResizable;
		              whenSelectedItemChangedDo: [ self updateSourceText ];
		              addColumn:
			              (SpImageTableColumn
				               title: ''
				               evaluated: [ :result | result icon ])
				              beNotExpandable;
		              addColumn: (SpStringTableColumn
				               title: 'mutation'
				               evaluated: [ :result | result mutation name ])
				              beNotExpandable;
		              addColumn: (SpStringTableColumn
				               title: 'mutated definitions'
				               evaluated: [ :result |
					               ', ' join:
							               (result diffSet changedGlobalNames collect:
									                #source) ]);
		              yourself.
	sourceText := self newVDMSource
]

{ #category : 'initialization' }
ViennaMutationTestResultViewer >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter
		title: 'Mutation testing results';
		initialExtent: 800 @ 700
]

{ #category : 'updating' }
ViennaMutationTestResultViewer >> refresh [

	resultList refresh.
	self updateResultSummaryLabel
]

{ #category : 'accessing' }
ViennaMutationTestResultViewer >> resultItems [

	^ resultList items
]

{ #category : 'updating' }
ViennaMutationTestResultViewer >> updateResultSummaryLabel [

	| surviving killed |
	surviving := 0.
	killed := 0.
	resultList items do: [ :resultItem |
		resultItem isSurviving ifTrue: [ surviving := surviving + 1 ].
		resultItem isKilled ifTrue: [ killed := killed + 1 ] ].
	resultSummaryLabel label:
		'Kill rate: ' , (killed asFloat / (killed + surviving) asFloat
			 printShowingDecimalPlaces: 4) , ' (' , killed printString , ' / '
		, (killed + surviving) printString , ' / '
		, resultList items size printString , ')'
]

{ #category : 'updating' }
ViennaMutationTestResultViewer >> updateSourceText [

	| result |
	result := resultList selectedItem.
	displayedResult == result ifFalse: [
		displayedResult := result.
		sourceText text: (result
				 ifNotNil: [
					 | text |
					 text := '' asText.
					 result diffSet changesDo: [ :change |
						 change isViennaTopLevelDefinitionNodeChange ifTrue: [
							 text := text ++ change sourceDiffText ] ].
					 text ]
				 ifNil: [ '' ]) ]
]
