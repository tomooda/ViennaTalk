Extension { #name : 'ViennaNamedTraceNode' }

{ #category : '*ViennaTalk-Transpiler-Core' }
ViennaNamedTraceNode >> run [

	((ViennaVDM2SmalltalkObject new generate: self document) at:
		 self module identifier) perform: self identifier asSymbol
]

{ #category : '*ViennaTalk-Transpiler-Core' }
ViennaNamedTraceNode >> run: aBlock [

	((ViennaVDM2SmalltalkObject new generate: self document) at:
		 self module identifier)
		perform: (self identifier , ':') asSymbol
		with: aBlock
]

{ #category : '*ViennaTalk-Transpiler-Core' }
ViennaNamedTraceNode >> run: aBlock onError: handlerBlock [

	((ViennaVDM2SmalltalkObject new generate: self document) at:
		 self module identifier)
		perform: (self identifier , ':onError:') asSymbol
		with: aBlock
		with: handlerBlock
]
