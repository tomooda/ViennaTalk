Class {
	#name : 'ViennaUnitTestFailureResultItem',
	#superclass : 'ViennaUnitTestResultItem',
	#category : 'ViennaTalk-Browser-Core-Testing',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Testing'
}

{ #category : 'accessing' }
ViennaUnitTestFailureResultItem class >> icon [

	^ self failureIcon
]

{ #category : 'menus' }
ViennaUnitTestFailureResultItem >> buildContextMenu: aSpMenuPresenter for: aViennaRefactoringBrowser [

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
ViennaUnitTestFailureResultItem >> initialize [

	super initialize.
	result := #failure
]
