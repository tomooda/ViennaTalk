Class {
	#name : 'ViennaStepOverCommand',
	#superclass : 'StDebuggerCommand',
	#category : 'ViennaTalk-Transpiler-Debugger',
	#package : 'ViennaTalk-Transpiler-Debugger'
}

{ #category : 'accessing - defaults' }
ViennaStepOverCommand class >> defaultDescription [

	^ 'Step over the highlighted expression/statement.'
]

{ #category : 'initialization' }
ViennaStepOverCommand class >> defaultIconName [

	^ #debuggerStepOver
]

{ #category : 'accessing - defaults' }
ViennaStepOverCommand class >> defaultName [
	<toolbarDebugCommand: 41>
	
	^ 'VDM Over'
]

{ #category : 'initialization' }
ViennaStepOverCommand class >> defaultShortcut [

	^ PharoShortcuts current stepOverShortcut alt
]

{ #category : 'execution' }
ViennaStepOverCommand >> execute [
	self context vdmStepOver
]
