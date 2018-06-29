Class {
	#name : #ViennaEngine,
	#superclass : #Object,
	#category : 'ViennaTalk-Engine-Core'
}

{ #category : #defaults }
ViennaEngine class >> default [
	^ ViennaClient default
]

{ #category : #evaluating }
ViennaEngine >> evaluate: expression specification: spec states: states [ 
	^ self evaluate: expression specification: spec states: states vdm10: true rtc: true 
]

{ #category : #evaluating }
ViennaEngine >> evaluate: expression specification: spec states: states module: module [
	^ self evaluate: expression specification: spec states: states module: module vdm10: true rtc: true 
]

{ #category : #evaluating }
ViennaEngine >> evaluate: expression specification: specification states: states module: module vdm10: vdm10 rtc: rtc [
	^ self subclassResponsibility
]

{ #category : #evaluating }
ViennaEngine >> evaluate: expression specification: specification states: states vdm10: vdm10 rtc: rtc [
	^ self
		evaluate: expression
		specification: specification
		states: states
		module: 'DEFAULT'
		vdm10: vdm10
		rtc: rtc
]
