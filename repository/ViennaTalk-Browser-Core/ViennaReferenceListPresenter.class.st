Class {
	#name : 'ViennaReferenceListPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'animation',
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
ViennaReferenceListPresenter >> animation [

	^ animation
]

{ #category : 'accessing' }
ViennaReferenceListPresenter >> animation: aViennaTranspiledAnimation [

	self unsubscribe.
	animation := aViennaTranspiledAnimation.
	animation ifNotNil: [ animation announcer when: ViennaAnimationSpecificationChanged send: #specificationChanged to: self ].
	self specificationChanged
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
		          animation: [ animation ];
		          yourself
]

{ #category : 'initialization' }
ViennaReferenceListPresenter >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter whenClosedDo: [ self unsubscribe ]
]

{ #category : 'initialization' }
ViennaReferenceListPresenter >> release [

	super release.
	self unsubscribe
]

{ #category : 'updating' }
ViennaReferenceListPresenter >> selectedGlobalNameChanged [

	^ self updateSource
]

{ #category : 'accessing' }
ViennaReferenceListPresenter >> specification [

	^ animation ifNotNil: #specificationNode
]

{ #category : 'updating' }
ViennaReferenceListPresenter >> specificationChanged [

	^ self updateTarget
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

{ #category : 'initialization' }
ViennaReferenceListPresenter >> unsubscribe [

	animation ifNotNil: [ animation announcer unsubscribe: self ]
]

{ #category : 'updating' }
ViennaReferenceListPresenter >> updateGlobalNameList [

	| selection items |
	selection := globalNameList selectedItem.
	globalNameList items: (items := self createGlobalNames).
	(items detect: [ :item | item = selection ] ifNone: [ nil ])
		ifNotNil: [ :newSelection | globalNameList selectItem: newSelection ]
		ifNil: [ globalNameList unselectAll ]
]

{ #category : 'updating' }
ViennaReferenceListPresenter >> updateSource [

	globalNameList selectedItem
		ifNotNil: [ :globalName |
				source
					module: globalName moduleIdentifier;
					text: (globalName resolveIn: self specification) tracingHighlightedSource ]
		ifNil: [
				source
					module: nil;
					text: '' ]
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
