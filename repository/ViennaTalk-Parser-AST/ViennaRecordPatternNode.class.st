Class {
	#name : #ViennaRecordPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaRecordPatternNode class >> name: aViennaNameNode patternList: aViennaPatternListNode [

	^ (self new: 2)
		  name: aViennaNameNode;
		  patternList: aViennaPatternListNode;
		  yourself
]

{ #category : #private }
ViennaRecordPatternNode >> boundIdentifiersDo: aBlock [

	self patternList boundIdentifiersDo: aBlock
]

{ #category : #'pretty printing' }
ViennaRecordPatternNode >> formatWith: aViennaAbstractFormatter [

	| constructor patternList |
	constructor := aViennaAbstractFormatter format: self name.
	patternList := aViennaAbstractFormatter format: self patternList.
	^ 'mk_' , constructor , '('
	  ,
		  ((aViennaAbstractFormatter needsIndent: constructor , patternList)
			   ifTrue: [
				   String cr , aViennaAbstractFormatter indent
				   , (aViennaAbstractFormatter indentString: patternList) ]
			   ifFalse: [ patternList ]) , ')'
]

{ #category : #private }
ViennaRecordPatternNode >> freeIdentifiersExcept: aSet do: aBlock [

	self name freeIdentifiersExcept: aSet do: aBlock.
	self patternList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaRecordPatternNode >> isViennaRecordPatternNode [

	^ true
]

{ #category : #accessing }
ViennaRecordPatternNode >> label [

	^ 'RecordPattern'
]

{ #category : #typechecking }
ViennaRecordPatternNode >> maximalType [

	^ self name resolve typecheck
]

{ #category : #typechecking }
ViennaRecordPatternNode >> maximalType: aViennaType [

	aViennaType possibleTypesDo: [ :type |
		self maximalType = aViennaType ifTrue: [
			1 to: self patternList size do: [ :index |
				(self patternList at: index) maximalType:
					(aViennaType basetypeAt: index) ] ] ].
	super maximalType: self maximalType
]

{ #category : #accessing }
ViennaRecordPatternNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaRecordPatternNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]

{ #category : #accessing }
ViennaRecordPatternNode >> patternList [

	^ self at: 2
]

{ #category : #accessing }
ViennaRecordPatternNode >> patternList: aViennaPatternListNode [

	self at: 2 put: aViennaPatternListNode
]
