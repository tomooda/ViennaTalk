"
I am a presenter that renders a markdown with ViennaDoc-like extension that let the user to evaluate VDM-SL expressions and statements.
"
Class {
	#name : 'ViennadownPresenter',
	#superclass : 'MicrodownPresenter',
	#instVars : [
		'transpiledSpecification'
	],
	#category : 'ViennaTalk-Microdown',
	#package : 'ViennaTalk-Microdown'
}

{ #category : 'accessing' }
ViennadownPresenter >> transpiledSpecification [

	^ transpiledSpecification
]

{ #category : 'accessing' }
ViennadownPresenter >> transpiledSpecification: anObject [

	transpiledSpecification := anObject
]
