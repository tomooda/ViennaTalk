Class {
	#name : #ViennaStepIntoCommand,
	#superclass : #StDebuggerCommand,
	#category : #'ViennaTalk-Transpiler-Debugger'
}

{ #category : #'accessing - defaults' }
ViennaStepIntoCommand class >> defaultDescription [

	^ 'Step in the highlighted expression/statement, i.e. follow the function all, taking debugger control in the callee function.'
]

{ #category : #initialization }
ViennaStepIntoCommand class >> defaultIconName [

	^ #debuggerStepInto
]

{ #category : #'accessing - defaults' }
ViennaStepIntoCommand class >> defaultName [
	<toolbarDebugCommand: 21>
	
	^ 'VDM Into'
]

{ #category : #initialization }
ViennaStepIntoCommand class >> defaultShortcut [

	^ PharoShortcuts current stepIntoShortcut alt
]

{ #category : #execution }
ViennaStepIntoCommand >> execute [
	self debugger vdmStepInto
]
