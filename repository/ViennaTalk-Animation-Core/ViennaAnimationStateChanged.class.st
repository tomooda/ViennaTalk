Class {
	#name : 'ViennaAnimationStateChanged',
	#superclass : 'Announcement',
	#instVars : [
		'animation'
	],
	#category : 'ViennaTalk-Animation-Core',
	#package : 'ViennaTalk-Animation-Core'
}

{ #category : 'accessing' }
ViennaAnimationStateChanged >> animation [

	^ animation
]

{ #category : 'accessing' }
ViennaAnimationStateChanged >> animation: aViennaAnimation [

	animation := aViennaAnimation
]
