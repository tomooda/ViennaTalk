Class {
	#name : #ViennaVarInformationNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaVarInformationNode class >> mode: aString nameList: aViennaNameListNode type: aViennaTypeNode [

	^ (self new: 3)
		  mode: aString;
		  nameList: aViennaNameListNode;
		  type: aViennaTypeNode;
		  yourself
]

{ #category : #private }
ViennaVarInformationNode >> boundIdentifiersDo: aBlock [

	self nameList do: [ :identifier | aBlock cull: identifier cull: self ]
]

{ #category : #'pretty printing' }
ViennaVarInformationNode >> formatWith: aViennaAbstractFormatter [

	| mode nameList type |
	mode := self mode.
	nameList := aViennaAbstractFormatter format: self nameList.
	type := self type
		        ifNotNil: [ :node |
		        ':' , (aViennaAbstractFormatter format: node) ]
		        ifNil: [ String new ].
	^ mode , ' ' , nameList , type
]

{ #category : #private }
ViennaVarInformationNode >> freeIdentifiersExcept: aSet do: aBlock [

	self type freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaVarInformationNode >> isViennaVarInformationNode [

	^ true
]

{ #category : #accessing }
ViennaVarInformationNode >> label [

	^ 'VarInformation'
]

{ #category : #accessing }
ViennaVarInformationNode >> mode [

	^ self at: 1
]

{ #category : #accessing }
ViennaVarInformationNode >> mode: aString [

	self at: 1 put: aString
]

{ #category : #accessing }
ViennaVarInformationNode >> nameList [

	^ self at: 2
]

{ #category : #accessing }
ViennaVarInformationNode >> nameList: aViennaNameListNode [

	self at: 2 put: aViennaNameListNode
]

{ #category : #accessing }
ViennaVarInformationNode >> type [

	^ self at: 3
]

{ #category : #accessing }
ViennaVarInformationNode >> type: aViennaTypeNode [

	self at: 3 put: aViennaTypeNode
]
