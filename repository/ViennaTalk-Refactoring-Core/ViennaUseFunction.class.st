Class {
	#name : 'ViennaUseFunction',
	#superclass : 'ViennaUse',
	#instVars : [
		'functionsAndBinds',
		'functionsAndBindsIndex'
	],
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaUseFunction >> check [

	^ self functionsAndBinds notEmpty
]

{ #category : 'operations' }
ViennaUseFunction >> execute [

	| binds args |
	binds := (self functionsAndBinds at: self functionsAndBindsIndex)
		         value.
	args := self definitionNode parametersList first asArray collect: [
		        :node | self expressionFromPattern: node bindings: binds ].
	^ self replaceNode: ast with: (ViennaApplyNode
			   expression:
			   (ViennaLocalNameNode identifier: self definitionNode identifier)
			   argumentExpressionList: (ViennaExpressionListNode withAll: args))
]

{ #category : 'enumerating' }
ViennaUseFunction >> explicitFunctionsDo: aBlock [

	self ast parentsDo: [ :node |
		node isViennaLetNode ifTrue: [
			node localDefinitionsDo: [ :localDefinition |
				(localDefinition isFunctionDefinition and: [
					 localDefinition expression notNil ]) ifTrue: [
					aBlock value: localDefinition ] ] ].
		node isViennaModuleNode ifTrue: [
			node sectionsDo: [ :section |
				section isViennaFunctionDefinitionsNode ifTrue: [
					section do: [ :definition |
						definition expression ifNotNil: [ aBlock value: definition ] ] ] ] ] ]
]

{ #category : 'accessing' }
ViennaUseFunction >> findDefinitionNode [

	^ self functionsAndBinds
		  ifNotEmpty: [
			  self functionsAndBindsIndex ifNotNil: [ :i |
				  (functionsAndBinds at: i) key ] ]
		  ifEmpty: [ nil ]
]

{ #category : 'accessing' }
ViennaUseFunction >> findFunctionsAndBinds [

	ast ifNil: [ ^ Array new ].
	ast isViennaExpressionNode ifFalse: [ ^ Array new ].
	^ Array streamContents: [ :stream |
		  self explicitFunctionsDo: [ :function |
			  | binds |
			  (function pre isNil and: [
				   function expression ~~ ast and: [
					   binds := (function parametersList uniqueBoundIdentifiers
						             collect: [ :string | string -> nil ]) asDictionary.
					   self match: function expression with: ast bindings: binds ] ])
				  ifTrue: [ stream nextPut: function -> binds ] ] ]
]

{ #category : 'accessing' }
ViennaUseFunction >> findFunctionsAndBindsIndex [

	^ UIManager default
		  chooseFrom:
		  ((functionsAndBinds collect: #key) collect: #identifier)
		  values: (1 to: functionsAndBinds size)
		  lines: #(  )
		  message: 'Select a function to use'
		  title: 'Use function'
]

{ #category : 'accessing' }
ViennaUseFunction >> functionsAndBinds [ 
	^ functionsAndBinds ifNil: [ functionsAndBinds := self findFunctionsAndBinds ]
]

{ #category : 'accessing' }
ViennaUseFunction >> functionsAndBindsIndex [

	^ functionsAndBindsIndex ifNil: [
		  functionsAndBindsIndex := self findFunctionsAndBindsIndex ]
]

{ #category : 'accessing' }
ViennaUseFunction >> functionsAndBindsIndex: anInteger [

	functionsAndBindsIndex := anInteger
]

{ #category : 'accessing' }
ViennaUseFunction >> name [

	^ 'Use function application for '
	  , (self shortDescription: self ast source) asText allBold
]
