Class {
	#name : 'ViennaAnimationSpecificationChanged',
	#superclass : 'Announcement',
	#instVars : [
		'animation'
	],
	#category : 'ViennaTalk-Animation-Core',
	#package : 'ViennaTalk-Animation-Core'
}

{ #category : 'accessing' }
ViennaAnimationSpecificationChanged >> animation [

	^ animation
]

{ #category : 'accessing' }
ViennaAnimationSpecificationChanged >> animation: aViennaAnimation [

	animation := aViennaAnimation
]
