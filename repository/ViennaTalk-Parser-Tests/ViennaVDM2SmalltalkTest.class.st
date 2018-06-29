Class {
	#name : #ViennaVDM2SmalltalkTest,
	#superclass : #TestCase,
	#traits : 'TViennaVDMBoundVariableCollectorTest + TViennaVDMFreeVariableCollectorTest',
	#classTraits : 'TViennaVDMBoundVariableCollectorTest classTrait + TViennaVDMFreeVariableCollectorTest classTrait',
	#category : 'ViennaTalk-Parser-Tests'
}

{ #category : #'tests-bound variables-interfaces' }
ViennaVDM2SmalltalkTest >> testBoundVariablesExportDefinitionInto [
	| node binds |
	node := ViennaVDMParser new exportDefinition end parse: 'exports types t1; t2; values v1:t3; v2:t4'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExportDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'t1'.
			't2'.
			'v1'.
			't3'.
			'v2'.
			't4'} asSet
]

{ #category : #'tests-bound variables-interfaces' }
ViennaVDM2SmalltalkTest >> testBoundVariablesExportFunctionsSignatureInto [
	| node binds |
	node := ViennaVDMParser new exportFunctionsSignature end parse: 'functions f1[@t1,@t2]:t3->t4; f2[@t5,@t6]:t7->t8'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExportFunctionsSignature'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'f1'.
			't3'.
			't4'.
			'f2'.
			't7'.
			't8'} asSet
]

{ #category : #'tests-bound variables-interfaces' }
ViennaVDM2SmalltalkTest >> testBoundVariablesExportModuleSignatureInto [
	| node binds |
	node := ViennaVDMParser new exportModuleSignature end parse: 'values v1 : t1; types t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExportModuleSignature'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			't1'.
			't2'} asSet
]

{ #category : #'tests-bound variables-interfaces' }
ViennaVDM2SmalltalkTest >> testBoundVariablesExportTypesSignatureInto [
	| node binds |
	node := ViennaVDMParser new exportTypesSignature end parse: 'types t1; t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExportTypesSignature'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'t1'.
			't2'} asSet
]

{ #category : #'tests-bound variables-interfaces' }
ViennaVDM2SmalltalkTest >> testBoundVariablesFunctionExportInto [
	| node binds |
	node := ViennaVDMParser new functionExport end parse: 'f1[@t1,@t2]:t3->t4'.
	self deny: node isPetitFailure.
	self assert: node label = 'FunctionExport'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'f1'.
			't3'.
			't4'} asSet
]
