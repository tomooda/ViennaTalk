Class {
	#name : #ViennaDebuggerToolbarCommandTreeBuilder,
	#superclass : #StDebuggerToolbarCommandTreeBuilder,
	#instVars : [
		'specification'
	],
	#category : #'ViennaTalk-Transpiler-Debugger'
}

{ #category : #'accessing - commands classes' }
ViennaDebuggerToolbarCommandTreeBuilder >> executionControlCommandClasses [
	^ {
	StProceedCommand.
	StStepIntoCommand.
	ViennaStepIntoCommand.
	StStepOverCommand.
	ViennaStepOverCommand.
	StStepThroughCommand.
	StRunToSelectionCommand.
	StRestartCommand.
	StReturnValueCommand
	}
]
