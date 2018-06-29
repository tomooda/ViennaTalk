Class {
	#name : #ViennaStepOverDebugAction,
	#superclass : #StepOverDebugAction,
	#category : 'ViennaTalk-Transpiler-Debugger'
}

{ #category : #registration }
ViennaStepOverDebugAction class >> actionType [
	<vdmDebuggingAction>
	<vdmContextMenuDebuggingAction>
]

{ #category : #glamour }
ViennaStepOverDebugAction class >> gtGlobalDebuggingActionFor: aDebugger [
	<gtVdmDebuggingAction>
	^ (self forDebugger: aDebugger) label: nil
]

{ #category : #glamour }
ViennaStepOverDebugAction class >> gtStackDebuggingActionFor: aDebugger [
	<gtVdmStackDebuggingAction>
	^ (self forDebugger: aDebugger) icon: GLMUIThemeExtraIcons glamorousOver
]

{ #category : #accessing }
ViennaStepOverDebugAction >> defaultKeyText [

	^ 'o'
]

{ #category : #accessing }
ViennaStepOverDebugAction >> defaultLabel [

	^ 'VDM Over'
]

{ #category : #accessing }
ViennaStepOverDebugAction >> defaultOrder [

	^ 24
]

{ #category : #actions }
ViennaStepOverDebugAction >> executeAction [

	self session vdmStepOver: self currentContext
]

{ #category : #accessing }
ViennaStepOverDebugAction >> id [

	^ #vdmStepOver
]
