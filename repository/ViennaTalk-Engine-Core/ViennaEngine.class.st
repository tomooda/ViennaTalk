Class {
	#name : 'ViennaEngine',
	#superclass : 'Object',
	#classVars : [
		'AlwaysUsesViennaServerAsDefault',
		'DefaultEngineType'
	],
	#category : 'ViennaTalk-Engine-Core',
	#package : 'ViennaTalk-Engine-Core'
}

{ #category : 'settings' }
ViennaEngine class >> alwaysUsesViennaServerAsDefault [

	^ ViennaVDMJ isSupportedEnvironment not or: [ 
		  AlwaysUsesViennaServerAsDefault ifNil: [ 
			  AlwaysUsesViennaServerAsDefault := false ] ]
]

{ #category : 'settings' }
ViennaEngine class >> alwaysUsesViennaServerAsDefault: aBoolean [
	^ AlwaysUsesViennaServerAsDefault := aBoolean = true
]

{ #category : 'defaults' }
ViennaEngine class >> default [

	^ (self forType: self defaultEngineType) ifNotNil: #default
]

{ #category : 'settings' }
ViennaEngine class >> defaultEngineType [

	^ DefaultEngineType ifNil: [ self engineTypes first ]
]

{ #category : 'settings' }
ViennaEngine class >> defaultEngineType: aSymbol [

	^ DefaultEngineType := aSymbol
]

{ #category : 'accessing' }
ViennaEngine class >> engineType [

	^ self subclassResponsibility
]

{ #category : 'defaults' }
ViennaEngine class >> engineTypes [

	^ ((self allSubclasses select: [ :class | class priority > 0 ])
		   sorted: #priority descending) collect: #engineType
]

{ #category : 'accessing' }
ViennaEngine class >> forType: aSymbol [

	self allSubclassesDo: [ :class |
		class engineType = aSymbol ifTrue: [ ^ class ] ]
]

{ #category : 'accessing' }
ViennaEngine class >> priority [

	^ self subclassResponsibility
]

{ #category : 'settings' }
ViennaEngine class >> viennaSettingsOn: aBuilder [

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
ViennaEngine >> animation [

	^ ViennaAnimation on: self
]

{ #category : 'accessing' }
ViennaEngine >> close [
	^ self subclassResponsibility
]

{ #category : 'evaluating' }
ViennaEngine >> evaluate: expression specification: spec states: states [ 
	^ self evaluate: expression specification: spec states: states vdm10: true rtc: true 
]

{ #category : 'evaluating' }
ViennaEngine >> evaluate: expression specification: spec states: states module: module [

	^ self subclassResponsibility
]
