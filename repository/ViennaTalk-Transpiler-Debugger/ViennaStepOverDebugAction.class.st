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
