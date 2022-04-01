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
		newOutputNamed: 'observation hours';
		newOutputNamed: 'observation post'.
	(model newFunctionNamed: 'go to post and prepare counting')
		beHuman;
		newControlNamed: 'observation post';
		newTimeNamed: 'observation hours';
		newOutputNamed: 'at the post'.
	(model newFunctionNamed: 'find a pedestrian')
		beHuman;
		newControlNamed: 'observation post';
		newTimeNamed: 'observation hours';
		newInputNamed: 'at the post';
		newPreconditionNamed: 'counter is ready';
		newOutputNamed: 'one pedestrian'.
	(model newFunctionNamed: 'report the count')
		beHuman;
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
	model loadSpec: spec.
	model openInExternalViewer
]

{ #category : #merging }
ViennaFRAMModel >> loadSpec: aViennaNode [

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
						              ifAbsentNew: [ :f | f beTechnological ].
					framAnnotations do: [ :annotation | 
						| aspect |
						aspect := annotation first.
						aspect = $c ifTrue: [ 
							self newControlOf: functionId named: annotation second ].
						aspect = $i ifTrue: [ 
							self newInputOf: functionId named: annotation second ].
						aspect = $o ifTrue: [ 
							self newOutputOf: functionId named: annotation second ].
						aspect = $p ifTrue: [ 
							self newPreconditionOf: functionId named: annotation second ].
						aspect = $r ifTrue: [ 
							self newResourceOf: functionId named: annotation second ].
						aspect = $t ifTrue: [ 
							self newTimeOf: functionId named: annotation second ] ] ] ] ] ]
]
