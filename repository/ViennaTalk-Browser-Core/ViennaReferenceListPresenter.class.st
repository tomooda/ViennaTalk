Class {
	#name : 'ViennaReferenceListPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'browser',
		'globalNameList',
		'source',
		'target'
	],
	#category : 'ViennaTalk-Browser-Core-Browsers',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Browsers'
}

{ #category : 'testing' }
ViennaReferenceListPresenter class >> isAbstract [

	^ self == ViennaReferenceListPresenter
]

{ #category : 'accessing' }
ViennaReferenceListPresenter >> browser: aViennaRefactoringBrowser [

	browser := aViennaRefactoringBrowser.
	self updateGlobalNameList
]

{ #category : 'testing' }
ViennaReferenceListPresenter >> check: aViennaNode [

	^ self subclassResponsibility
]

{ #category : 'private' }
ViennaReferenceListPresenter >> createGlobalNames [

	| last |
	last := nil.
	^ Array streamContents: [ :stream |
			  target ifNotNil: [
					  self specification ifNotNil: [ :specification |
							  specification allDescendantsSuchThat: [ :node | self check: node ] do: [ :node |
									  node topLevelDefinition ifNotNil: [ :def |
											  def globalNamesDo: [ :globalName |
													  last ~= globalName ifTrue: [
															  stream nextPut: globalName.
															  last := globalName ] ] ] ] ] ] ]
]

{ #category : 'layout' }
ViennaReferenceListPresenter >> defaultLayout [

	<spec>
	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.3;
		  add: globalNameList;
		  add: source;
		  yourself
]

{ #category : 'initialization' }
ViennaReferenceListPresenter >> initializePresenters [

	super initializePresenters.
	globalNameList := self newTable
		                  addColumn: (SpStringTableColumn title: 'module' evaluated: #moduleIdentifier);
		                  addColumn: (SpStringTableColumn title: 'identifier' evaluated: #identifier);
		                  whenSelectedItemChangedDo: [ self selectedGlobalNameChanged ];
		                  yourself.
	source := self newVDMSource
		          animation: [ browser animation ];
		          yourself
]

{ #category : 'updating' }
ViennaReferenceListPresenter >> selectedGlobalNameChanged [

	^ self updateSource
]

{ #category : 'accessing' }
ViennaReferenceListPresenter >> specification [

	^ browser ifNotNil: #specification
]

{ #category : 'accessing' }
ViennaReferenceListPresenter >> target [

	^ target
]

{ #category : 'accessing' }
ViennaReferenceListPresenter >> target: aViennaNode [

	target := aViennaNode.
	self updateGlobalNameList
]

{ #category : 'updating' }
ViennaReferenceListPresenter >> updateGlobalNameList [

	globalNameList items: self createGlobalNames
]

{ #category : 'updating' }
ViennaReferenceListPresenter >> updateSource [

	globalNameList selectedItem ifNotNil: [ :globalName |
			source
				module: globalName moduleIdentifier;
				text: (globalName resolveIn: browser specification) tracingHighlightedSource ]
]

{ #category : 'updating' }
ViennaReferenceListPresenter >> updateTarget [

	target ifNotNil: [
			self specification ifNotNil: [ :specification |
					target document ifNotNil: [ :oldSpecification |
							oldSpecification ~~ specification ifTrue: [
									| newTarget |
									newTarget := specification atPath: target path.
									target := target = newTarget
										          ifTrue: [ newTarget ]
										          ifFalse: [ nil ] ] ] ] ].
	self updateGlobalNameList
]
