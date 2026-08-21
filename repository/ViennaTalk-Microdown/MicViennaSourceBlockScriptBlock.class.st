"
I am a script block to show VDM-SL specification sources with syntax highlighting.

For example,
```text
 ```vienna-source
 ```
```

will render a specification source for example as follows.
```vdmsl
module Counter
exports all
definitions
state Counter of
    count : nat
init s == s = mk_Counter
end
operations
click : () ==> ()
click() == count := count + 1;
show : () ==> nat
show() == return nat
end Counter
```
"
Class {
	#name : 'MicViennaSourceBlockScriptBlock',
	#superclass : 'MicScriptBlock',
	#instVars : [
		'presenter'
	],
	#category : 'ViennaTalk-Microdown',
	#package : 'ViennaTalk-Microdown'
}

{ #category : 'accessing' }
MicViennaSourceBlockScriptBlock class >> tag [

	^ #'vienna-source'
]

{ #category : 'visiting' }
MicViennaSourceBlockScriptBlock >> accept: aVisitor [

	aVisitor visitViennaSourceBlockScript: self
]

{ #category : 'accessing' }
MicViennaSourceBlockScriptBlock >> moduleName [

	^ arguments at: #module ifAbsent: [ nil ]
]

{ #category : 'private' }
MicViennaSourceBlockScriptBlock >> retrievePresenter [

	presenter := ViennaMicrodownPresenterRequest signal
]

{ #category : 'accessing' }
MicViennaSourceBlockScriptBlock >> sourceText [

	^ self specification
		  ifNotNil: [ :specification |
				  self moduleName
					  ifNotNil: [ :moduleName |
						  (specification moduleNamed: moduleName)
							  ifNotNil: #highlightedSource
							  ifNil: [ '-- no module named ' , moduleName , ' --' asText ] ]
					  ifNil: [ specification highlightedSource ] ]
		  ifNil: [ '-- specification not available --' ]
]

{ #category : 'accessing' }
MicViennaSourceBlockScriptBlock >> specification [

	^ (presenter ifNotNil: #transpiledSpecification) ifNotNil: #specification
]
