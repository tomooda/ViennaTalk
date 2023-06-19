Class {
	#name : #ViennaAccessValueDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaAccessValueDefinitionNode class >> access: aViennaAccessNode valueDefinition: aViennaValueDefinitionNode [

	^ (self new: 2)
		  access: aViennaAccessNode;
		  valueDefinition: aViennaValueDefinitionNode;
		  yourself
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> access [

	^ self at: 1
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : #private }
ViennaAccessValueDefinitionNode >> boundIdentifiersInto: aSet [

	self valueDefinition boundIdentifiersInto: aSet
]

{ #category : #'pretty printing' }
ViennaAccessValueDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ' '
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #testing }
ViennaAccessValueDefinitionNode >> isViennaAccessValueDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> label [

	^ 'AccessValueDefinition'
]

{ #category : #'accessing-definitions' }
ViennaAccessValueDefinitionNode >> resolve [

	^ self valueDefinition resolve
]

{ #category : #'accessing-definitions' }
ViennaAccessValueDefinitionNode >> shortName [

	^ self valueDefinition shortName
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> valueDefinition [

	^ self at: 2
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> valueDefinition: aViennaValueDefinitionNode [

	self at: 2 put: aViennaValueDefinitionNode
]
