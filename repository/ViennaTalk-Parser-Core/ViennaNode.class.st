Class {
	#name : #ViennaNode,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'label',
		'parent',
		'start',
		'end'
	],
	#classVars : [
		'ExpressionLabels',
		'PatternBindLabels',
		'StatementLabels',
		'TypeLabels'
	],
	#category : #'ViennaTalk-Parser-Core'
}

{ #category : #accessing }
ViennaNode class >> expressionLabels [
	^ ExpressionLabels
		ifNil:
			[ ExpressionLabels := #('ActExpression' 'ActiveExpression' 'And' 'Apply' 'ArithmeticAbs' 'ArithmeticDivide' 'ArithmeticIntegerDivision' 'ArithmeticMinus' 'ArithmeticMod' 'ArithmeticMultiplication' 'ArithmeticPlus' 'ArithmeticRem' 'CasesExpression' 'Composition' 'DefExpression' 'DistributedMapMerge' 'DistributedSequenceConcatenation' 'DistributedSetIntersection' 'DistributedSetUnion' 'Equal' 'Exists1Expression' 'ExistsExpression' 'FieldSelect' 'FinExpression' 'FinitePowerSet' 'Floor' 'ForallExpression' 'FunctionTypeInstantiation' 'GlobalName' 'GreaterThan' 'GreaterThanOrEqual' 'IfExpression' 'Imply' 'InSet' 'IotaExpression' 'IsBasicExpression' 'IsNameExpression' 'IsofbaseclassExpression' 'IsofclassExpression' 'Iterate' 'LambdaExpression' 'LessThan' 'LessThanOrEqual' 'LetBeExpression' 'LetExpression' 'LocalName' 'LogicalEquivalence' 'MapComprehension' 'MapDomain' 'MapDomainRestrictedBy' 'MapDomainRestrictedTo' 'MapEnumeration' 'MapInverse' 'MapMerge' 'MapOrSequenceModify' 'MapRange' 'MapRangeRestrictedBy' 'MapRangeRestrictedTo' 'NarrowExpression' 'NewExpression' 'Not' 'NotEqual' 'NotInSet' 'OldName' 'Or' 'PreconditionExpression' 'ProperSubset' 'RecordConstructor' 'RecordModifier' 'ReqExpression' 'ResultExpression' 'SamebaseclassExpression' 'SameclassExpression' 'SelfExpression' 'SequenceComprehension' 'SequenceConcatenate' 'SequenceElements' 'SequenceEnumeration' 'SequenceHead' 'SequenceIndices' 'SequenceLength' 'SequenceReverse' 'SequenceTail' 'SetCardinality' 'SetComprehension' 'SetDifference' 'SetEnumeration' 'SetIntersection' 'SetRangeExpression' 'SetUnion' 'Subsequence' 'Subset' 'SymbolicLiteral' 'ThreadidExpression' 'TimeExpression' 'TokenConstructor' 'TupleConstructor' 'TupleSelect' 'TypeJudgement' 'UnaryMinus' 'UnaryPlus' 'UndefinedExpression' 'WaitingExpression')
				asSet ]
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString [
	^ (self new: 0)
		setLabel: aString;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 [
	^ (self new: 0)
		setLabel: aString;
		start: anInteger1 end: anInteger2;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 with: aViennaNode [
	^ (self new: 1)
		setLabel: aString;
		at: 1 put: aViennaNode;
		start: anInteger1 end: anInteger2;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 with: aViennaNode1 with: aViennaNode2 [
	^ (self new: 2)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		start: anInteger1 end: anInteger2;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 [
	^ (self new: 3)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		at: 3 put: aViennaNode3;
		start: anInteger1 end: anInteger2;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 withAll: anArray [
	| node |
	node := self new: anArray size.
	node setLabel: aString.
	1 to: anArray size do: [ :index | node at: index put: (anArray at: index) ].
	node start: anInteger1 end: anInteger2.
	^ node
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode [
	^ (self new: 1)
		setLabel: aString;
		at: 1 put: aViennaNode;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 [
	^ (self new: 2)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 [
	^ (self new: 3)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		at: 3 put: aViennaNode3;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 with: aViennaNode4 [
	^ (self new: 4)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		at: 3 put: aViennaNode3;
		at: 4 put: aViennaNode4;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 with: aViennaNode4 with: aViennaNode5 [
	^ (self new: 5)
		setLabel: aString;
		at: 1 put: aViennaNode1;
		at: 2 put: aViennaNode2;
		at: 3 put: aViennaNode3;
		at: 4 put: aViennaNode4;
		at: 5 put: aViennaNode5;
		yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString withAll: anArray [
	| node |
	node := self new: anArray size.
	node setLabel: aString.
	1 to: anArray size do: [ :index | node at: index put: (anArray at: index) ].
	^ node
]

{ #category : #accessing }
ViennaNode class >> patternBindLabels [
	^ PatternBindLabels
		ifNil:
			[ PatternBindLabels := #('BindList' 'FieldPattern' 'FieldPatternList' 'MapEnumerationPattern' 'MapMunionPattern' 'MapletPattern' 'MatchValue' 'MultipleSeqBind' 'MultipleSetBind' 'MultipleTypeBind' 'ObjectPattern' 'PatternIdentifier' 'PatternList' 'RecordPattern' 'SeqBind' 'SeqConcPattern' 'SeqEnumPattern' 'SetBind' 'SetEnumPattern' 'SetUnionPattern' 'TuplePattern' 'PatternList' 'TypeBind' 'TypeBindList')
				asSet ]
]

{ #category : #accessing }
ViennaNode class >> statementLabels [
	^ StatementLabels
		ifNil:
			[ StatementLabels := #('AlwaysStatement' 'AssignStatement' 'AssignmentDefinition' 'BlockStatement' 'CallStatement' 'CasesStatement' 'DclStatement' 'DefStatement' 'ErrorStatement' 'ExitStatement' 'IdentityStatement' 'IfStatement' 'IndexForLoop' 'LetBeStatement' 'LetStatement' 'MultipleAssignStatement' 'NondeterministicStatement' 'ReturnStatement' 'SequenceForLoop' 'SetForLoop' 'TixeStatement' 'TrapStatement' 'WhileLoop')
				asSet ]
]

{ #category : #accessing }
ViennaNode class >> typeLabels [
	^ TypeLabels
		ifNil:
			[ TypeLabels := #('BasicType' 'CompositeType' 'InmapType' 'MapType' 'OptionalType' 'PartialFunctionType' 'ProductType' 'QuoteType' 'Seq1Type' 'SeqType' 'Set1Type' 'SetType' 'TotalFunctionType' 'TypeName' 'UnionType' 'UnitType')
				asSet ]
]

{ #category : #'adding/removing' }
ViennaNode >> add: anObject [
	| array |
	array := self asArray copyWith: anObject.
	self
		become:
			((self class new: array size)
				setLabel: label;
				parent: parent;
				start: start end: end;
				yourself).
	1 to: array size do: [ :index | self at: index put: (array at: index) ].
	^ anObject
]

{ #category : #'adding/removing' }
ViennaNode >> addAll: aCollection [
	| array |
	array := self asArray , aCollection.
	self
		become:
			((self class new: array size)
				setLabel: label;
				parent: parent;
				start: start end: end;
				yourself).
	1 to: array size do: [ :index | self at: index put: (array at: index) ].
	^ aCollection
]

{ #category : #enumerating }
ViennaNode >> allDescendantsDo: aBlock [
	aBlock value: self.
	self
		do: [ :node | 
			node isViennaNode
				ifTrue: [ node allDescendantsDo: aBlock ] ]
]

{ #category : #accessing }
ViennaNode >> allParents [
	^ Array
		streamContents: [ :stream | 
			| node |
			node := parent.
			[ node notNil ]
				whileTrue: [ stream nextPut: node.
					node := node parent ] ]
]

{ #category : #enumerating }
ViennaNode >> allSatisfy: aBlock [
	self
		do: [ :node | 
			(aBlock value: node)
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #enumerating }
ViennaNode >> anySatisfy: aBlockClosure [
	self
		do: [ :child | 
			(aBlockClosure value: child)
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'accessing-definitions' }
ViennaNode >> asAccessDefinition [
	label = 'ValueDefinition'
		ifTrue: [ ^ ViennaNode
				label: 'AccessValueDefinition'
				with: (ViennaNode label: 'Access')
				with: self ].
	(#('TypeDefinition' 'RecordTypeDefinition') includes: label)
		ifTrue: [ ^ ViennaNode
				label: 'AccessTypeDefinition'
				with: (ViennaNode label: 'Access')
				with: self ].
	label = 'FunctionDefinition'
		ifTrue: [ ^ ViennaNode
				label: 'AccessFunctionDefinition'
				with: (ViennaNode label: 'Access')
				with: self ].
	(#('ExplicitFunctionDefinition' 'ImplicitFunctionDefinition')
		includes: label)
		ifTrue: [ ^ (ViennaNode label: 'FunctionDefinition' with: self)
				asAccessDefinition ].
	label = 'OperationDefinition'
		ifTrue: [ ^ ViennaNode
				label: 'AccessOperationDefinition'
				with: (ViennaNode label: 'Access')
				with: self ].
	(#('ExplicitOperationDefinition' 'ImplicitOperationDefinition')
		includes: label)
		ifTrue: [ ^ (ViennaNode label: 'OperationDefinition' with: self)
				asAccessDefinition ]
]

{ #category : #converting }
ViennaNode >> asArray [
	| array |
	array := Array new: self size.
	1 to: self size do: [ :i | array at: i put: (self at: i) ].
	^ array
]

{ #category : #converting }
ViennaNode >> asArrayFrom: anInteger [
	^ self asArrayFrom: anInteger to: self size
]

{ #category : #converting }
ViennaNode >> asArrayFrom: anInteger1 to: anInteger2 [
	^ (anInteger1 to: anInteger2) collect: [ :i | self at: i ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> asExport [
	(#('TypeDefinition' 'RecordTypeDefinition') includes: label)
		ifTrue: [ ^ ViennaNode
				label: 'TypeStructExport'
				with: (ViennaNode label: 'LocalName' with: self first) ].
	(#('ValueDefinition') includes: label)
		ifTrue: [ ^ ViennaNode
				label: 'ValueExport'
				with:
					(ViennaNode
						label: 'NameList'
						withAll:
							(self first patternIdentifiers
								collect: [ :node | ViennaNode label: 'LocalName' with: node first ]))
				with:
					(self first label = 'PatternIdentifier'
						ifTrue: [ self second ifNotNil: #copyFragment ]
						ifFalse: [ nil ])
				with: nil ].
	(#('ImplicitFunctionDefinition' 'ExplicitFunctionDefinition')
		includes: label)
		ifTrue: [ ^ ViennaNode
				label: 'FunctionExport'
				with:
					(ViennaNode
						label: 'NameList'
						with: (ViennaNode label: 'LocalName' with: self first))
				with: (self second ifNotNil: #copyFragment)
				with:
					(label = 'ExplicitFunctionDefinition'
						ifTrue: [ self third ifNotNil: #copyFragment ]
						ifFalse: [ ViennaNode
								label: 'PartialFunctionType'
								with: self third first pairListToType
								with: self fourth pairListToType ]) ].
	(#('ExplicitOperationDefinition' 'ImplicitOperationDefinition')
		includes: label)
		ifTrue: [ ^ ViennaNode
				label: 'OperationExport'
				with:
					(ViennaNode
						label: 'NameList'
						with: (ViennaNode label: 'LocalName' with: self first))
				with:
					(label = 'ExplicitOperationDefinition'
						ifTrue: [ self second ifNotNil: #copyFragment ]
						ifFalse: [ ViennaNode
								label: 'OperationType'
								with: self second first pairListToType
								with: self third pairListToType ]) ].
	^ nil
]

{ #category : #'accessing-definitions' }
ViennaNode >> asExportSignature [
	self asExport
		ifNotNil: [ :export | 
			(export label = 'TypeNameExport'
				or: [ export label = 'TypeStructExport' ])
				ifTrue: [ ^ ViennaNode label: 'ExportTypesSignature' with: export ].
			export label = 'ValueExport'
				ifTrue: [ ^ ViennaNode label: 'ExportValuesSignature' with: export ].
			export label = 'FunctionExport'
				ifTrue: [ ^ ViennaNode label: 'ExportFunctionsSignature' with: export ].
			export label = 'OperationExport'
				ifTrue: [ ^ ViennaNode label: 'ExportOperationsSignature' with: export ] ].
	^ nil
]

{ #category : #'accessing-definitions' }
ViennaNode >> asGlobalName [
	label = 'GlobalName'
		ifTrue: [ ^ self ].
	(self definitionOfLocalName: self name)
		ifNotNil: [ :defNode | 
			(#('ExplicitFunctionDefinition' 'ImplicitFunctionDefinition' 'ExplicitOperationDefinition' 'ImplicitOperationDefinition' 'TypeDefinition' 'RecordTypeDefinition')
				includes: defNode label)
				ifTrue: [ ^ (ViennaNode
						label: 'GlobalName'
						with: defNode module name
						with: defNode name)
						parent: parent;
						yourself ].
			defNode bindHolderNode
				ifNotNil: [ :bindNode | 
					bindNode label = 'ValueDefinition'
						ifTrue: [ ^ (ViennaNode
								label: 'GlobalName'
								with: bindNode module name
								with: defNode name)
								parent: parent;
								yourself ] ].
			(#('TypeImport' 'ValueImport' 'FunctionImport' 'OperationImport')
				includes: defNode label)
				ifTrue: [ ^ (ViennaNode
						label: 'GlobalName'
						with: defNode parent parent parent first
						with: defNode name)
						parent: parent;
						yourself ] ].
	^ nil
]

{ #category : #'accessing-definitions' }
ViennaNode >> asImportDefinitionIn: moduleNode [
	| importDefinition |
	importDefinition := [ :node | 
	ViennaNode
		label: 'ImportDefinition'
		with: self module name
		with: (ViennaNode label: 'ImportModuleSignature' with: node) ].
	(#('TypeDefinition' 'RecordTypeDefinition') includes: label)
		ifTrue: [ ^ importDefinition
				value:
					(ViennaNode
						label: 'ImportTypesSignature'
						with:
							(ViennaNode
								label: 'TypeImport'
								with:
									(ViennaNode
										label: 'TypeName'
										with: (ViennaNode label: 'LocalName' with: self name))
								with: nil)) ].
	(#('ValueDefinition') includes: label)
		ifTrue: [ ^ importDefinition
				value:
					(ViennaNode
						label: 'ImportValuesSignature'
						withAll:
							(self patternIdentifierNames
								collect: [ :name | 
									ViennaNode
										label: 'ValueImport'
										with: (ViennaNode label: 'LocalName' with: name)
										with:
											(self first label = 'PatternIdentifier'
												ifTrue: [ self second ifNotNil: #copyFragment ]
												ifFalse: [ nil ])
										with: nil ])) ].
	(#('ExplicitFunctionDefinition' 'ImplicitFunctionDefinition')
		includes: label)
		ifTrue: [ ^ importDefinition
				value:
					(ViennaNode
						label: 'ImportFunctionsSignature'
						with:
							(ViennaNode
								label: 'FunctionImport'
								with: (ViennaNode label: 'LocalName' with: self name)
								with: self second copyFragment
								with:
									(label = 'ExplicitFunctionDefinition'
										ifTrue: [ self third copyFragment ]
										ifFalse: [ ViennaNode
												label: 'PartialFunctionType'
												with: self third first pairListToType
												with: self fourth pairListToType ])
								with: nil)) ].
	(#('ExplicitOperationDefinition' 'ImplicitOperationDefinition')
		includes: label)
		ifTrue: [ ^ importDefinition
				value:
					(ViennaNode
						label: 'ImportOperationsSignature'
						with:
							(ViennaNode
								label: 'OperationImport'
								with: (ViennaNode label: 'LocalName' with: self name)
								with:
									(label = 'ExplicitOperationDefinition'
										ifTrue: [ self second copyFragment ]
										ifFalse: [ ViennaNode
												label: 'OperationType'
												with: self second first pairListToType
												with: self third pairListToType ])
								with: nil)) ].
	^ nil
]

{ #category : #accessing }
ViennaNode >> at: anInteger put: anObject [
	(anObject isKindOf: ViennaNode)
		ifTrue: [ anObject parent: self ].
	^ super at: anInteger put: anObject
]

{ #category : #'accessing-definitions' }
ViennaNode >> bindHolderNode [
	(parent notNil
		and: [ self class patternBindLabels includes: self label ])
		ifTrue: [ ^ parent bindHolderNode ].
	^ self
]

{ #category : #enumerating }
ViennaNode >> collect: aBlock [
	^ (1 to: self size) collect: [ :index | aBlock value: (self at: index) ]
]

{ #category : #copying }
ViennaNode >> copyFragment [
	^ self shallowCopy postCopyFragment
]

{ #category : #copying }
ViennaNode >> copyWhole [
	| map |
	map := IdentityDictionary new.
	self root copyWhole: map.
	^ map at: self ifAbsent: [ nil ]
]

{ #category : #copying }
ViennaNode >> copyWhole: aDictionary [
	| copy |
	copy := self shallowCopy.
	aDictionary at: self put: copy.
	1 to: copy size do: [ :index | 
		| node |
		node := copy at: index.
		copy
			at: index
			put:
				(node isViennaNode
					ifTrue: [ node copyWhole: aDictionary ]
					ifFalse: [ node copy ]) ].
	^ copy
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInCasesAlternativeOfLocalName: aString do: aBlock [
	self first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ aBlock value: n ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInComprehensionOfLocalName: aString do: aBlock [
	label = 'SetComprehension'
		ifTrue: [ self second
				do: [ :multiBind | 
					multiBind first
						do: [ :pattern | 
							pattern
								allDescendantsDo: [ :n | 
									(n label = 'PatternIdentifier' and: [ n first = aString ])
										ifTrue: [ ^ aBlock value: n ] ] ] ].
			^ self ].
	label = 'SequenceComprehension'
		ifTrue: [ self second first
				allDescendantsDo: [ :n | 
					(n label = 'PatternIdentifier' and: [ n first = aString ])
						ifTrue: [ ^ aBlock value: n ] ].
			^ self ].
	label = 'MapComprehension'
		ifTrue: [ self third
				do: [ :multiBind | 
					multiBind first
						do: [ :pattern | 
							pattern
								allDescendantsDo: [ :n | 
									(n label = 'PatternIdentifier' and: [ n first = aString ])
										ifTrue: [ ^ aBlock value: n ] ] ] ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInDclOfLocalName: aString do: aBlock [
	self
		do: [ :statement | 
			statement label = 'DclStatement'
				ifTrue: [ statement
						do: [ :AssignmentDefinition | 
							AssignmentDefinition first = aString
								ifTrue: [ ^ aBlock value: AssignmentDefinition ] ] ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInDefOfLocalName: aString do: aBlock [
	self first
		reverseDo: [ :equalDefinition | 
			equalDefinition first
				allDescendantsDo: [ :n | 
					(n label = 'PatternIdentifier' and: [ n first = aString ])
						ifTrue: [ ^ aBlock value: n ] ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInDefinitionBlockOfLocalName: aString do: aBlock [
	self first label = 'StateDefinition'
		ifTrue: [ | state |
			state := self first.
			state first = aString
				ifTrue: [ ^ aBlock value: self ].
			state second
				do: [ :field | 
					field first = aString
						ifTrue: [ ^ aBlock value: field ] ] ]
		ifFalse: [ self first
				do: [ :def | 
					| defItem defLabel |
					defItem := def second.
					defLabel := defItem label.
					(defLabel = 'TypeDefinition' and: [ defItem first = aString ])
						ifTrue: [ ^ aBlock value: defItem ].
					(defLabel = 'RecordTypeDefinition'
						and: [ defItem first = aString ])
						ifTrue: [ ^ aBlock value: defItem ].
					defLabel = 'ValueDefinition'
						ifTrue: [ defItem first
								allDescendantsDo: [ :n | 
									(n label = 'PatternIdentifier' and: [ n first = aString ])
										ifTrue: [ ^ aBlock value: n ] ] ].
					defLabel = 'FunctionDefinition'
						ifTrue: [ defItem first first = aString
								ifTrue: [ ^ aBlock value: defItem first ] ].
					defLabel = 'OperationDefinition'
						ifTrue: [ defItem first first = aString
								ifTrue: [ ^ aBlock value: defItem first ] ] ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInExplicitFunctionOfLocalName: aString do: aBlock [
	self fifth
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ aBlock value: n ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInExplicitOperationOfLocalName: aString do: aBlock [
	self fourth
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ aBlock value: n ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInForLoopOfLocalName: aString do: aBlock [
	(label = 'IndexForLoop' and: [ self first = aString ])
		ifTrue: [ ^ aBlock value: self ].
	label = 'SequenceForLoop'
		ifTrue: [ self first
				allDescendantsDo: [ :n | 
					(n label = 'PatternIdentifier' and: [ n first = aString ])
						ifTrue: [ ^ aBlock value: n ] ] ].
	label = 'SetForLoop'
		ifTrue: [ self first
				allDescendantsDo: [ :n | 
					(n label = 'PatternIdentifier' and: [ n first = aString ])
						ifTrue: [ ^ aBlock value: n ] ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInImplicitFunctionOfLocalName: aString do: aBlock [
	self third first
		do: [ :patList | 
			patList label = 'PatternList'
				ifTrue: [ patList
						allDescendantsDo: [ :n | 
							n first = aString
								ifTrue: [ ^ aBlock value: n ] ] ] ].
	self fourth
		do: [ :n | 
			n = aString
				ifTrue: [ ^ aBlock value: self ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInImplicitOperationOfLocalName: aString do: aBlock [
	self second first
		do: [ :patList | 
			patList label = 'PatternList'
				ifTrue: [ patList
						allDescendantsDo: [ :n | 
							n first = aString
								ifTrue: [ ^ aBlock value: n ] ] ] ].
	self third
		do: [ :n | 
			n = aString
				ifTrue: [ ^ aBlock value: self ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInImportsOfLocalName: aString do: aBlock [
	self
		do: [ :importDef | 
			importDef second label = 'ImportModuleSignature'
				ifTrue: [ importDef second
						do: [ :imports | 
							imports
								do: [ :import | 
									(import at: import size)
										ifNotNil: [ :rename | 
											rename first = aString
												ifTrue: [ ^ aBlock value: import ] ] ] ] ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInLambdaOfLocalName: aString do: aBlock [
	self first
		do: [ :bind | 
			bind first
				allDescendantsDo: [ :node | 
					(node label = 'PatternIdentifier' and: [ node first = aString ])
						ifTrue: [ ^ aBlock value: node ] ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInLetBeOfLocalName: aString do: aBlock [
	| valDef |
	valDef := self first.
	valDef
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ aBlock value: n ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInLetOfLocalName: aString do: aBlock [
	self first
		do: [ :localDef | 
			| def |
			def := localDef first.
			def label = 'ValueDefinition'
				ifTrue: [ def first
						allDescendantsDo: [ :n | 
							(n label = 'PatternIdentifier' and: [ n first = aString ])
								ifTrue: [ ^ aBlock value: n ] ] ].
			def label = 'FunctionDefinition'
				ifTrue: [ def first first = aString
						ifTrue: [ ^ aBlock value: def first ] ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInModuleOfLocalName: aString do: aBlock [
	label = 'Module'
		ifTrue: [ self third
				do: [ :defBlock | 
					defBlock
						definitionInDefinitionBlockOfLocalName: aString
						do: [ :node | ^ aBlock value: node ] ].
			self second first
				ifNotNil: [ :imports | 
					imports
						definitionInImportsOfLocalName: aString
						do: [ :node | ^ aBlock value: node ] ].
			^ self ].
	(label = 'Document' and: [ self first label = 'DefinitionBlock' ])
		ifTrue: [ self
				do: [ :defBlock | 
					defBlock
						definitionInDefinitionBlockOfLocalName: aString
						do: [ :node | ^ aBlock value: node ] ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInQuantifierOfLocalName: aString do: aBlock [
	(label = 'ForallExpresison' or: [ label = 'ExistsExpression' ])
		ifTrue: [ self first
				do: [ :multiBind | 
					multiBind first
						do: [ :pattern | 
							pattern
								allDescendantsDo: [ :n | 
									(n label = 'PatternIdentifier' and: [ n first = aString ])
										ifTrue: [ ^ aBlock value: n ] ] ] ].
			^ self ].
	(label = 'Exists1Expression' or: [ label = 'IotaExpression' ])
		ifTrue: [ self first first
				allDescendantsDo: [ :n | 
					(n label = 'PatternIdentifier' and: [ n first = aString ])
						ifTrue: [ ^ aBlock value: n ] ].
			^ self ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionOfGlobalName: shortName module: moduleName [
	self module second first
		ifNotNil: [ :importDefinitionList | 
			importDefinitionList
				do: [ :importDef | 
					importDef first = moduleName
						ifTrue: [ importDef second label = 'ImportModuleSignature'
								ifTrue: [ importDef second
										do: [ :imports | 
											imports
												do: [ :import | 
													import first first = shortName
														ifTrue: [ ^ import ] ] ] ] ] ] ].
	^ nil
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionOfLocalName: aString [
	(label = 'DefExpression' or: [ label = 'DefStatement' ])
		ifTrue: [ self definitionInDefOfLocalName: aString do: [ :node | ^ node ] ].
	(label = 'LetExpression' or: [ label = 'LetStatement' ])
		ifTrue: [ self definitionInLetOfLocalName: aString do: [ :node | ^ node ] ].
	(label = 'LetBeExpression' or: [ label = 'LetBeStatement' ])
		ifTrue: [ self definitionInLetBeOfLocalName: aString do: [ :node | ^ node ] ].
	(label = 'CasesExpressionAlternative'
		or: [ label = 'CasesStatementAlternative' ])
		ifTrue: [ self
				definitionInCasesAlternativeOfLocalName: aString
				do: [ :node | ^ node ] ].
	(#('SetComprehensiono' 'SequenceComprehension' 'MapComprehension')
		includes: label)
		ifTrue: [ self
				definitionInComprehensionOfLocalName: aString
				do: [ :node | ^ node ] ].
	(#('ForallExpression' , 'ExistsExpression' 'Exists1Expression' 'IotaExpression')
		includes: label)
		ifTrue: [ self
				definitionInQuantifierOfLocalName: aString
				do: [ :node | ^ node ] ].
	label = 'LambdaExpression'
		ifTrue: [ self definitionInLambdaOfLocalName: aString do: [ :node | ^ node ] ].
	(label = 'BlockStatement' and: [ self first label = 'DclStatement' ])
		ifTrue: [ self definitionInDclOfLocalName: aString do: [ :node | ^ node ] ].
	(#('IndexForLoop' 'SequenceForLoop' 'SetForLoop') includes: label)
		ifTrue:
			[ self definitionInForLoopOfLocalName: aString do: [ :node | ^ node ] ].
	label = 'Module'
		ifTrue: [ self definitionInModuleOfLocalName: aString do: [ :node | ^ node ] ].
	label = 'ExplicitFunctionDefinition'
		ifTrue: [ self
				definitionInExplicitFunctionOfLocalName: aString
				do: [ :node | ^ node ] ].
	label = 'ImplicitFunctionDefinition'
		ifTrue: [ self
				definitionInImplicitFunctionOfLocalName: aString
				do: [ :node | ^ node ] ].
	label = 'ExplicitOperationDefinition'
		ifTrue: [ self
				definitionInExplicitOperationOfLocalName: aString
				do: [ :node | ^ node ] ].
	label = 'ImplicitOperationDefinition'
		ifTrue: [ self
				definitionInImplicitOperationOfLocalName: aString
				do: [ :node | ^ node ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #enumerating }
ViennaNode >> detect: aBlock [
	self do: [ :node | (aBlock value: node) ifTrue: [ ^node ] ].
	^ NotFound signalFor: self
]

{ #category : #enumerating }
ViennaNode >> detect: aBlock ifNone: errorBlock [
	self
		do: [ :node | 
			(aBlock value: node)
				ifTrue: [ ^ node ] ].
	^ errorBlock value
]

{ #category : #enumerating }
ViennaNode >> do: aBlock [
	1 to: self size do: [ :index | aBlock value: (self at: index) ]
]

{ #category : #accessing }
ViennaNode >> document [
	^ self parentLabelled: 'Document' ifAbsent: [ nil ]
]

{ #category : #accessing }
ViennaNode >> eighth [
	^ self at: 8
]

{ #category : #accessing }
ViennaNode >> end [
	^ end
]

{ #category : #enumerating }
ViennaNode >> ensureImports [
	^ self module second
		in: [ :interface | 
			interface first
				ifNil: [ | node |
					node := ViennaNode label: 'ImportDefinitionList'.
					interface at: 1 put: node.
					node ] ]
]

{ #category : #enumerating }
ViennaNode >> exports [
	^ self module second second
]

{ #category : #accessing }
ViennaNode >> fifth [
	^ self at: 5
]

{ #category : #accessing }
ViennaNode >> first [
	^ self at: 1
]

{ #category : #accessing }
ViennaNode >> fourth [
	^ self at: 4
]

{ #category : #enumerating }
ViennaNode >> hasDescendantSuchThat: aBlock [
	self allDescendantsDo: [ :n | (aBlock value: n) ifTrue: [ ^true ] ].
	^ false
]

{ #category : #controlling }
ViennaNode >> ifEmpty: aBlock [
	^ self isEmpty
		ifTrue: [ aBlock cull: self ]
		ifFalse: [ self ]
]

{ #category : #testing }
ViennaNode >> ifEmpty: emptyBlock ifNotEmpty: nonEmptyBlock [
	^ self isEmpty
		ifTrue: [ emptyBlock value ]
		ifFalse: [ nonEmptyBlock cull: self ]
]

{ #category : #controlling }
ViennaNode >> ifNotEmpty: aBlock [
	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #testing }
ViennaNode >> ifNotEmpty: nonEmptyBlock ifEmpty: emptyBlock [
	^ self isEmpty
		ifTrue: [ emptyBlock value ]
		ifFalse: [ nonEmptyBlock cull: self ]
]

{ #category : #enumerating }
ViennaNode >> imports [
	^ self module second first
]

{ #category : #enumerating }
ViennaNode >> importsFrom: aString do: aBlock [
	self module second first
		ifNotNil: [ :importDefinitionList | 
			importDefinitionList asArray
				do: [ :importDefinition | 
					importDefinition first = aString
						ifTrue: [ aBlock value: importDefinition second ] ] ]
]

{ #category : #testing }
ViennaNode >> includesParent: aViennaNode [
	self
		parentsDo: [ :node | 
			node = aViennaNode
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ViennaNode >> isBlockVariableNameNode [
	self label = 'LocalName'
		ifTrue: [ (self definitionOfLocalName: self first)
				ifNotNil: [ :defNode | 
					defNode label = 'AssignmentDefinition'
						ifTrue: [ ^ true ] ] ].
	^ false
]

{ #category : #testing }
ViennaNode >> isEmpty [
	^ self size = 0
]

{ #category : #testing }
ViennaNode >> isExportedNameNode [
	label = 'GlobalName'
		ifTrue: [ ^ true ].
	label = 'LocalName'
		ifTrue: [ ^ self module second second
				anySatisfy: [ :exportModuleSignature | 
					exportModuleSignature label = 'ExportModuleSignatureAll'
						or: [ exportModuleSignature
								anySatisfy: [ :exportSignatures | 
									exportSignatures
										anySatisfy: [ :export | 
											((#('TypeNameExport' 'TypeStructExport') includes: export label)
												and: [ export first first = self first ])
												or: [ (#('ValueExport' 'FunctionExport' 'OperationExport')
														includes: export label)
														and: [ export first
																anySatisfy: [ :localName | localName first = self first ] ] ] ] ] ] ] ].
	^ false
]

{ #category : #testing }
ViennaNode >> isExpressionNode [
	^ (self class expressionLabels includes: label) and: [ self isTypeNode not ]
]

{ #category : #testing }
ViennaNode >> isFunctionNameNode [
	self label = 'LocalName'
		ifTrue: [ (self definitionOfLocalName: self first)
				ifNotNil: [ :defNode | 
					((#('ExplicitFunctionDefinition' 'ImplicitFunctionDefinition')
						includes: defNode label) and: [ defNode first = self first ])
						ifTrue: [ ^ true ].
					(defNode label = 'FunctionImport'
						and: [ defNode first first = self first ])
						ifTrue: [ ^ true ] ].
			^ false ].
	self label = 'GlobalName'
		ifTrue: [ (self moduleNamed: self first)
				ifNotNil: [ :moduleNode | 
					(moduleNode definitionOfLocalName: self second)
						ifNotNil: [ :defNode | 
							((#('ExplicitFunctionDefinition' 'ImplicitFunctionDefinition')
								includes: defNode label) and: [ defNode first = self second ])
								ifTrue: [ ^ true ] ] ].
			^ false ].
	^ false
]

{ #category : #testing }
ViennaNode >> isLocalValueNameNode [
	self label = 'LocalName'
		ifTrue: [ (self definitionOfLocalName: self first)
				ifNotNil: [ :defNode | 
					| node |
					node := defNode.
					[ node notNil ]
						whileTrue: [ (#('ValueDefinition') includes: node label)
								ifTrue: [ ^ true ].
							node := node parent ] ].
			^ false ].
	^ false
]

{ #category : #testing }
ViennaNode >> isOperationNameNode [
	self label = 'LocalName'
		ifTrue: [ (self definitionOfLocalName: self first)
				ifNotNil: [ :defNode | 
					((#('ExplicitOperationDefinition' 'ImplicitOperationDefinition')
						includes: defNode label) and: [ defNode first = self first ])
						ifTrue: [ ^ true ].
					(defNode label = 'OperationImport'
						and: [ defNode first first = self first ])
						ifTrue: [ ^ true ] ].
			^ false ].
	self label = 'GlobalName'
		ifTrue: [ (self moduleNamed: self first)
				ifNotNil: [ :moduleNode | 
					(moduleNode definitionOfLocalName: self second)
						ifNotNil: [ :defNode | 
							((#('ExplicitOperationDefinition' 'ImplicitOperationDefinition')
								includes: defNode label) and: [ defNode first = self second ])
								ifTrue: [ ^ true ] ] ].
			^ false ].
	^ false
]

{ #category : #testing }
ViennaNode >> isStateVariableNameNode [
	self label = 'OldName'
		ifTrue: [ ^ true ].
	self label = 'LocalName'
		ifTrue: [ (self definitionOfLocalName: self first)
				ifNotNil: [ :fieldNode | 
					(fieldNode label = 'Field'
						and: [ fieldNode parent parent label = 'StateDefinition' ])
						ifTrue: [ ^ true ] ].
			^ false ].
	^ false
]

{ #category : #testing }
ViennaNode >> isStatementNode [
	^ self class statementLabels includes: label
]

{ #category : #testing }
ViennaNode >> isTypeNameNode [
	self label = 'LocalName'
		ifTrue: [ (self definitionOfLocalName: self first)
				ifNotNil: [ :defNode | 
					((#('TypeDefinition' 'RecordTypeDefinition') includes: defNode label)
						and: [ defNode first = self first ])
						ifTrue: [ ^ true ].
					(defNode label = 'TypeImport'
						and: [ defNode first first = self first ])
						ifTrue: [ ^ true ] ].
			^ false ].
	self label = 'GlobalName'
		ifTrue: [ (self moduleNamed: self first)
				ifNotNil: [ :moduleNode | 
					(moduleNode definitionOfLocalName: self second)
						ifNotNil: [ :defNode | 
							((#('TypeDefinition' 'RecordTypeDefinition') includes: defNode label)
								and: [ defNode first = self second ])
								ifTrue: [ ^ true ] ] ].
			^ false ].
	^ false
]

{ #category : #testing }
ViennaNode >> isTypeNode [
	^ (self class typeLabels includes: label)
		or: [ (label = 'LocalName' or: [ label = 'GlobalName' ])
				and: [ parent notNil and: [ parent label = 'TypeName' ] ] ]
]

{ #category : #testing }
ViennaNode >> isValueNameNode [
	self label = 'LocalName'
		ifTrue: [ (self definitionOfLocalName: self first)
				ifNotNil: [ :defNode | 
					defNode bindHolderNode label = 'ValueDefinition'
						ifTrue: [ ^ true ].
					(defNode label = 'LocalName'
						and:
							[ defNode parent notNil and: [ defNode parent label = 'ValueImport' ] ])
						ifTrue: [ ^ true ] ].
			^ false ].
	self label = 'GlobalName'
		ifTrue: [ (self moduleNamed: self first)
				ifNotNil: [ :moduleNode | 
					(moduleNode definitionOfLocalName: self second)
						ifNotNil: [ :defNode | 
							defNode bindHolderNode label = 'ValueDefinition'
								ifTrue: [ ^ true ] ] ].
			^ false ].
	^ false
]

{ #category : #testing }
ViennaNode >> isViennaNode [
	^ true
]

{ #category : #accessing }
ViennaNode >> label [
	^ label
]

{ #category : #accessing }
ViennaNode >> last [
	^ self at: self size
]

{ #category : #accessing }
ViennaNode >> localName [
	self
		allDescendantsDo: [ :n | 
			n label = 'LocalName'
				ifTrue: [ ^ n ] ]
]

{ #category : #accessing }
ViennaNode >> module [
	^ self parentLabelled: 'Module' ifAbsent: [ nil ]
]

{ #category : #accessing }
ViennaNode >> moduleNamed: aString [
	self document
		do: [ :module | 
			(module label = 'Module' and: [ module first = aString ])
				ifTrue: [ ^ module ] ].
	^ nil
]

{ #category : #accessing }
ViennaNode >> modulesDo: aBlock [
	self document do: aBlock
]

{ #category : #'accessing-definitions' }
ViennaNode >> name [
	(#('FunctionDefinition' 'OperationDefinition') includes: label)
		ifTrue: [ ^ self first name ].
	(#('Module' 'ImportDefinition' 'PatternIdentifier' 'LocalName' 'TypeDefinition' 'RecordTypeDefinition' 'ExplicitFunctionDefinition' 'ExplicitOperationDefinition' 'ImplicitFunctionDefinition' 'ImplicitOperationDefinition' 'StateDefinition' 'Field')
		includes: label)
		ifTrue: [ ^ self first ].
	(#('AccessTypeDefinition' 'AccessValueDefinition' 'AccessFunctionDefinition' 'AccessOperationDefinition')
		includes: label)
		ifTrue: [ ^ self second name ].
	label = 'GlobalName'
		ifTrue: [ ^ self first , '`' , self second ].
	label = 'TypeImport'
		ifTrue: [ ^ self first first first ].
	(#('ValueImport' 'FunctionImport' 'OperationImport') includes: label)
		ifTrue: [ ^ self first first ].
	label = 'TypeDefinitions' ifTrue: [ ^ 'types' ].
	label = 'ValueDefinitions' ifTrue: [ ^ 'values' ].
	label = 'FunctionDefinitions' ifTrue: [ ^ 'functions' ].
	label = 'OperationDefinitions' ifTrue: [ ^ 'operations' ].
	^ nil
]

{ #category : #accessing }
ViennaNode >> ninth [
	^ self at: 9
]

{ #category : #testing }
ViennaNode >> notEmpty [
	^ self isEmpty not
]

{ #category : #'accessing-definitions' }
ViennaNode >> pairListToType [
	^ ((2 to: self size by: 2)
		collect: [ :index | (self at: index) copyFragment ])
		ifEmpty: [ ViennaNode label: 'UnitType' ]
		ifNotEmpty: [ :types | 
			types size = 1
				ifTrue: [ types first ]
				ifFalse: [ ViennaNode label: 'ProductType' withAll: types ] ]
]

{ #category : #accessing }
ViennaNode >> parent [
	^ parent
]

{ #category : #accessing }
ViennaNode >> parent: aViennaNode [
	parent := aViennaNode
]

{ #category : #accessing }
ViennaNode >> parentLabelled: aString ifAbsent: errorBlock [
	self
		parentsDo: [ :node | 
			node label = aString
				ifTrue: [ ^ node ] ].
	^ errorBlock value
]

{ #category : #enumerating }
ViennaNode >> parentsDo: aBlock [
	| node |
	node := self.
	[ node notNil ]
		whileTrue: [ 
			aBlock value: node.
			node := node parent ]
]

{ #category : #accessing }
ViennaNode >> patternIdentifierNames [
	^ self patternIdentifiers collect: #first
]

{ #category : #accessing }
ViennaNode >> patternIdentifiers [
	^ Array
		streamContents: [ :stream | 
			self
				allDescendantsDo: [ :node | 
					node label = 'PatternIdentifier'
						ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : #copying }
ViennaNode >> postCopyFragment [
	1 to: self size do: [ :index | 
		| node |
		node := self at: index.
		self
			at: index
			put:
				(node isViennaNode
					ifTrue: [ node copyFragment ]
					ifFalse: [ node copy ]) ]
]

{ #category : #printing }
ViennaNode >> printOn: aStream [
	| substrings |
	aStream
		nextPut: $(;
		nextPutAll: label asString;
		nextPut: Character space.
	substrings := self collect: #printString.
	((substrings contains: [ :string | string includes: Character cr ]) or: [( {0}, (substrings collect: #size)) sum > 50 ])
		ifTrue: [ 
			substrings
				do: [ :string | 
					aStream nextPut: Character cr.
					string lines
						do: [ :line | 
							aStream
								nextPutAll: '  ';
								nextPutAll: line ]
						separatedBy: [ aStream nextPut: Character cr ] ] ]
		ifFalse: [ substrings do: [ :string | aStream nextPutAll: string ] separatedBy: [ aStream nextPut: Character space ] ].
	aStream nextPut: $)
]

{ #category : #enumerating }
ViennaNode >> referenceNodesDo: aBlock [
	self
		allDescendantsDo: [ :node | 
			(#('LocalName' 'GlobalName' 'OldName') includes: node label)
				ifTrue: [ aBlock value: node ] ]
]

{ #category : #'adding/removing' }
ViennaNode >> remove: anObject [
	| array |
	array := self asArray copyWithout: anObject.
	self
		become:
			((self class new: array size)
				setLabel: label;
				parent: parent;
				start: start end: end;
				yourself).
	1 to: array size do: [ :index | self at: index put: (array at: index) ].
	^ anObject
]

{ #category : #'adding/removing' }
ViennaNode >> removeAfterIndex: anInteger [
	| array |
	array := self asArray copyFrom: 1 to: anInteger - 1.
	self
		become:
			((self class new: array size)
				setLabel: label;
				parent: parent;
				start: start end: end;
				yourself).
	1 to: array size do: [ :index | self at: index put: (array at: index) ].
	^ anInteger
]

{ #category : #'adding/removing' }
ViennaNode >> removeAll: aCollection [
	| array |
	array := self asArray copyWithoutAll: aCollection.
	self
		become:
			((self class new: array size)
				setLabel: label;
				parent: parent;
				start: start end: end;
				yourself).
	1 to: array size do: [ :index | self at: index put: (array at: index) ].
	^ aCollection
]

{ #category : #'accessing-definitions' }
ViennaNode >> resolve [
	label = 'LocalName'
		ifTrue: [ ^ self resolveLocalName: self first ].
	label = 'GlobalName'
		ifTrue: [ ^ (self moduleNamed: self first)
				ifNotNil: [ :module | module resolveLocalName: self second ] ].
	(#('TypeDefinition' 'RecordTypeDefinition' 'ValueDefinition' 'ExplicitFunctionDefinition' 'ImplicitFunctionDefinition' 'ExplicitOperationDefinition' 'ImplicitOperationDefinition')
		includes: label)
		ifTrue: [ ^ self ].
	(#('FunctionDefinition' 'OperationDefinition') includes: label)
		ifTrue: [ ^ self first ].
	(#('AccessTypeDefinition' 'AccessValueDefinition' 'AccessFunctionDefinition' 'AccessOperationDefinition')
		includes: label)
		ifTrue: [ ^ self second resolve ].
	^ nil
]

{ #category : #'accessing-definitions' }
ViennaNode >> resolveLocalName: aString [
	(self definitionOfLocalName: aString)
		ifNotNil: [ :defNode | 
			(#('ExplicitFunctionDefinition' 'ImplicitFunctionDefinition' 'ExplicitOperationDefinition' 'ImplicitOperationDefinition' 'TypeDefinition' 'RecordTypeDefinition')
				includes: defNode label)
				ifTrue: [ ^ defNode ].
			(#('TypeImport' 'ValueImport' 'FunctionImport' 'OperationImport')
				includes: defNode label)
				ifTrue: [ (self
						moduleNamed: (defNode parentLabelled: 'ImportDefinition' ifAbsent: [ ^ nil ]) first)
						ifNotNil: [ :moduleNode | 
							moduleNode == self module
								ifFalse: [ ^ moduleNode
										resolveLocalName:
											(defNode label = 'TypeImport'
												ifTrue: [ defNode first first first ]
												ifFalse: [ defNode first first ]) ] ].
					^ nil ].
			(defNode label = 'Field'
				and: [ defNode parent parent label = 'StateDefinition' ])
				ifTrue: [ ^ defNode parent parent ].
			defNode bindHolderNode
				ifNotNil: [ :bindNode | 
					bindNode label = 'ValueDefinition'
						ifTrue: [ ^ bindNode ] ] ].
	^ nil
]

{ #category : #enumerating }
ViennaNode >> reverseDo: aBlock [
	self size to: 1 by: -1 do: [ :index | aBlock value: (self at: index) ]
]

{ #category : #accessing }
ViennaNode >> root [
	^ parent ifNil: [ self ] ifNotNil: #root
]

{ #category : #testing }
ViennaNode >> sameAs: aViennaNode [
	aViennaNode isViennaNode
		ifFalse: [ ^ false ].
	label = aViennaNode label
		ifFalse: [ ^ false ].
	self size = aViennaNode size
		ifFalse: [ ^ false ].
	1 to: self size do: [ :index | 
		| n1 n2 |
		n1 := self at: index.
		n2 := aViennaNode at: index.
		(n1 isViennaNode
			ifTrue: [ n1 sameAs: n2 ]
			ifFalse: [ n1 = n2 ])
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
ViennaNode >> second [
	^ self at: 2
]

{ #category : #private }
ViennaNode >> setLabel: aString [
	label := aString
]

{ #category : #accessing }
ViennaNode >> seventh [
	^ self at: 7
]

{ #category : #accessing }
ViennaNode >> sixth [
	^ self at: 6
]

{ #category : #accessing }
ViennaNode >> start [
	^ start
]

{ #category : #accessing }
ViennaNode >> start: anInteger1 end: anInteger2 [
	start := anInteger1.
	end := anInteger2
]

{ #category : #accessing }
ViennaNode >> stateVariablesDo: aBlock [
	(self parentLabelled: 'DefinitionBlock' ifAbsent: [ ^ self ]) parent
		do: [ :node | 
			node first label = 'StateDefinition'
				ifTrue: [ node first second do: [ :field | aBlock value: field first ] ] ]
]

{ #category : #printing }
ViennaNode >> storeOn: aStream [
	aStream
		nextPutAll: '(';
		nextPutAll: self class name;
		nextPutAll: ' label: '.
	label storeOn: aStream.
	aStream nextPutAll: ' withAll: {'.
	(1 to: self size) do: [ :index | (self at: index) storeOn: aStream ] separatedBy: [ aStream nextPutAll: ' . ' ].
	aStream nextPutAll: '})'
]

{ #category : #accessing }
ViennaNode >> third [
	^ self at: 3
]

{ #category : #enumerating }
ViennaNode >> variableExpressionNodesDo: aBlock [
	self
		allDescendantsDo: [ :node | 
			node label = 'OldName'
				ifTrue: [ aBlock value: node ].
			(#('LocalName' 'GlobalName') includes: node label)
				ifTrue: [ (node isValueNameNode or: [ node isFunctionNameNode ])
						ifFalse: [ aBlock value: node ] ] ]
]
