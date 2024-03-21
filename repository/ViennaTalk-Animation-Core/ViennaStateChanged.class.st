Class {
	#name : #ViennaStateChanged,
	#superclass : #Announcement,
	#instVars : [
		'animation'
	],
	#category : #'ViennaTalk-Animation-Core'
}

{ #category : #accessing }
ViennaStateChanged >> animation [

	^ animation
]

{ #category : #accessing }
ViennaStateChanged >> animation: aViennaAnimation [

	animation := aViennaAnimation
]
