"
A ViennaBindCombinatorialGeneratorTest is a test class for testing the behavior of ViennaBindCombinatorialGenerator
"
Class {
	#name : 'ViennaLetBestCombinatorialGeneratorTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Transpiler-Tests',
	#package : 'ViennaTalk-Transpiler-Tests'
}

{ #category : 'tests' }
ViennaLetBestCombinatorialGeneratorTest >> testNext [

	| rootEnv env generator result |
	rootEnv := { ('a' -> 1) } asDictionary.
	generator := ViennaLetBestCombinatorialGenerator
		             multibind: {
				             (ViennaBindCombinatorialGenerator
					              withAll: { 1. 2 }
					              bindBlock: [ :e :v |
					              { { ('x' -> v) } asDictionary } ]).
				             (ViennaBindCombinatorialGenerator
					              withAll: { 1. 2 }
					              bindBlock: [ :e :v |
					              { { ('y' -> v) } asDictionary } ]) }
		             suchthat: [ :e | (e at: 'x') < (e at: 'y') ]
		             in:
			             (ViennaAlternativeCombinatorialGenerator withAll: {
					              (ViennaCallCombinatorialGenerator on: [ :e |
						               e at: 'a' put: 100.
						               result := {
							                         (e at: 'x').
							                         (e at: 'y').
							                         1 } ]).
					              (ViennaCallCombinatorialGenerator on: [ :e |
						               e at: 'a' put: 200.
						               result := {
							                         (e at: 'x').
							                         (e at: 'y').
							                         2 } ]) }).

	env := rootEnv copy.
	self assert: (generator next: env).
	self assert: result equals: { 1. 2. 1 }.
	env := rootEnv copy.
	self deny: (generator next: env).
	self assert: result equals: { 1. 2. 2 }
]

{ #category : 'tests' }
ViennaLetBestCombinatorialGeneratorTest >> testStep [

	| rootEnv env generator result |
	rootEnv := { ('a' -> 1) } asDictionary.
	generator := ViennaLetBestCombinatorialGenerator
		             multibind: {
				             (ViennaBindCombinatorialGenerator
					              withAll: { 1. 2 }
					              bindBlock: [ :e :v |
					              { { ('x' -> v) } asDictionary } ]).
				             (ViennaBindCombinatorialGenerator
					              withAll: { 1. 2 }
					              bindBlock: [ :e :v |
					              { { ('y' -> v) } asDictionary } ]) }
		             suchthat: [ :e | (e at: 'x') < (e at: 'y') ]
		             in:
			             (ViennaAlternativeCombinatorialGenerator withAll: {
					              (ViennaCallCombinatorialGenerator on: [ :e |
						               e at: 'a' put: 100.
						               result := {
							                         (e at: 'x').
							                         (e at: 'y').
							                         1 } ]).
					              (ViennaCallCombinatorialGenerator on: [ :e |
						               e at: 'a' put: 200.
						               result := {
							                         (e at: 'x').
							                         (e at: 'y').
							                         2 } ]) }).

	env := rootEnv copy.
	self assert: (generator step: env).
	env := rootEnv copy.
	self deny: (generator step: env)
]

{ #category : 'tests' }
ViennaLetBestCombinatorialGeneratorTest >> testValue [

	| env generator result |
	env := { ('a' -> 1) } asDictionary.
	generator := ViennaLetBestCombinatorialGenerator
		             multibind: {
				             (ViennaBindCombinatorialGenerator
					              withAll: { 1. 2 }
					              bindBlock: [ :e :v |
					              { { ('x' -> v) } asDictionary } ]).
				             (ViennaBindCombinatorialGenerator
					              withAll: { 1. 2 }
					              bindBlock: [ :e :v |
					              { { ('y' -> v) } asDictionary } ]) }
		             suchthat: [ :e | (e at: 'x') < (e at: 'y') ]
		             in:
			             (ViennaAlternativeCombinatorialGenerator withAll: {
					              (ViennaCallCombinatorialGenerator on: [ :e |
						               e at: 'a' put: 100.
						               result := {
							                         (e at: 'x').
							                         (e at: 'y').
							                         1 } ]).
					              (ViennaCallCombinatorialGenerator on: [ :e |
						               e at: 'a' put: 200.
						               result := {
							                         (e at: 'x').
							                         (e at: 'y').
							                         2 } ]) }).

	generator value: env copy.
	self assert: result equals: { 1. 2. 1 }.
	generator value: env copy.
	self assert: result equals: { 1. 2. 1 }.
	self assert: (generator step: env copy).
	generator value: env copy.
	self assert: result equals: { 1. 2. 2 }
]
