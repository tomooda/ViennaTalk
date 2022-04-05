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
		node label = 'AccessOperationDefinition' ifTrue: [ 
			node annotations ifNotNil: [ :annotations | 
				| operationName framAnnotations functionNames |
				operationName := (node module
					                  ifNotNil: [ :m | m first , '`' ]
					                  ifNil: [ '' ]) , node name.
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
								(self newTimeOf: functionId named: annotation second) ] ] ] ] ] ]
]
