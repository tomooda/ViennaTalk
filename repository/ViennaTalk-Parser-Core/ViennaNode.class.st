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
	#category : #'ViennaTalk-Parser-Core'
}

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

{ #category : #'adding/removing' }
ViennaNode >> add: anObject [
	| array |
	array := self asArray.
	self
		become:
			((self class new: self size + 1)
				setLabel: label;
				yourself).
	1 to: array size do: [ :index | self at: index put: (array at: index) ].
	self at: self size put: anObject.
	^ anObject
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

{ #category : #accessing }
ViennaNode >> at: anInteger put: anObject [
	(anObject isKindOf: ViennaNode)
		ifTrue: [ anObject parent: self ].
	^ super at: anInteger put: anObject
]

{ #category : #enumerating }
ViennaNode >> collect: aBlock [
	^ (1 to: self size) collect: [ :index | aBlock value: (self at: index) ]
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
	self first
		do: [ :dclDef | 
			dclDef first = aString
				ifTrue: [ ^ aBlock value: dclDef ] ]
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
						do: [ :import | 
							(import at: import size)
								ifNotNil: [ :rename | 
									(self moduleNamed: importDef first)
										ifNotNil: [ :module | 
											^ aBlock
												value: (module definitionOfLocalName: import first localName first) ] ] ] ] ]
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
		ifTrue: [ self second first
				ifNotNil:
					[ :imports | imports definitionInImportsOfLocalName: aString do: aBlock ].
			self third
				do: [ :defBlock | 
					defBlock
						definitionInDefinitionBlockOfLocalName: aString
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
ViennaNode >> definitionOfLocalName: aString [
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

{ #category : #'accessing-source' }
ViennaNode >> highlightedSource [
	^ self source
		in: [ :source | 
			ViennaVDMHighlighter new
				text: source asString asText;
				parse: source asString;
				text ]
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

{ #category : #testing }
ViennaNode >> includesParent: aViennaNode [
	self
		parentsDo: [ :node | 
			node = aViennaNode
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ViennaNode >> isEmpty [
	^ self size = 0
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

{ #category : #accessing }
ViennaNode >> ninth [
	^ self at: 9
]

{ #category : #testing }
ViennaNode >> notEmpty [
	^ self isEmpty not
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
	| names |
	names := OrderedCollection new.
	self label = 'PatternIdentifier'
		ifTrue: [ names add: self first ].
	self
		allDescendantsDo: [ :node | 
			(node label = 'PatternIdentifier'
				and: [ (names includes: node first) not ])
				ifTrue: [ names add: node first ] ].
	^ names
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

{ #category : #'adding/removing' }
ViennaNode >> remove: anObject [
	| array |
	array := self asArray copyWithout: anObject.
	self
		become:
			((self class new: array size)
				setLabel: label;
				yourself).
	1 to: array size do: [ :index | self at: index put: (array at: index) ].
	^ anObject
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

{ #category : #'accessing-source' }
ViennaNode >> source [
	^ ViennaVDMFormatter format: self
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

{ #category : #'accessing-source' }
ViennaNode >> tracingHighlightedSource [
	^ self tracingSource
		in: [ :source | 
			ViennaVDMHighlighter new
				text: source asText;
				parse: source asString;
				text ]
]

{ #category : #'accessing-source' }
ViennaNode >> tracingSource [
	| source whole |
	source := (ViennaVDMTracingFormatter format: self)
		asViennaTracingString.
	source mergeSources.
	whole := 1 to: source size.
	source sources
		addAll: (self allParents collect: [ :node | whole -> node ]).
	^ source
]
