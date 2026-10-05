Class {
	#name : 'ViennaReferenceListPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'browser',
		'target',
		'globalNameList',
		'source'
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

{ #category : 'initialization' }
ViennaReferenceListPresenter >> initializePresenters [

	super initializePresenters.
	globalNameList := self newTable
		                  addColumn: (SpStringTableColumn title: 'module' evaluated: #moduleName);
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
ViennaReferenceListPresenter >> target [

	^ target
]

{ #category : 'accessing' }
ViennaReferenceListPresenter >> target: aViennaGlobalName [

	target := aViennaGlobalName.
	self updateGlobalNameList
]

{ #category : 'updating' }
ViennaReferenceListPresenter >> updateGlobalNameList [

	^ self subclassResponsibility
]

{ #category : 'updating' }
ViennaReferenceListPresenter >> updateSource [

	globalNameList selectedItem ifNotNil: [ :globalName |
			source
				module: globalName moduleIdentifier;
				text: (globalName resolveIn: browser specification) tracingSource ]
]
