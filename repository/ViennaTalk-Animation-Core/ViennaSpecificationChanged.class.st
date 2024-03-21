Class {
	#name : #ViennaSpecificationChanged,
	#superclass : #Announcement,
	#instVars : [
		'animation'
	],
	#category : #'ViennaTalk-Animation-Core'
}

{ #category : #accessing }
ViennaSpecificationChanged >> animation [

	^ animation
]

{ #category : #accessing }
ViennaSpecificationChanged >> animation: aViennaAnimation [

	animation := aViennaAnimation
]
