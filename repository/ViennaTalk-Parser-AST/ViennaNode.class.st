Class {
	#name : #ViennaNode,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'label',
		'parent',
		'start',
		'end',
		'annotations'
	],
	#classVars : [
		'ExpressionLabels',
		'PatternBindLabels',
		'TypeLabels'
	],
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaNode class >> label: aString [

	^ self new: 0 label: aString
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 [

	^ (self new: 0 label: aString)
		  start: anInteger1 end: anInteger2;
		  yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 with: aViennaNode [

	^ (self new: 1 label: aString)
		  at: 1 put: aViennaNode;
		  start: anInteger1 end: anInteger2;
		  yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 with: aViennaNode1 with: aViennaNode2 [

	^ (self new: 2 label: aString)
		  at: 1 put: aViennaNode1;
		  at: 2 put: aViennaNode2;
		  start: anInteger1 end: anInteger2;
		  yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 [

	^ (self new: 3 label: aString)
		  at: 1 put: aViennaNode1;
		  at: 2 put: aViennaNode2;
		  at: 3 put: aViennaNode3;
		  start: anInteger1 end: anInteger2;
		  yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString start: anInteger1 end: anInteger2 withAll: anArray [

	| node |
	node := self new: anArray size label: aString.
	1 to: anArray size do: [ :index |
	node at: index put: (anArray at: index) ].
	node start: anInteger1 end: anInteger2.
	^ node
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode [

	^ (self new: 1 label: aString)
		  at: 1 put: aViennaNode;
		  yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 [

	^ (self new: 2 label: aString)
		  at: 1 put: aViennaNode1;
		  at: 2 put: aViennaNode2;
		  yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 [

	^ (self new: 3 label: aString)
		  at: 1 put: aViennaNode1;
		  at: 2 put: aViennaNode2;
		  at: 3 put: aViennaNode3;
		  yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 with: aViennaNode4 [

	^ (self new: 4 label: aString)
		  at: 1 put: aViennaNode1;
		  at: 2 put: aViennaNode2;
		  at: 3 put: aViennaNode3;
		  at: 4 put: aViennaNode4;
		  yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 with: aViennaNode4 with: aViennaNode5 [

	^ (self new: 5 label: aString)
		  at: 1 put: aViennaNode1;
		  at: 2 put: aViennaNode2;
		  at: 3 put: aViennaNode3;
		  at: 4 put: aViennaNode4;
		  at: 5 put: aViennaNode5;
		  yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 with: aViennaNode4 with: aViennaNode5 with: aViennaNode6 [

	^ (self new: 6 label: aString)
		  at: 1 put: aViennaNode1;
		  at: 2 put: aViennaNode2;
		  at: 3 put: aViennaNode3;
		  at: 4 put: aViennaNode4;
		  at: 5 put: aViennaNode5;
		  at: 6 put: aViennaNode6;
		  yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString with: aViennaNode1 with: aViennaNode2 with: aViennaNode3 with: aViennaNode4 with: aViennaNode5 with: aViennaNode6 with: aViennaNode7 [

	^ (self new: 7 label: aString)
		  at: 1 put: aViennaNode1;
		  at: 2 put: aViennaNode2;
		  at: 3 put: aViennaNode3;
		  at: 4 put: aViennaNode4;
		  at: 5 put: aViennaNode5;
		  at: 6 put: aViennaNode6;
		  at: 7 put: aViennaNode7;
		  yourself
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString withAll: anArray [

	^ self label: aString withAll: anArray annotations: nil
]

{ #category : #'instance creation' }
ViennaNode class >> label: aString withAll: anArray annotations: anArrayOfString [

	| node |
	node := self new: anArray size label: aString.
	1 to: anArray size do: [ :index |
	node at: index put: (anArray at: index) ].
	node annotations: anArrayOfString.
	^ node
]

{ #category : #'instance creation' }
ViennaNode class >> new: anInteger label: aString [

	^ Smalltalk
		  at: ('Vienna' , aString , 'Node') asSymbol
		  ifPresent: [ :class | class new: anInteger ]
		  ifAbsent: [
			  (self new: anInteger)
				  setLabel: aString;
				  yourself ]
]

{ #category : #accessing }
ViennaNode class >> patternBindLabels [

	^ PatternBindLabels ifNil: [
		  PatternBindLabels := #( 'BindList' 'FieldPattern' 'FieldPatternList'
		                          'MapEnumerationPattern'
		                          'MapMunionPattern' 'MapletPattern'
		                          'MatchValue' 'MultipleSeqBind'
		                          'MultipleSetBind' 'MultipleTypeBind'
		                          'PatternIdentifier' 'PatternList'
		                          'RecordPattern' 'SeqBind' 'SeqConcPattern'
		                          'SeqEnumPattern' 'SetBind' 'SetEnumPattern'
		                          'SetUnionPattern' 'TuplePattern'
		                          'PatternList' 'TypeBind' 'TypeBindList' )
			                       asSet ]
]

{ #category : #accessing }
ViennaNode class >> typeLabels [
	^ TypeLabels
		ifNil:
			[ TypeLabels := #('BasicType' 'CompositeType' 'InmapType' 'MapType' 'OptionalType' 'PartialFunctionType' 'ProductType' 'QuoteType' 'Seq1Type' 'SeqType' 'Set1Type' 'SetType' 'TotalFunctionType' 'TypeName' 'UnionType' 'UnitType')
				asSet ]
]

{ #category : #'instance creation' }
ViennaNode class >> withAll: anArrayOfViennaNode [

	| node |
	node := self new: anArrayOfViennaNode size.
	1 to: anArrayOfViennaNode size do: [ :index |
	node at: index put: (anArrayOfViennaNode at: index) ].
	^ node
]

{ #category : #'adding/removing' }
ViennaNode >> add: anObject [

	| array |
	array := self asArray copyWith: anObject.
	self become: ((self class new: array size label: self label)
			 parent: parent;
			 start: start end: end;
			 yourself).
	1 to: array size do: [ :index |
	self at: index put: (array at: index) ].
	^ anObject
]

{ #category : #'adding/removing' }
ViennaNode >> addAll: aCollection [

	| array |
	array := self asArray , aCollection.
	self become: ((self class new: array size label: self label)
			 parent: parent;
			 start: start end: end;
			 yourself).
	1 to: array size do: [ :index |
	self at: index put: (array at: index) ].
	^ aCollection
]

{ #category : #'adding/removing' }
ViennaNode >> addAnnotation: aString [

	annotations := annotations ifNil: [ { aString } ] ifNotNil: [ 
		               (annotations includes: aString)
			               ifTrue: [ annotations ]
			               ifFalse: [ annotations copyWith: aString ] ].
	^ aString
]

{ #category : #enumerating }
ViennaNode >> allDescendantsDo: aBlock [
	aBlock value: self.
	self
		do: [ :node | 
			node isViennaNode
				ifTrue: [ node allDescendantsDo: aBlock ] ]
]

{ #category : #enumerating }
ViennaNode >> allDescendantsSuchThat: aBlock1 do: aBlock2 [

	self allDescendantsDo: [ :node |
		(aBlock1 value: node) ifTrue: [ aBlock2 value: node ] ]
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

{ #category : #accessing }
ViennaNode >> annotations [

	^ annotations
]

{ #category : #accessing }
ViennaNode >> annotations: anArrayOfString [

	annotations := anArrayOfString
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

	self label = 'ValueDefinition' ifTrue: [
		^ ViennaNode
			  label: 'AccessValueDefinition'
			  with: (ViennaNode label: 'Access')
			  with: self ].
	(#( 'TypeDefinition' 'RecordTypeDefinition' ) includes: self label)
		ifTrue: [
			^ ViennaNode
				  label: 'AccessTypeDefinition'
				  with: (ViennaNode label: 'Access')
				  with: self ].
	self label = 'FunctionDefinition' ifTrue: [
		^ ViennaNode
			  label: 'AccessFunctionDefinition'
			  with: (ViennaNode label: 'Access')
			  with: self ].
	(#( 'ExplicitFunctionDefinition' 'ImplicitFunctionDefinition' )
		 includes: self label) ifTrue: [
		^ (ViennaNode label: 'FunctionDefinition' with: self)
			  asAccessDefinition ].
	self label = 'OperationDefinition' ifTrue: [
		^ ViennaNode
			  label: 'AccessOperationDefinition'
			  with: (ViennaNode label: 'Access')
			  with: self ].
	(#( 'ExplicitOperationDefinition' 'ImplicitOperationDefinition' )
		 includes: self label) ifTrue: [
		^ (ViennaNode label: 'OperationDefinition' with: self)
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

	(#( 'TypeDefinition' 'RecordTypeDefinition' ) includes: self label)
		ifTrue: [
			^ ViennaNode
				  label: 'TypeStructExport'
				  with: (ViennaLocalNameNode identifier: self first) ].
	(#( 'ValueDefinition' ) includes: self label) ifTrue: [
		^ ViennaNode
			  label: 'ValueExport'
			  with: (ViennaNode
					   label: 'NameList'
					   withAll: (self first patternIdentifiers collect: [ :node |
							    ViennaLocalNameNode identifier: node first ]))
			  with: (self first isViennaPatternIdentifierNode
					   ifTrue: [ self second ifNotNil: #copyFragment ]
					   ifFalse: [ nil ])
			  with: nil ].
	(#( 'ImplicitFunctionDefinition' 'ExplicitFunctionDefinition' )
		 includes: self label) ifTrue: [
		^ ViennaNode
			  label: 'FunctionExport'
			  with: (ViennaNode
					   label: 'NameList'
					   with: (ViennaLocalNameNode identifier: self first))
			  with: (self second ifNotNil: #copyFragment)
			  with: (self label = 'ExplicitFunctionDefinition'
					   ifTrue: [ self third ifNotNil: #copyFragment ]
					   ifFalse: [
						   ViennaPartialFunctionTypeNode
							   argumentType: self third first pairListToType
							   returnType: self fourth pairListToType ]) ].
	(#( 'ExplicitOperationDefinition' 'ImplicitOperationDefinition' )
		 includes: self label) ifTrue: [
		^ ViennaNode
			  label: 'OperationExport'
			  with: (ViennaNode
					   label: 'NameList'
					   with: (ViennaLocalNameNode identifier: self first))
			  with: (self label = 'ExplicitOperationDefinition'
					   ifTrue: [ self second ifNotNil: #copyFragment ]
					   ifFalse: [
						   ViennaOperationTypeNode
							   argumentType: self second first pairListToType
							   returnType: self third pairListToType ]) ].
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

	(self definitionOfLocalName: self name) ifNotNil: [ :defNode |
		(#( 'ExplicitFunctionDefinition' 'ImplicitFunctionDefinition'
		    'ExplicitOperationDefinition' 'ImplicitOperationDefinition'
		    'TypeDefinition' 'RecordTypeDefinition' ) includes:
			 defNode label) ifTrue: [
			^ (ViennaGlobalNameNode
				   moduleIdentifier: defNode module name
				   identifier: defNode name)
				  parent: parent;
				  yourself ].
		defNode bindHolderNode ifNotNil: [ :bindNode |
			bindNode label = 'ValueDefinition' ifTrue: [
				^ (ViennaGlobalNameNode
					   moduleIdentifier: bindNode module name
					   identifier: defNode name)
					  parent: parent;
					  yourself ] ].
		(#( 'TypeImport' 'ValueImport' 'FunctionImport' 'OperationImport' )
			 includes: defNode label) ifTrue: [
			^ (ViennaGlobalNameNode
				   moduleIdentifier: defNode parent parent parent first
				   identifier: defNode name)
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
		                    with:
		                    (ViennaNode
			                     label: 'ImportModuleSignature'
			                     with: node) ].
	(#( 'TypeDefinition' 'RecordTypeDefinition' ) includes: self label)
		ifTrue: [
			^ importDefinition value:
				  (ViennaNode label: 'ImportTypesSignature' with: (ViennaNode
						    label: 'TypeImport'
						    with:
						    (ViennaTypeNameNode name:
							     (ViennaLocalNameNode identifier: self name))
						    with: nil)) ].
	(#( 'ValueDefinition' ) includes: self label) ifTrue: [
		^ importDefinition value: (ViennaNode
				   label: 'ImportValuesSignature'
				   withAll: (self patternIdentifierNames collect: [ :name |
						    ViennaNode
							    label: 'ValueImport'
							    with: (ViennaLocalNameNode identifier: name)
							    with: (self first isViennaPatternIdentifierNode
									     ifTrue: [ self second ifNotNil: #copyFragment ]
									     ifFalse: [ nil ])
							    with: nil ])) ].
	(#( 'ExplicitFunctionDefinition' 'ImplicitFunctionDefinition' )
		 includes: self label) ifTrue: [
		^ importDefinition value:
			  (ViennaNode label: 'ImportFunctionsSignature' with: (ViennaNode
					    label: 'FunctionImport'
					    with: (ViennaLocalNameNode identifier: self name)
					    with: self second copyFragment
					    with: (self label = 'ExplicitFunctionDefinition'
							     ifTrue: [ self third copyFragment ]
							     ifFalse: [
								     ViennaPartialFunctionTypeNode
									     argumentType: self third first pairListToType
									     returnType: self fourth pairListToType ])
					    with: nil)) ].
	(#( 'ExplicitOperationDefinition' 'ImplicitOperationDefinition' )
		 includes: self label) ifTrue: [
		^ importDefinition value:
			  (ViennaNode label: 'ImportOperationsSignature' with: (ViennaNode
					    label: 'OperationImport'
					    with: (ViennaLocalNameNode identifier: self name)
					    with: (self label = 'ExplicitOperationDefinition'
							     ifTrue: [ self second copyFragment ]
							     ifFalse: [
								     ViennaOperationTypeNode
									     argumentType: self second first pairListToType
									     returnType: self third pairListToType ])
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
ViennaNode >> definitionInDefinitionBlockOfLocalName: aString do: aBlock [

	self first label = 'StateDefinition'
		ifTrue: [
			| state |
			state := self first.
			state first = aString ifTrue: [ ^ aBlock value: self ].
			state second do: [ :field |
				field first = aString ifTrue: [ ^ aBlock value: field ] ] ]
		ifFalse: [
			self first do: [ :def |
				| defItem defLabel |
				defItem := def second.
				defLabel := defItem label.
				(defLabel = 'TypeDefinition' and: [ defItem first = aString ])
					ifTrue: [ ^ aBlock value: defItem ].
				(defLabel = 'RecordTypeDefinition' and: [ defItem first = aString ])
					ifTrue: [ ^ aBlock value: defItem ].
				defLabel = 'ValueDefinition' ifTrue: [
					defItem first
						allDescendantsSuchThat: [ :n |
						n isViennaPatternIdentifierNode: aString ]
						do: [ :n | ^ aBlock value: n ] ].
				defLabel = 'FunctionDefinition' ifTrue: [
					defItem first first = aString ifTrue: [
						^ aBlock value: defItem first ] ].
				defLabel = 'OperationDefinition' ifTrue: [
					defItem first first = aString ifTrue: [
						^ aBlock value: defItem first ] ] ] ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInExplicitFunctionOfLocalName: aString do: aBlock [

	self fifth
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ aBlock value: n ]
]

{ #category : #'accessing-definitions' }
ViennaNode >> definitionInExplicitOperationOfLocalName: aString do: aBlock [

	self fourth
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ aBlock value: n ]
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
ViennaNode >> definitionInModuleOfLocalName: aString do: aBlock [

	self label = 'Module' ifTrue: [
		self third do: [ :defBlock |
			defBlock
				definitionInDefinitionBlockOfLocalName: aString
				do: [ :node | ^ aBlock value: node ] ].
		self second first ifNotNil: [ :imports |
			imports
				definitionInImportsOfLocalName: aString
				do: [ :node | ^ aBlock value: node ] ].
		^ self ].
	(self label = 'Document' and: [ self first label = 'DefinitionBlock' ])
		ifTrue: [
			self do: [ :defBlock |
				defBlock
					definitionInDefinitionBlockOfLocalName: aString
					do: [ :node | ^ aBlock value: node ] ] ]
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

	self label = 'Module' ifTrue: [
		self definitionInModuleOfLocalName: aString do: [ :node | ^ node ] ].
	self label = 'ExplicitFunctionDefinition' ifTrue: [
		self
			definitionInExplicitFunctionOfLocalName: aString
			do: [ :node | ^ node ] ].
	self label = 'ImplicitFunctionDefinition' ifTrue: [
		self
			definitionInImplicitFunctionOfLocalName: aString
			do: [ :node | ^ node ] ].
	self label = 'ExplicitOperationDefinition' ifTrue: [
		self
			definitionInExplicitOperationOfLocalName: aString
			do: [ :node | ^ node ] ].
	self label = 'ImplicitOperationDefinition' ifTrue: [
		self
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
ViennaNode >> detectParent: aBlock ifNone: errorBlock [

	| node |
	node := self parent.
	[ node notNil ] whileTrue: [
		(aBlock value: node) ifTrue: [ ^ node ].
		node := node parent ].
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

	^ false
]

{ #category : #testing }
ViennaNode >> isEmpty [
	^ self size = 0
]

{ #category : #testing }
ViennaNode >> isExportedNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isFunctionNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isLocalValueNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isOperationNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isStateVariableNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isTypeNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isTypeNode [

	^ self class typeLabels includes: self label
]

{ #category : #testing }
ViennaNode >> isValueNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAndNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaApplyNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticAbsNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticDivideNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticIntegerDivisionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticMinusNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticModNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticMultiplicationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticPlusNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaArithmeticRemNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAssignStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaAssignmentDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaBasicTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaBinaryOperatorExpression [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaBindListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaBlockStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCallStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCasesExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCasesStatementAlternativeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCasesStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaCompositionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaConditionalStatementNode [

	^ true
]

{ #category : #testing }
ViennaNode >> isViennaDclStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDefExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDefStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDistributedMapMergeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDistributedSequenceConcatenationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDistributedSetIntersectionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaDistributedSetUnionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaEqualDefinitionListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaEqualDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaEqualNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaErrorStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExists1ExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExistsExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExitStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFieldListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFieldNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFieldPatternListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFieldPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFieldReferenceNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFieldSelectNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFinitePowerSetNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFloorNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaForallExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaFunctionTypeInstantiationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaGlobalNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaGlobalNameNode: aString identifier: anotherString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaGreaterThanNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaGreaterThanOrEqualNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIdentityStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIfExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIfStatementNode [

	^ true
]

{ #category : #testing }
ViennaNode >> isViennaImplyNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaInSetNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIndexForLoopNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaInitialisationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaInmapTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIotaExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIsBasicExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIsNameExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIsNotYetSpecifiedNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaIterateNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLambdaExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLessThanNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLessThanOrEqualNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLetBeExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLetBeStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLetExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLetNode [

	^ self isViennaLetExpressionNode or: [ self isViennaLetStatementNode ]
]

{ #category : #testing }
ViennaNode >> isViennaLetStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLocalDefinitionListNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLocalDefinitionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLocalNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLocalNameNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaLogicalEquivalenceNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapComprehensionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapDomainNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapDomainRestrictedByNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapDomainRestrictedToNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapEnumerationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapEnumerationPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapInverseNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapMergeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapMunionPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapOrSequenceModifyNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapOrSequenceReferenceNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapRangeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapRangeRestrictedByNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapRangeRestrictedToNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMapletPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMatchValueNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaMultipleAssignStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaNode [
	^ true
]

{ #category : #testing }
ViennaNode >> isViennaNondeterministicStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaNotEqualNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaNotInSetNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaNotNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOldNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOperationTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOptionalTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaOrNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPartialFunctionTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPatternIdentifierNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPatternIdentifierNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaPreconditionExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaProductTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaProperSubsetNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaQuoteTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaRecordConstructorNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaRecordModifierNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaRecordPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaResultExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaReturnStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSeq1TypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSeqBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSeqConcPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSeqEnumPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSeqTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceComprehensionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceConcatenateNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceElementsNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceEnumerationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceForLoopNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceHeadNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceIndicesNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceLengthNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceReverseNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSequenceTailNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSet1TypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetCardinalityNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetComprehensionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetDifferenceNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetEnumPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetEnumerationNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetForLoopNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetIntersectionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetRangeExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetSeqBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetUnionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSetUnionPatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSubsequenceNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSubsetNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaSymbolicLiteralNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTixeStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTokenConstructorNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTotalFunctionTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTrapStatementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTupleConstructorNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTuplePatternNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTupleSelectNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeBindNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeJudgementNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeNameNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeNode [

	^ true
]

{ #category : #testing }
ViennaNode >> isViennaTypeVariableIdentifierNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeVariableIdentifierNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeVariableNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaTypeVariableNode: aString [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaUnaryMinusNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaUnaryOperatorExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaUnaryPlusNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaUndefinedExpressionNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaUnionTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaUnitTypeNode [

	^ false
]

{ #category : #testing }
ViennaNode >> isViennaWhileLoopNode [

	^ false
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

	self allDescendantsDo: [ :n |
		n isViennaLocalNameNode ifTrue: [ ^ n ] ]
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

	(#( 'FunctionDefinition' 'OperationDefinition' ) includes: self label)
		ifTrue: [ ^ self first name ].
	(#( 'Module' 'ImportDefinition' 'TypeDefinition' 'RecordTypeDefinition'
	    'ExplicitFunctionDefinition' 'ExplicitOperationDefinition'
	    'ImplicitFunctionDefinition' 'ImplicitOperationDefinition'
	    'StateDefinition' ) includes: self label) ifTrue: [ ^ self first ].
	(#( 'AccessTypeDefinition' 'AccessValueDefinition'
	    'AccessFunctionDefinition' 'AccessOperationDefinition' )
		 includes: self label) ifTrue: [ ^ self second name ].
	self label = 'TypeImport' ifTrue: [ ^ self first first first ].
	(#( 'ValueImport' 'FunctionImport' 'OperationImport' ) includes:
		 self label) ifTrue: [ ^ self first first ].
	self label = 'TypeDefinitions' ifTrue: [ ^ 'types' ].
	self label = 'ValueDefinitions' ifTrue: [ ^ 'values' ].
	self label = 'FunctionDefinitions' ifTrue: [ ^ 'functions' ].
	self label = 'OperationDefinitions' ifTrue: [ ^ 'operations' ].
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

	^ ((2 to: self size by: 2) collect: [ :index |
		   (self at: index) copyFragment ])
		  ifEmpty: [ ViennaUnitTypeNode new ]
		  ifNotEmpty: [ :types |
			  types size = 1
				  ifTrue: [ types first ]
				  ifFalse: [ ViennaProductTypeNode withAll: types ] ]
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

	^ Array streamContents: [ :stream |
		  self
			  allDescendantsSuchThat: [ :node |
			  node isViennaPatternIdentifierNode ]
			  do: [ :node | stream nextPut: node ] ]
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
		nextPutAll: self label asString;
		nextPut: Character space.
	substrings := self collect: #printString.
	((substrings contains: [ :string | string includes: Character cr ])
		 or: [ ({ 0 } , (substrings collect: #size)) sum > 50 ])
		ifTrue: [
			substrings do: [ :string |
				aStream nextPut: Character cr.
				string lines
					do: [ :line |
						aStream
							nextPutAll: '  ';
							nextPutAll: line ]
					separatedBy: [ aStream nextPut: Character cr ] ] ]
		ifFalse: [
			substrings
				do: [ :string | aStream nextPutAll: string ]
				separatedBy: [ aStream nextPut: Character space ] ].
	aStream nextPut: $)
]

{ #category : #enumerating }
ViennaNode >> referenceNodesDo: aBlock [

	self
		allDescendantsSuchThat: [ :node |
		node isViennaNameNode or: [ node isViennaOldNameNode ] ]
		do: aBlock
]

{ #category : #'adding/removing' }
ViennaNode >> remove: anObject [

	| array |
	array := self asArray copyWithout: anObject.
	self become: ((self class new: array size label: self label)
			 parent: parent;
			 start: start end: end;
			 yourself).
	1 to: array size do: [ :index |
	self at: index put: (array at: index) ].
	^ anObject
]

{ #category : #'adding/removing' }
ViennaNode >> removeAfterIndex: anInteger [

	| array |
	array := self asArray copyFrom: 1 to: anInteger - 1.
	self become: ((self class new: array size label: self label)
			 parent: parent;
			 start: start end: end;
			 yourself).
	1 to: array size do: [ :index |
	self at: index put: (array at: index) ].
	^ anInteger
]

{ #category : #'adding/removing' }
ViennaNode >> removeAll: aCollection [

	| array |
	array := self asArray copyWithoutAll: aCollection.
	self become: ((self class new: array size label: self label)
			 parent: parent;
			 start: start end: end;
			 yourself).
	1 to: array size do: [ :index |
	self at: index put: (array at: index) ].
	^ aCollection
]

{ #category : #'adding/removing' }
ViennaNode >> removeAnnotation: aString [

	annotations ifNotNil: [ 
		annotations := annotations copyWithout: aString.
		annotations ifEmpty: [ annotations := nil ] ].
	^ aString
]

{ #category : #'accessing-definitions' }
ViennaNode >> resolve [

	(#( 'TypeDefinition' 'RecordTypeDefinition' 'ValueDefinition'
	    'ExplicitFunctionDefinition' 'ImplicitFunctionDefinition'
	    'ExplicitOperationDefinition' 'ImplicitOperationDefinition' )
		 includes: self label) ifTrue: [ ^ self ].
	(#( 'FunctionDefinition' 'OperationDefinition' ) includes: self label)
		ifTrue: [ ^ self first ].
	(#( 'AccessTypeDefinition' 'AccessValueDefinition'
	    'AccessFunctionDefinition' 'AccessOperationDefinition' )
		 includes: self label) ifTrue: [ ^ self second resolve ].
	^ nil
]

{ #category : #'accessing-definitions' }
ViennaNode >> resolveLocalName: aString [

	(self definitionOfLocalName: aString) ifNotNil: [ :defNode |
		(#( 'ExplicitFunctionDefinition' 'ImplicitFunctionDefinition'
		    'ExplicitOperationDefinition' 'ImplicitOperationDefinition'
		    'TypeDefinition' 'RecordTypeDefinition' ) includes:
			 defNode label) ifTrue: [ ^ defNode ].
		(#( 'TypeImport' 'ValueImport' 'FunctionImport' 'OperationImport' )
			 includes: defNode label) ifTrue: [
			(self moduleNamed:
				 (defNode parentLabelled: 'ImportDefinition' ifAbsent: [ ^ nil ])
					 first) ifNotNil: [ :moduleNode |
				moduleNode == self module ifFalse: [
					^ moduleNode resolveLocalName: (defNode label = 'TypeImport'
							   ifTrue: [ defNode first first first ]
							   ifFalse: [ defNode first first ]) ] ].
			^ nil ].
		(defNode isViennaFieldNode and: [
			 defNode parent parent label = 'StateDefinition' ]) ifTrue: [
			^ defNode parent parent ].
		defNode bindHolderNode ifNotNil: [ :bindNode |
			bindNode label = 'ValueDefinition' ifTrue: [ ^ bindNode ] ] ].
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

	aViennaNode isViennaNode ifFalse: [ ^ false ].
	self label = aViennaNode label ifFalse: [ ^ false ].
	self size = aViennaNode size ifFalse: [ ^ false ].
	1 to: self size do: [ :index |
		| n1 n2 |
		n1 := self at: index.
		n2 := aViennaNode at: index.
		(n1 isViennaNode
			 ifTrue: [ n1 sameAs: n2 ]
			 ifFalse: [ n1 = n2 ]) ifFalse: [ ^ false ] ].
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
	self label storeOn: aStream.
	aStream nextPutAll: ' withAll: {'.
	(1 to: self size)
		do: [ :index | (self at: index) storeOn: aStream ]
		separatedBy: [ aStream nextPutAll: ' . ' ].
	aStream nextPutAll: '} annotations: '.
	annotations storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
ViennaNode >> third [
	^ self at: 3
]

{ #category : #enumerating }
ViennaNode >> variableExpressionNodesDo: aBlock [

	self allDescendantsDo: [ :node |
		(node isViennaOldNameNode or: [
			 node isViennaNameNode and: [
				 (node isValueNameNode or: [ node isFunctionNameNode ]) not ] ])
			ifTrue: [ aBlock value: node ] ]
]
