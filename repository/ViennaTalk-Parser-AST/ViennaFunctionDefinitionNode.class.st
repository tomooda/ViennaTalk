Class {
	#name : #ViennaFunctionDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaFunctionDefinitionNode class >> definition: aViennaNode [

	^ (self new: 1)
		  definition: aViennaNode;
		  yourself
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> argumentType [

	^ self definition argumentType
]

{ #category : #'accessing-definitions' }
ViennaFunctionDefinitionNode >> asAccessDefinition [

	^ parent ifNil: [
		  ViennaAccessFunctionDefinitionNode
			  access: ViennaAccessNode empty
			  functionDefinition: self ]
]

{ #category : #private }
ViennaFunctionDefinitionNode >> boundIdentifiersDo: aBlock [

	self definition boundIdentifiersDo: aBlock
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> definition [

	^ self at: 1
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> definition: aViennaNode [

	self at: 1 put: aViennaNode
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> expression [

	^ self definition expression
]

{ #category : #'pretty printing' }
ViennaFunctionDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self definition
]

{ #category : #private }
ViennaFunctionDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self definition freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> identifier [

	^ self definition identifier
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> identifier: aString [

	self definition identifier: aString
]

{ #category : #testing }
ViennaFunctionDefinitionNode >> isFunctionDefinition [

	^ true
]

{ #category : #testing }
ViennaFunctionDefinitionNode >> isViennaFunctionDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaFunctionDefinitionNode >> isViennaFunctionDefinitionNode: aString [

	^ self definition identifier = aString
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> label [

	^ 'FunctionDefinition'
]

{ #category : #'accessing-definitions' }
ViennaFunctionDefinitionNode >> localResolve [

	^ self definition localResolve
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> measure [

	^ self definition measure
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> parametersList [

	^ self definition parametersList
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> post [

	^ self definition post
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> pre [

	^ self definition pre
]

{ #category : #'accessing-definitions' }
ViennaFunctionDefinitionNode >> resolve [

	^ self definition
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> returnType [

	^ self definition returnType
]

{ #category : #'accessing-definitions' }
ViennaFunctionDefinitionNode >> shortName [

	^ self definition shortName
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> type [

	^ self definition type
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> typeVariableList [

	^ self definition typeVariableList
]
