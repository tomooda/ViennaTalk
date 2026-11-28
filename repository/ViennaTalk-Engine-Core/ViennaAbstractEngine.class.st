Class {
	#name : 'ViennaAbstractEngine',
	#superclass : 'Object',
	#classVars : [
		'DefaultEngineType'
	],
	#category : 'ViennaTalk-Engine-Core',
	#package : 'ViennaTalk-Engine-Core'
}

{ #category : 'defaults' }
ViennaAbstractEngine class >> default [

	^ (self forType: self defaultEngineType) ifNotNil: #default
]

{ #category : 'settings' }
ViennaAbstractEngine class >> defaultEngineType [

	^ DefaultEngineType ifNil: [ self engineTypes first ]
]

{ #category : 'settings' }
ViennaAbstractEngine class >> defaultEngineType: aSymbol [

	^ DefaultEngineType := aSymbol
]

{ #category : 'accessing' }
ViennaAbstractEngine class >> engineType [

	^ self subclassResponsibility
]

{ #category : 'defaults' }
ViennaAbstractEngine class >> engineTypes [

	^ ((self allSubclasses select: [ :class | class priority > 0 ])
		   sorted: #priority descending) collect: #engineType
]

{ #category : 'accessing' }
ViennaAbstractEngine class >> forType: aSymbol [

	self allSubclassesDo: [ :class |
		class engineType = aSymbol ifTrue: [ ^ class ] ]
]

{ #category : 'accessing' }
ViennaAbstractEngine class >> priority [

	^ self subclassResponsibility
]

{ #category : 'settings' }
ViennaAbstractEngine class >> viennaSettingsOn: aBuilder [

	<systemsettings>
	(aBuilder pickOne: #defaultEngineType)
		parent: #ViennaTalkEngine;
		label: 'default engine';
		domainValues: self engineTypes;
		default: self defaultEngineType;
		description: 'Select the default engine to run VDM-SL specs.';
		target: self;
		order: 0.2
]

{ #category : 'accessing' }
ViennaAbstractEngine >> animation [

	^ ViennaAnimation new
]

{ #category : 'accessing' }
ViennaAbstractEngine >> close [
	^ self subclassResponsibility
]

{ #category : 'utilities' }
ViennaAbstractEngine >> diagram: aString fromResult: anArray ifPresent: presentBlock ifAbsent: absentBlock [

	^ anArray size >= 5
		  ifTrue: [ anArray fifth at: aString ifPresent: presentBlock ifAbsent: absentBlock ]
		  ifFalse: [ absentBlock value ]
]

{ #category : 'evaluating' }
ViennaAbstractEngine >> evaluate: expression specification: spec states: states [

	^ self
		  evaluate: expression
		  specification: spec
		  states: states
		  module: 'DEFAULT'
]

{ #category : 'evaluating' }
ViennaAbstractEngine >> evaluate: expression specification: spec states: states module: module [

	^ self subclassResponsibility
]

{ #category : 'utilities' }
ViennaAbstractEngine >> messageFromResult: anArray [

	^ anArray third
]

{ #category : 'utilities' }
ViennaAbstractEngine >> poststatesFromResult: anArray [

	^ anArray second
]

{ #category : 'utilities' }
ViennaAbstractEngine >> prestatesFromResult: anArray [

	^ anArray fourth
]

{ #category : 'utilities' }
ViennaAbstractEngine >> valueFromResult: anArray [

	^ anArray first
]
