Class {
	#name : #ViennaOldNameNode,
	#superclass : #ViennaLocalNameNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaOldNameNode class >> identifier: aString [

	^ (self new: 1)
		  identifier: aString;
		  yourself
]

{ #category : #'pretty printing' }
ViennaOldNameNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter identifier: self identifier)
	  ++ (aViennaAbstractFormatter keyword: '~')
]

{ #category : #testing }
ViennaOldNameNode >> isAssignable [

	^ false
]

{ #category : #testing }
ViennaOldNameNode >> isBlockVariableNameNode [

	^ false
]

{ #category : #testing }
ViennaOldNameNode >> isExportedNameNode [

	^ false
]

{ #category : #testing }
ViennaOldNameNode >> isFunctionNameNode [

	^ false
]

{ #category : #testing }
ViennaOldNameNode >> isLocalValueNameNode [

	^ false
]

{ #category : #testing }
ViennaOldNameNode >> isOperationNameNode [

	^ false
]

{ #category : #testing }
ViennaOldNameNode >> isStateVariableNameNode [

	^ true
]

{ #category : #testing }
ViennaOldNameNode >> isTypeNameNode [

	^ false
]

{ #category : #testing }
ViennaOldNameNode >> isValueNameNode [

	^ false
]

{ #category : #testing }
ViennaOldNameNode >> isViennaOldNameNode [

	^ true
]

{ #category : #accessing }
ViennaOldNameNode >> label [

	^ 'OldName'
]
