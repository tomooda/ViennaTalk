Class {
	#name : #ViennaEngine,
	#superclass : #Object,
	#classVars : [
		'AlwaysUsesViennaServerAsDefault'
	],
	#category : 'ViennaTalk-Engine-Core'
}

{ #category : #settings }
ViennaEngine class >> alwaysUsesViennaServerAsDefault [
	^ AlwaysUsesViennaServerAsDefault ifNil: [ AlwaysUsesViennaServerAsDefault := false ]
]

{ #category : #settings }
ViennaEngine class >> alwaysUsesViennaServerAsDefault: aBoolean [
	^ AlwaysUsesViennaServerAsDefault := aBoolean = true
]

{ #category : #defaults }
ViennaEngine class >> default [
	^ ViennaVDMJ new
]

{ #category : #settings }
ViennaEngine class >> viennaSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder setting: #viennaTalkAlwaysUseServer)
		parent: #ViennaTalkServices;
		target: self;
		getSelector: #alwaysUsesViennaServerAsDefault;
		setSelector: #alwaysUsesViennaServerAsDefault:;
		description: 'If checked, "ViennaEngine default" always chooses the vienna server via HTTP even when a local VDMJ process is available.';
		label: 'Always uses vienna Server via HTTP';
		order: 0.5
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
