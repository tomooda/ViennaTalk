Class {
	#name : #ViennaSlicer,
	#superclass : #Object,
	#category : #'ViennaTalk-Slicing-Core'
}

{ #category : #operations }
ViennaSlicer >> call: aViennaApplyNode [

	^ self subclassResponsibility
]

{ #category : #operations }
ViennaSlicer >> read: aViennaNode [

	^ self subclassResponsibility
]

{ #category : #operations }
ViennaSlicer >> write: aViennaNode [

	^ self subclassResponsibility
]
