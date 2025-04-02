Extension { #name : 'Morph' }

{ #category : '*ViennaTalk-Launcher-Core' }
Morph >> currentWorld [

	^ self world ifNil: [ super currentWorld ]
]
