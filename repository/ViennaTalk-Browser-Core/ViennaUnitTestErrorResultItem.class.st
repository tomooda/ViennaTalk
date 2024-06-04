Class {
	#name : 'ViennaUnitTestErrorResultItem',
	#superclass : 'ViennaUnitTestResultItem',
	#instVars : [
		'exception'
	],
	#category : 'ViennaTalk-Browser-Core-TestRunner',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'TestRunner'
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

{ #category : 'accessing' }
ViennaUnitTestErrorResultItem >> exception [

	^ exception
]

{ #category : 'accessing' }
ViennaUnitTestErrorResultItem >> exception: anExpcetion [

	exception := anExpcetion freeze
]

{ #category : 'testing' }
ViennaUnitTestErrorResultItem >> isError [
	^ true
]

{ #category : 'accessing' }
ViennaUnitTestErrorResultItem >> sortingOrder [
	^ 0
]
