Class {
	#name : #ViennaFRAMModel,
	#superclass : #FRAMModel,
	#category : #'ViennaTalk-FRAM-Core'
}

{ #category : #examples }
ViennaFRAMModel class >> examplePedestrianCounter [

	| model spec |
	model := ViennaFRAMModel new.
	(model newFunctionNamed: 'observation plan')
		beOrganisational;
		newOutputNamed: 'instructions';
		newOutputNamed: 'observation hours'.
	(model newFunctionNamed: 'go to post and prepare counting')
		beHuman;
		newControlNamed: 'instructions';
		newTimeNamed: 'observation hours';
		newOutputNamed: 'at the post'.
	(model newFunctionNamed: 'find a pedestrian')
		beHuman;
		newControlNamed: 'instructions';
		newTimeNamed: 'observation hours';
		newInputNamed: 'at the post';
		newPreconditionNamed: 'counter is ready';
		newOutputNamed: 'one pedestrian'.
	(model newFunctionNamed: 'report the count')
		beHuman;
		newControlNamed: 'instructions';
		newTimeNamed: 'observation hours';
		newResourceNamed: 'current count'.
	spec := ViennaVDMParser parse: '
	state Count of
	count : nat
	init s == s = mk_Count(0)
	end
	
	operations
	--@FRAM OUTPUT current count
	--@FRAM INPUT one pedestrian
	inc : () ==> nat
	inc() == (count := count + 1; return count);
	
	--@FRAM OUTPUT counter is ready
	--@FRAM INPUT at the post
	reset : () ==> ()
	reset() == count := 0'.
	model
		loadSpec: spec
		newFunctionsDo: [ :f | f color: Color blue ]
		newAspectsDo: [ :a |  ].
	model openInExternalViewer
]

{ #category : #examples }
ViennaFRAMModel class >> examplePedestrianTraffic [

	| model |
	model := ViennaFRAMModel new.
	(model newFunctionNamed: 'observation plan')
		beOrganisational;
		newOutputNamed: 'observation hours'.
	(model newFunctionNamed: 'go to post and prepare counting')
		beHuman;
		newTimeNamed: 'observation hours';
		newOutputNamed: 'at the post'.
	(model newFunctionNamed: 'count pedestrians')
		beHuman;
		newTimeNamed: 'observation hours';
		newInputNamed: 'at the post';
		newOutputNamed: 'current count'.
	(model newFunctionNamed: 'report the count')
		beHuman;
		newTimeNamed: 'observation hours';
		newInputNamed: 'current count'.
	model openInExternalViewer
]

{ #category : #merging }
ViennaFRAMModel >> appendToSpec: aViennaNode [

	self
		appendToSpec: aViennaNode
		newOperationsDo: [ :node |  ]
		newAnnotationsDo: [ :annotation |  ]
]

{ #category : #merging }
ViennaFRAMModel >> appendToSpec: aViennaNode newOperationsDo: functionBlock newAnnotationsDo: aspectBlock [

	| parser |
	parser := ViennaFRAMVDMAnnotationParser new.
	self functionsDo: [ :function | 
		function description trim lines do: [ :line | 
			| operationName |
			operationName := parser parse: line.
			operationName isPetit2Success ifTrue: [ 
				| operationNode |
				operationNode := operationName isString
					                 ifTrue: [ 
					                 self
						                 findOrCreateOperationNamed: operationName
						                 in: aViennaNode ]
					                 ifFalse: [ 
						                 self
							                 findOrCreateOperationNamed:
							                 operationName second
							                 module: operationName first
							                 in: aViennaNode ].
				self
					ensureAnnotation: 'Function'
					name: function name
					in: operationNode.
				function aspectsDo: [ :aspect | 
					self
						ensureAnnotation: aspect aspect
						name: aspect name
						in: operationNode ] ] ] ]
]

{ #category : #private }
ViennaFRAMModel >> createOperationDefinitionNode: aString [

	^ ViennaAccessOperationDefinitionNode
		  access: (ViennaNode label: 'Access')
		  operationDefinition: (ViennaOperationDefinitionNode definition:
				   (ViennaExplicitOperationDefinitionNode
					    identifier: aString
					    type: (ViennaOperationTypeNode
							     argumentType: ViennaUnitTypeNode new
							     returnType: ViennaUnitTypeNode new)
					    parameters: ViennaParametersNode empty
					    operationBody: ViennaOperationBodyNode isNotYetSpecified
					    pre: nil
					    post: nil))
]

{ #category : #private }
ViennaFRAMModel >> ensureAnnotation: aString name: anotherString in: aViennaNode [

	| parser |
	parser := ViennaFRAMAnnotationParser new.
	aViennaNode annotations ifNotNil: [ :annotations | 
		annotations do: [ :annotation | 
			| pair |
			pair := parser parse: annotation.
			pair isPetit2Success ifTrue: [ 
				(pair first = aString and: [ pair second = anotherString ]) 
					ifTrue: [Transcript cr; show: 'skip ', annotation printString. ^ self ] ] ] ].
	aViennaNode addAnnotation: 'FRAM ' , aString , ' ' , anotherString
]

{ #category : #private }
ViennaFRAMModel >> findOrCreateOperationNamed: operationName in: aViennaNode [

	| opNode |
	(aViennaNode isViennaDocumentNode and: [
		 aViennaNode isEmpty or: [
			 aViennaNode first isViennaDefinitionBlockNode ] ]) ifFalse: [
		^ self error: 'Internal error: A flat spec should be given.' ].
	aViennaNode allDescendantsDo: [ :node |
		node isViennaAccessOperationDefinitionNode ifTrue: [
			opNode := node second first.
			(opNode isViennaExplicitOperationDefinitionNode: operationName)
				ifTrue: [ ^ opNode ] ] ].
	opNode := self createOperationDefinitionNode: operationName.
	aViennaNode allDescendantsDo: [ :node |
		node isViennaOperationDefinitionsNode ifTrue: [
			node add: opNode.
			^ opNode ] ].
	aViennaNode isEmpty ifTrue: [
		aViennaNode add: ViennaDefinitionBlockNode empty ].
	aViennaNode first add:
		(ViennaOperationDefinitionNode definition: opNode).
	^ opNode
]

{ #category : #private }
ViennaFRAMModel >> findOrCreateOperationNamed: operationName module: moduleName in: aViennaNode [

	| moduleNode opNode |
	(aViennaNode isViennaDocumentNode and: [
		 aViennaNode size = 0 or: [ aViennaNode first isViennaModuleNode ] ])
		ifFalse: [
		^ self error: 'Internal error: A modular spec should be given.' ].
	moduleNode := aViennaNode moduleNamed: moduleName.
	moduleNode isNil ifTrue: [
		moduleNode := ViennaModuleNode
			              identifier: moduleName
			              interface: (ViennaInterfaceNode
					               importDefinitionList: nil
					               exportDefinition:
						               (ViennaExportDefinitionNode
							                exportModuleSignature:
							                ViennaExportModuleSignatureAllNode new))
			              moduleBody:
			              (ViennaModuleBodyNode withAll:
				               { ViennaDefinitionBlockNode empty }).
		aViennaNode add: moduleNode ].


	moduleNode allDescendantsDo: [ :node |
		node isViennaAccessOperationDefinitionNode ifTrue: [
			opNode := node second first.
			(opNode isViennaExplicitOperationDefinitionNode: operationName)
				ifTrue: [ ^ opNode ] ] ].
	opNode := self createOperationDefinitionNode: operationName.
	moduleNode allDescendantsDo: [ :node |
		node label = 'OperationDefinitions' ifTrue: [
			node add: opNode.
			^ opNode ] ].
	moduleNode third first add:
		(ViennaNode label: 'OperationDefinitions' with: opNode).
	^ opNode
]

{ #category : #merging }
ViennaFRAMModel >> loadSpec: aViennaNode [

	self
		loadSpec: aViennaNode
		newFunctionsDo: [ :f |  ]
		newAspectsDo: [ :a |  ]
]

{ #category : #merging }
ViennaFRAMModel >> loadSpec: aViennaNode newFunctionsDo: functionBlock newAspectsDo: aspectBlock [

	| parser |
	parser := ViennaFRAMAnnotationParser new.
	aViennaNode allDescendantsDo: [ :node |
		node isViennaAccessOperationDefinitionNode ifTrue: [
			node annotations ifNotNil: [ :annotations |
				annotations ifNotEmpty: [
					| operationName framAnnotations functionNames |
					operationName := (node module
						                  ifNotNil: [ :m | m first , '`' ]
						                  ifNil: [ '' ]) , node identifier.
					framAnnotations := annotations
						                   collect: [ :annotation |
						                   parser parse: annotation ]
						                   thenSelect: #isPetit2Success.
					functionNames := (framAnnotations select: [ :pair |
						                  pair first = $f ])
						                 ifNotEmpty: [ :functionAnnotations |
						                 functionAnnotations collect: #second ]
						                 ifEmpty: [ { operationName } ].
					functionNames do: [ :functionName |
						| functionId |
						functionId := self
							              idOfFunctionNamed: functionName
							              ifAbsentNew: [ :f |
								              f beTechnological.
								              functionBlock cull: f ].
						self removeAllAspectsOf: functionId.
						self functionAt: functionId ifPresent: [ :function |
							function description:
								(String cr join:
									 (function description lines reject: [ :line |
										  line trim beginsWith: '@VDM' ])
									 , { ('@VDM ' , operationName) }) ].
						framAnnotations do: [ :annotation |
							| aspect |
							aspect := annotation first.
							aspect = $c ifTrue: [
								aspectBlock cull:
									(self newControlOf: functionId named: annotation second) ].
							aspect = $i ifTrue: [
								aspectBlock cull:
									(self newInputOf: functionId named: annotation second) ].
							aspect = $o ifTrue: [
								aspectBlock cull:
									(self newOutputOf: functionId named: annotation second) ].
							aspect = $p ifTrue: [
								aspectBlock cull:
									(self newPreconditionOf: functionId named: annotation second) ].
							aspect = $r ifTrue: [
								aspectBlock cull:
									(self newResourceOf: functionId named: annotation second) ].
							aspect = $t ifTrue: [
								aspectBlock cull:
									(self newTimeOf: functionId named: annotation second) ] ] ] ] ] ] ]
]
