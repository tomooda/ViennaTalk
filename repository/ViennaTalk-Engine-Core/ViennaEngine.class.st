Class {
	#name : #ViennaEngine,
	#superclass : #Object,
	#category : 'ViennaTalk-Engine-Core'
}

{ #category : #evaluating }
ViennaEngine >> evaluate: expression specification: spec states: states [ 
	^ self evaluate: expression specification: spec states: states vdm10: true rtc: true 
]

{ #category : #evaluating }
ViennaEngine >> evaluate: expression specification: specification states: states vdm10: vdm10 rtc: rtc [
	^ self subclassResponsibility
]