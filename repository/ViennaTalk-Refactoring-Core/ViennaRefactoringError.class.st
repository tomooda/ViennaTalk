Class {
	#name : 'ViennaRefactoringError',
	#superclass : 'Error',
	#instVars : [
		'refactoring',
		'node'
	],
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'exceptioninstantiator' }
ViennaRefactoringError class >> refactoring: aViennaRefactoring node: aViennaNode [
	^ self new
		refactoring: aViennaRefactoring;
		node: aViennaNode;
		yourself
]

{ #category : 'accessing' }
ViennaRefactoringError >> node [
	^ node
]

{ #category : 'accessing' }
ViennaRefactoringError >> node: aViennaNode [
	node := aViennaNode
]

{ #category : 'accessing' }
ViennaRefactoringError >> refactoring [
	^ refactoring
]

{ #category : 'accessing' }
ViennaRefactoringError >> refactoring: aViennaRefactoring [
	refactoring := aViennaRefactoring
]
