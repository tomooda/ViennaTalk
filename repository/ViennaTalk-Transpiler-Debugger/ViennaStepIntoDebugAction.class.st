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
