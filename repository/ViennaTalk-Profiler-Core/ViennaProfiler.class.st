Class {
	#name : 'ViennaProfiler',
	#superclass : 'Object',
	#instVars : [
		'actLink',
		'rdLink',
		'wrLink',
		'env',
		'act',
		'rd',
		'wr',
		'finLink',
		'fin'
	],
	#category : 'ViennaTalk-Profiler-Core',
	#package : 'ViennaTalk-Profiler-Core'
}

{ #category : 'profiling' }
ViennaProfiler class >> act: aCollectionOfNameAndModuleObjectAndSelector fin: anotherCollectionOfNameAndModuleObjectAndSelector rd: aCollectionOfNameAndModuleObjectAndVariable wr: anotherCollectionOfNameAndModuleObjectAndVariable do: aBlock [

	^ self new
		  act: aCollectionOfNameAndModuleObjectAndSelector
		  fin: anotherCollectionOfNameAndModuleObjectAndSelector
		  rd: aCollectionOfNameAndModuleObjectAndVariable
		  wr: anotherCollectionOfNameAndModuleObjectAndVariable
		  do: aBlock
]

{ #category : 'profiling' }
ViennaProfiler >> act: aCollectionOfNameAndModuleObjectAndSelector fin: anotehrCollectionOfNameAndModuleObjectAndSelector rd: aCollectionOfNameAndModuleObjectAndVariable wr: anotherCollectionOfNameAndModuleObjectAndVariable do: aBlock [

	[
	self
		installAct: aCollectionOfNameAndModuleObjectAndSelector
		fin: anotehrCollectionOfNameAndModuleObjectAndSelector
		rd: aCollectionOfNameAndModuleObjectAndVariable
		wr: anotherCollectionOfNameAndModuleObjectAndVariable.
	aBlock
		on: ViennaProfilingException
		do: [ :ex | ex resume: (ex value: self) ] ] ensure: [
		self uninstall ]
]

{ #category : 'private' }
ViennaProfiler >> countAct: context [

	act add: {
			context receiver class.
			context selector }
]

{ #category : 'private' }
ViennaProfiler >> countFin: context [

	fin add: {
			context receiver class.
			context selector }
]

{ #category : 'private' }
ViennaProfiler >> countRd: node [

	rd add: {
			node variable owningClass.
			node name }
]

{ #category : 'private' }
ViennaProfiler >> countWr: node [

	wr add: {
			node variable owningClass.
			node name }
]

{ #category : 'initialization' }
ViennaProfiler >> initialize [

	super initialize.
	actLink := MetaLink new
		           metaObject: self;
		           selector: #countAct:;
		           arguments: #( context );
		           control: #before;
		           yourself.
	finLink := MetaLink new
		           metaObject: self;
		           selector: #countFin:;
		           arguments: #( context );
		           control: #after;
		           yourself.
	rdLink := MetaLink new
		          metaObject: self;
		          selector: #countRd:;
		          arguments: #( node );
		          control: #before;
		          yourself.
	wrLink := MetaLink new
		          metaObject: self;
		          selector: #countWr:;
		          arguments: #( node );
		          control: #before;
		          yourself.
	env := Dictionary new.
	act := Bag new.
	fin := Bag new.
	rd := Bag new.
	wr := Bag new
]

{ #category : 'reflectivity' }
ViennaProfiler >> installAct: aCollectionOfNameAndModuleObjectAndSelector fin: anotherCollectionOfNameAndModuleObjectAndSelector rd: aCollectionOfNameAndModuleObjectAndVariable wr: anotherCollectionOfNameAndModuleObjectAndVariable [

	aCollectionOfNameAndModuleObjectAndSelector do: [ :triple |
		(triple second class lookupSelector: triple third) ifNotNil: [
			:method |
			env at: triple first put: {
					triple second class.
					triple third }.
			method ast link: actLink ] ].
	anotherCollectionOfNameAndModuleObjectAndSelector do: [ :triple |
		(triple second class lookupSelector: triple third) ifNotNil: [
			:method |
			env at: triple first put: {
					triple second class.
					triple third }.
			method ast link: finLink ] ].
	aCollectionOfNameAndModuleObjectAndVariable do: [ :triple |
		| class var |
		class := triple second class.
		var := triple third.
		class slotNamed: var ifFound: [ :slot |
			env at: triple first put: {
					triple second class.
					triple third }.
			class methods do: [ :method |
				(method selector beginsWith: '_') ifTrue: [
					method instanceVariableReadNodes do: [ :node |
						node name = var ifTrue: [ node link: rdLink ] ] ] ] ] ].
	anotherCollectionOfNameAndModuleObjectAndVariable do: [ :triple |
		| class var |
		class := triple second class.
		var := triple third.
		class slotNamed: var ifFound: [ :slot |
			env at: triple first put: {
					triple second class.
					triple third }.
			class methods do: [ :method |
				method instanceVariableWriteNodes do: [ :node |
					node name = var ifTrue: [ node link: wrLink ] ] ] ] ]
]

{ #category : 'accessing' }
ViennaProfiler >> numAct: opName module: moduleName [

	^ act occurrencesOf: (env
			   at: {
					   moduleName.
					   opName }
			   ifAbsent: [ ^ 0 ])
]

{ #category : 'accessing' }
ViennaProfiler >> numFin: opName module: moduleName [

	^ fin occurrencesOf: (env
			   at: {
					   moduleName.
					   opName }
			   ifAbsent: [ ^ 0 ])
]

{ #category : 'accessing' }
ViennaProfiler >> numRd: varName module: moduleName [

	^ rd occurrencesOf: (env
			   at: {
					   moduleName.
					   varName }
			   ifAbsent: [ ^ 0 ])
]

{ #category : 'accessing' }
ViennaProfiler >> numWr: varName module: moduleName [

	^ wr occurrencesOf: (env
			   at: {
					   moduleName.
					   varName }
			   ifAbsent: [ ^ 0 ])
]

{ #category : 'reflectivity' }
ViennaProfiler >> uninstall [

	actLink uninstall.
	finLink uninstall.
	rdLink uninstall.
	wrLink uninstall
]
