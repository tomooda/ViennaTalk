Class {
	#name : 'ViennaConcurrentCombinatorialGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaConcurrentCombinatorialGeneratorTest >> testNext [

                | env result generator |
                env := {
                          ('x' -> 1).
                          ('y' -> 2) } asDictionary.
                result := OrderedCollection new.
                generator := ViennaConcurrentCombinatorialGenerator
                                withAll: {
                                      (ViennaBlockCombinatorialGenerator
                                          on: [ :e |
                                          result add: (e at: 'x') ]).
                                      (ViennaBlockCombinatorialGenerator
                                          on: [ :e |
                                          result add: (e at: 'y') ]) }.
                self assert: (generator next: env).
                self assert: result asArray equals: #( 1 2 ).
                result := OrderedCollection new.
                self deny: (generator next: env).
                self assert: result asArray equals: #( 2 1 )
]

{ #category : 'tests' }
ViennaConcurrentCombinatorialGeneratorTest >> testStep [

                | env generator result |
                env := {
                          ('x' -> 1).
                          ('y' -> 2) } asDictionary.
                generator := ViennaConcurrentCombinatorialGenerator
                                withAll: {
                                      (ViennaBlockCombinatorialGenerator
                                          on: [ :e |
                                          result := e at: 'x' ]).
                                      (ViennaBlockCombinatorialGenerator
                                          on: [ :e |
                                          result := e at: 'y' ]) }.
                result := nil.
                self assert: (generator step: env).
                self deny: (generator step: env)
]

{ #category : 'tests' }
ViennaConcurrentCombinatorialGeneratorTest >> testValue [

                | env result generator |
                env := {
                          ('x' -> 1).
                          ('y' -> 2) } asDictionary.
                result := OrderedCollection new.
                generator := ViennaConcurrentCombinatorialGenerator
                                withAll: {
                                      (ViennaBlockCombinatorialGenerator
                                          on: [ :e |
                                          result add: (e at: 'x') ]).
                                      (ViennaBlockCombinatorialGenerator
                                          on: [ :e |
                                          result add: (e at: 'y') ]) }.
                generator value: env.
                self assert: result asArray equals: #( 1 2 ).
                result := OrderedCollection new.
                generator value: env.
                self assert: result asArray equals: #( 1 2 ).
                self assert: (generator step: env).
                result := OrderedCollection new.
                generator value: env.
                self assert: result asArray equals: #( 2 1 )
]
