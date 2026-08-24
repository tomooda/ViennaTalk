Class {
	#name : 'ViennaAnimationEvaluated',
	#superclass : 'Announcement',
	#instVars : [
		'animation'
	],
	#category : 'ViennaTalk-Animation-Core',
	#package : 'ViennaTalk-Animation-Core'
}

{ #category : 'accessing' }
ViennaAnimationEvaluated >> animation [

	^ animation
]

{ #category : 'accessing' }
ViennaAnimationEvaluated >> animation: aViennaAnimation [

	animation := aViennaAnimation
]
