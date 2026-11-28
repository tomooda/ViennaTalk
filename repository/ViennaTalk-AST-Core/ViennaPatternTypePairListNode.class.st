Class {
	#name : 'ViennaPatternTypePairListNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'accessing' }
ViennaPatternTypePairListNode >> arity [

	^ (1 to: self size by: 2) inject: 0 into: [ :sum :index | sum + (self at: index) ]
]

{ #category : 'private' }
ViennaPatternTypePairListNode >> boundIdentifiersDo: aBlock [

	1 to: self size by: 2 do: [ :index |
	(self at: index) boundIdentifiersDo: aBlock ]
]

{ #category : 'pretty printing' }
ViennaPatternTypePairListNode >> formatWith: aViennaAbstractFormatter [

	| string |
	string := aViennaAbstractFormatter empty ++ '('.
	self ifNotEmpty: [
			1 to: self size - 2 by: 2 do: [ :index |
					string := string ++ (aViennaAbstractFormatter format: (self at: index)) ++ ':'
					          ++ (aViennaAbstractFormatter format: (self at: index + 1)) ++ ', ' ].
			string := string ++ (aViennaAbstractFormatter format: (self at: self size - 1)) ++ ':'
			          ++ (aViennaAbstractFormatter format: (self at: self size)) ].
	string := string ++ ')'.
	^ string
]

{ #category : 'private' }
ViennaPatternTypePairListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :patternOrType |
		patternOrType freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaPatternTypePairListNode >> isViennaPatternTypePairListNode [

	^ true
]

{ #category : 'accessing' }
ViennaPatternTypePairListNode >> label [

	^ 'PatternTypePairList'
]

{ #category : 'private' }
ViennaPatternTypePairListNode >> listDelimiter [

	^ ', '
]

{ #category : 'typechecking' }
ViennaPatternTypePairListNode >> maximalType [

	^ ViennaType product: ((1 to: self size by: 2) collect: [ :index |
			   | pattern type |
			   pattern := self at: index.
			   type := self at: index + 1.
			   pattern maximalType: type typecheck.
			   pattern typecheck ])
]

{ #category : 'private' }
ViennaPatternTypePairListNode >> parameters [

	^ (ViennaParametersNode withAll:
		   ((1 to: self size by: 2) collect: [ :index |
			    (self at: index) copyFragment ])) parent: parent
]

{ #category : 'enumerating' }
ViennaPatternTypePairListNode >> patternsDo: aBlock [

	1 to: self size by: 2 do: [ :index | aBlock value: (self at: index) ]
]

{ #category : 'accessing' }
ViennaPatternTypePairListNode >> type [

	^ ((Array streamContents: [ :stream |
			    1 to: self size by: 2 do: [ :index |
				    (self at: index) size timesRepeat: [ stream nextPut: (self at: index + 1) copyFragment ] ] ])
		   ifEmpty: [ ViennaUnitTypeNode new ]
		   ifNotEmpty: [ :types |
				   types size = 1
					   ifTrue: [ types first ]
					   ifFalse: [ ViennaProductTypeNode withAll: types ] ])
		  parent: parent;
		  yourself
]
