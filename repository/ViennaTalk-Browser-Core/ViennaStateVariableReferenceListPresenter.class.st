Class {
	#name : 'ViennaStateVariableReferenceListPresenter',
	#superclass : 'ViennaReferenceListPresenter',
	#category : 'ViennaTalk-Browser-Core-Browsers',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Browsers'
}

{ #category : 'testing' }
ViennaStateVariableReferenceListPresenter class >> isAbstract [

	^ self == ViennaStateVariableReferenceListPresenter
]

{ #category : 'private' }
ViennaStateVariableReferenceListPresenter >> createGlobalNames [

	| last |
	last := nil.
	^ Array streamContents: [ :stream |
			  target ifNotNil: [
					  self specification ifNotNil: [ :specification |
							  target module ifNotNil: [ :module |
									  module allDescendantsSuchThat: [ :node | node isViennaNameNode and: [ node isStateVariableNameNode ] ] do: [ :node |
											  ((target isViennaStateDefinitionNode or: [ target identifier = node identifier ]) and: [ self check: node ]) ifTrue: [
													  node topLevelDefinition ifNotNil: [ :def |
															  def globalNamesDo: [ :globalName |
																	  last ~= globalName ifTrue: [
																			  stream nextPut: globalName.
																			  last := globalName ] ] ] ] ] ] ] ] ]
]
