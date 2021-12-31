Class {
	#name : #ViennaAddUnitTestingModule,
	#superclass : #ViennaAddModule,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaAddUnitTestingModule >> findContainerNode [

	^ super findContainerNode ifNotNil: [ :document | 
		  (document moduleNamed: self newName)
			  ifNotNil: [ nil ]
			  ifNil: [ document ] ]
]

{ #category : #accessing }
ViennaAddUnitTestingModule >> findNewName [

	^ 'UnitTesting'
]

{ #category : #accessing }
ViennaAddUnitTestingModule >> name [
	^ 'Add UnitTesting module'
]

{ #category : #accessing }
ViennaAddUnitTestingModule >> sortingOrder [
	^ 0.01
]

{ #category : #accessing }
ViennaAddUnitTestingModule >> sourceWithNewName: aString [

	^ 'module UnitTesting
exports all
definitions
types
     AssertFailure :: msg : seq of char;
     AssertEqualsFailure :: actual : ? expected : ? msg : seq of char;

operations
    assert : bool * seq of char ==> ()
    assert(b, msg) == if not b then exit mk_AssertFailure(msg);
    
    assertEquals : ? * ? * seq of char ==> ()
    assertEquals(actual, expected, msg) ==
        if
            actual <> expected
        then
            exit mk_AssertEqualsFailure(actual, expected, msg);
    
    assertApproxEquals : real * real * real * seq of char ==> ()
    assertApproxEquals(actual, expected, accuracy, msg) ==
        if
            abs (actual - expected) > accuracy
        then
            exit mk_AssertEqualsFailure(actual, expected, msg);

end UnitTesting'
]
