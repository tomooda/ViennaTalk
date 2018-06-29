Class {
	#name : #ViennaStepIntoDebugAction,
	#superclass : #StepIntoDebugAction,
	#category : 'ViennaTalk-Transpiler-Debugger'
}

{ #category : #registration }
ViennaStepIntoDebugAction class >> actionType [
	<vdmDebuggingAction>
	<vdmContextMenuDebuggingAction>
]

{ #category : #glamour }
ViennaStepIntoDebugAction class >> gtGlobalDebuggingActionFor: aDebugger [
	<gtVdmDebuggingAction>
	
	^ (self forDebugger: aDebugger)
		label: nil
]

{ #category : #glamour }
ViennaStepIntoDebugAction class >> gtStackDebuggingActionFor: aDebugger [
	<gtVdmStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousInto
]

{ #category : #accessing }
ViennaStepIntoDebugAction >> defaultKeyText [

	^ 'E'
]

{ #category : #accessing }
ViennaStepIntoDebugAction >> defaultLabel [

	^ 'VDM Into'
]

{ #category : #accessing }
ViennaStepIntoDebugAction >> defaultOrder [

	^ 25
]

{ #category : #actions }
ViennaStepIntoDebugAction >> executeAction [

	self session vdmStepInto: self currentContext
]

{ #category : #accessing }
ViennaStepIntoDebugAction >> id [

	^ #vdmStepInto
]
