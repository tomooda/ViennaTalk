Class {
	#name : 'ViennaUnitTestErrorResultItem',
	#superclass : 'ViennaUnitTestResultItem',
	#category : 'ViennaTalk-Browser-Core-Testing',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Testing'
}

{ #category : 'accessing' }
ViennaUnitTestErrorResultItem class >> icon [

	^ self errorIcon
]

{ #category : 'menus' }
ViennaUnitTestErrorResultItem >> buildContextMenu: aSpMenuPresenter for: aViennaRefactoringBrowser [

	super
		buildContextMenu: aSpMenuPresenter
		for: aViennaRefactoringBrowser.
	exception
		ifNotNil: [
			aSpMenuPresenter addGroup: [ :group |
				group addItem: [ :item |
					item
						name: 'Debug';
						action: [ exception debug ] ] ] ]
		ifNil: [
			aSpMenuPresenter addGroup: [ :group |
				group addItem: [ :item |
					item
						name: 'Debug it with transpiler';
						action: [ aViennaRefactoringBrowser debugTestResultItem: self ] ] ] ]
]

{ #category : 'initialization' }
ViennaUnitTestErrorResultItem >> initialize [

	super initialize.
	result := #error
]
