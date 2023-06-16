Class {
	#name : #ViennaModuleNode,
	#superclass : #ViennaAbstractSyntaxNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaModuleNode class >> identifier: aString interface: aViennaInterfaceNode moduleBody: aViennaModuleBodyNode [

	^ (self new: 3)
		  identifier: aString;
		  interface: aViennaInterfaceNode;
		  moduleBody: aViennaModuleBodyNode;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaModuleNode >> definitionOfLocalName: aString [

	self moduleBody do: [ :defBlock |
		defBlock first isViennaStateDefinitionNode
			ifTrue: [
				| state |
				state := defBlock first.
				state identifier = aString ifTrue: [ ^ defBlock ].
				state fieldList do: [ :field |
					field identifier = aString ifTrue: [ ^ field ] ] ]
			ifFalse: [
				defBlock first do: [ :def |
					| defItem defLabel |
					defItem := def second.
					defLabel := defItem label.
					(defItem isViennaTypeSynonymNode: aString) ifTrue: [ ^ defItem ].
					(defItem isViennaRecordTypeDefinitionNode: aString) ifTrue: [
						^ defItem ].
					defItem isViennaValueDefinitionNode ifTrue: [
						defItem pattern
							allDescendantsSuchThat: [ :n |
							n isViennaPatternIdentifierNode: aString ]
							do: [ :n | ^ n ] ].
					(defItem isViennaFunctionDefinitionNode: aString) ifTrue: [
						^ defItem definition ].
					(defItem isViennaOperationDefinitionNode: aString) ifTrue: [
						^ defItem definition ] ] ] ].
	self interface importDefinitionList ifNotNil: [ :imports |
		imports do: [ :importDef |
			importDef second isViennaImportModuleSignatureNode ifTrue: [
				importDef second do: [ :imps |
					imps do: [ :import |
						(import at: import size) ifNotNil: [ :rename |
							rename first = aString ifTrue: [ ^ import ] ] ] ] ] ] ].
	^ nil
]

{ #category : #'pretty printing' }
ViennaModuleNode >> formatWith: aViennaAbstractFormatter [

	| identifier interface moduleBody |
	identifier := aViennaAbstractFormatter format: self first.
	interface := aViennaAbstractFormatter format: self second.
	moduleBody := self third
		              ifNil: [ '' ]
		              ifNotNil: [ :node |
		              String cr , (aViennaAbstractFormatter format: node) ].
	^ 'module ' , identifier , String cr , interface , moduleBody
	  , String cr , 'end ' , identifier
]

{ #category : #accessing }
ViennaModuleNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaModuleNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #accessing }
ViennaModuleNode >> interface [

	^ self at: 2
]

{ #category : #accessing }
ViennaModuleNode >> interface: aViennaInterfaceNode [

	self at: 2 put: aViennaInterfaceNode
]

{ #category : #testing }
ViennaModuleNode >> isViennaModuleNode [

	^ true
]

{ #category : #testing }
ViennaModuleNode >> isViennaModuleNode: aString [

	^ self identifier = aString
]

{ #category : #testing }
ViennaModuleNode >> label [

	^ 'Module'
]

{ #category : #accessing }
ViennaModuleNode >> moduleBody [

	^ self at: 3
]

{ #category : #accessing }
ViennaModuleNode >> moduleBody: aViennaModuleBodyNode [

	self at: 3 put: aViennaModuleBodyNode
]

{ #category : #testing }
ViennaModuleNode >> shortName [

	^ self identifier
]
