Class {
	#name : 'ViennaUnitTestFailureResultItem',
	#superclass : 'ViennaUnitTestResultItem',
	#instVars : [
		'exception'
	],
	#category : 'ViennaTalk-Browser-Core-TestRunner',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'TestRunner'
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

{ #category : 'accessing' }
ViennaUnitTestFailureResultItem >> exception [

	^ exception
]

{ #category : 'accessing' }
ViennaUnitTestFailureResultItem >> exception: anExpcetion [

	exception := anExpcetion freeze
]

{ #category : 'testing' }
ViennaUnitTestFailureResultItem >> isFailure [
	^ true
]

{ #category : 'accessing' }
ViennaUnitTestFailureResultItem >> sortingOrder [
	^ 1
]
