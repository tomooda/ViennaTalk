Class {
	#name : 'ViennaModuleNode',
	#superclass : 'ViennaNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaModuleNode class >> identifier: aString [

	^ self
		  identifier: aString
		  interface: (ViennaInterfaceNode
				   importDefinitionList: nil
				   exportDefinition:
					   (ViennaExportDefinitionNode exportModuleSignature:
						    ViennaExportModuleSignatureAllNode new))
		  moduleBody: ViennaModuleBodyNode empty
]

{ #category : 'instance creation' }
ViennaModuleNode class >> identifier: aString interface: aViennaInterfaceNode moduleBody: aViennaModuleBodyNode [

	^ (self new: 3)
		  identifier: aString;
		  interface: aViennaInterfaceNode;
		  moduleBody: aViennaModuleBodyNode;
		  yourself
]

{ #category : 'instance creation' }
ViennaModuleNode class >> identifier: aString moduleBody: aViennaModuleBodyNode [

	^ self
		  identifier: aString
		  interface: ViennaInterfaceNode exportsAll
		  moduleBody: aViennaModuleBodyNode
]

{ #category : 'instance creation' }
ViennaModuleNode class >> unitTesting [

	^ self unitTestingSource asViennaModuleAst
]

{ #category : 'instance creation' }
ViennaModuleNode class >> unitTestingSource [

	^ '
module UnitTesting
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

end UnitTesting
' trim
]

{ #category : 'instance creation' }
ViennaModuleNode class >> viennaDOM [

	^ self viennaDOMSource asViennaDocumentAst
]

{ #category : 'instance creation' }
ViennaModuleNode class >> viennaDOMSource [

	^ 'module ViennaDOM
exports all
definitions
types
     Element = TaggedElement| String;
     TaggedElement ::
        name : String
        attributes : map String to [String| real]
        eventHandlers : set of EventType
        contents : seq of Element
        tokens : set of token
        identifier_ : nat;
     EventType = <click>| <change>;
     Event = MouseEvent| ChangeEvent;
     MouseEvent :: type : EventType target : TaggedElement x : nat y : nat;
     ChangeEvent :: type : EventType target : TaggedElement value : String;
     String = seq of char;
     Point :: x : int y : int;

state DOM of
    current : Element
    nextIdentifier : nat
init s == s = mk_DOM("", 0)
end

operations
    setDocument : Element ==> Element
    setDocument(element) ==
        (current := element;
        return current);
    
    pure document : () ==> Element
    document() == return current;
    
    createElement : String ==> TaggedElement
    createElement(name) ==
        let identifier = nextIdentifier
        in
            (nextIdentifier := nextIdentifier + 1;
            return mk_TaggedElement(name, {|->}, {}, [], {}, identifier));
    
    pure getElements : TaggedElement -> bool ==> seq of Element
    getElements(condition) == return findAll_(current, condition);
    
    pure getElementById : String ==> [TaggedElement]
    getElementById(value) ==
        return find_(
                current,
                lambda element : TaggedElement &
                    getAttribute(element, "id") = value);
    
    pure getElementsByToken : token ==> seq of TaggedElement
    getElementsByToken(target) ==
        return findAll_(
                current,
                lambda element : TaggedElement & target in set element.tokens);
    
    pure getElement : nat ==> [TaggedElement]
    getElement(id) ==
        return find_(
                current, lambda element : TaggedElement & element.identifier_ = id);

functions
    getAttribute : TaggedElement * String -> [String]
    getAttribute(element, attribute) ==
        if
            attribute in set dom element.attributes
        then
            element.attributes(attribute)
        else
            nil;
    
    hasAttribute : TaggedElement * String -> bool
    hasAttribute(element, attribute) ==
        attribute in set dom element.attributes;
    
    getAttributeNames : TaggedElement -> set of Element
    getAttributeNames(element) == dom element.attributes;
    
    removeAttribute : TaggedElement * String -> TaggedElement
    removeAttribute(element, attribute) ==
        mu(element,attributes |-> {attribute} <-: element.attributes);
    
    setAttribute : TaggedElement * String * (String| real| seq of Point) -> TaggedElement
    setAttribute(element, attribute, value) ==
        mu(element,
            attributes
            |-> element.attributes
            ++ {attribute
            |-> if is_(value, seq of Point) then points2string(value) else value});
    
    appendChild : TaggedElement * Element -> TaggedElement
    appendChild(element, child) ==
        mu(element,contents |-> element.contents ^ [child]);
    
    setEventHandler : TaggedElement * EventType -> TaggedElement
    setEventHandler(element, event) ==
        mu(element,eventHandlers |-> element.eventHandlers union {event});
    
    addToken : TaggedElement * token -> TaggedElement
    addToken(element, t) ==
        mu(element,tokens |-> element.tokens union {t});
    
    hasToken : TaggedElement * token -> bool
    hasToken(element, t) == t in set element.tokens;

functions
/*
	 Utility functions for internal use
*/
    digit2string : nat -> String
    digit2string(n) == ["0123456789"(n + 1)];
    
    int2string : int -> String
    int2string(i) ==
        if i < 0
            then "-" ^ int2string(-i)
        elseif i <= 9
            then digit2string(i)
        else
            int2string(i div 10) ^ digit2string(i mod 10);
    
    point2string : Point -> String
    point2string(p) == int2string(p.x) ^ "," ^ int2string(p.y);
    
    points2string : seq of Point -> String
    points2string(ps) ==
        cases ps:
            [] -> "",
            [p] -> point2string(p),
            others -> point2string(hd ps) ^ " " ^ points2string(tl ps)
            end;
    
    find_ : Element * (TaggedElement -> bool) -> [TaggedElement]
    find_(whole, condition) ==
        cases whole:
            mk_TaggedElement(
                name, attributes, eventHandlers, contents, tokens, identifier) ->
                if condition(whole) then whole else findFirst_(contents, condition),
            others -> nil
            end;
    
    findAll_ : Element * (TaggedElement -> bool) -> seq of TaggedElement
    findAll_(whole, condition) ==
        cases whole:
            mk_TaggedElement(
                name, attributes, eventHandlers, contents, tokens, identifier) ->
                (if condition(whole) then [whole] else [])
                ^ conc [findAll_(content, condition) | content in seq contents],
            otherwise -> []
            end;
    
    findFirst_ : seq of Element * (TaggedElement -> bool) -> [TaggedElement]
    findFirst_(elements, condition) ==
        cases elements:
            [] -> nil,
            others ->
                let head = find_(hd elements, condition)
                in
                    (if head <> nil then head else findFirst_(tl elements, condition))
            end
    measure m_findFirst_;
    
    m_findFirst_ : seq of Element * (TaggedElement -> bool) -> nat
    m_findFirst_(elements, condition) == len elements;

end ViennaDOM'
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> addFunctionDefinition: aViennaNode [

	(self moduleBody detect: #isViennaFunctionDefinitionsNode ifNone: [
		 | section |
		 section := ViennaFunctionDefinitionsNode empty.
		 self moduleBody add: section.
		 section ]) add: aViennaNode
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> addImportDefinition: aViennaImportDefinitionNode [

	| interface |
	interface := self interface.
	(interface importDefinitionList ifNil: [
		 | node |
		 node := ViennaImportDefinitionListNode empty.
		 interface importDefinitionList: node.
		 node ]) add: aViennaImportDefinitionNode
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> addNamedTrace: aViennaNode [

	self moduleBody add: aViennaNode
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> addOperationDefinition: aViennaNode [

	(self moduleBody detect: #isViennaOperationDefinitionsNode ifNone: [
		 | section |
		 section := ViennaOperationDefinitionsNode empty.
		 self moduleBody add: section.
		 section ]) add: aViennaNode
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> addTypeDefinition: aViennaNode [

	(self moduleBody detect: #isViennaTypeDefinitionsNode ifNone: [
		 | section |
		 section := ViennaTypeDefinitionsNode empty.
		 self moduleBody add: section.
		 section ]) add: aViennaNode
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> addValueDefinition: aViennaNode [

	(self moduleBody detect: #isViennaValueDefinitionsNode ifNone: [
		 | section |
		 section := ViennaValueDefinitionsNode empty.
		 self moduleBody add: section.
		 section ]) add: aViennaNode
]

{ #category : 'private' }
ViennaModuleNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> deepFindResolverForIdentifier: aString [

	| node |
	node := self lookupIdentifier: aString.
	node ifNil: [ ^ super deepFindResolverForIdentifier: aString ].
	^ node isViennaImportNode
		  ifTrue: [
			  (self moduleNamed: node moduleIdentifier) ifNotNil: [ :module |
				  module deepFindResolverForIdentifier: node identifier ] ]
		  ifFalse: [ self ]
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> definitionOfLocalName: aString [

	(aString beginsWith: 'pre_') ifTrue: [
		| name |
		name := aString copyFrom: 'pre_' size + 1 to: aString size.
		self toplevelDefinitionsDo: [ :def |
			((def isViennaFunctionDefinitionNode: name) or: [
				 def isViennaOperationDefinitionNode: name ]) ifTrue: [
				^ def preFunction ] ] ].
	(aString beginsWith: 'post_') ifTrue: [
		| name |
		name := aString copyFrom: 'post_' size + 1 to: aString size.
		self toplevelDefinitionsDo: [ :def |
			((def isViennaFunctionDefinitionNode: name) or: [
				 def isViennaOperationDefinitionNode: name ]) ifTrue: [
				^ def postFunction ] ] ].
	self sectionsDo: [ :section |
		section isViennaStateDefinitionNode
			ifTrue: [
				section identifier = aString ifTrue: [ ^ section ].
				section fieldList do: [ :field |
					field identifier = aString ifTrue: [ ^ field ] ] ]
			ifFalse: [
				section do: [ :def |
					(def isViennaTypeSynonymNode: aString) ifTrue: [ ^ def ].
					(def isViennaRecordTypeDefinitionNode: aString) ifTrue: [ ^ def ].
					def isViennaValueDefinitionNode ifTrue: [
						def pattern
							allDescendantsSuchThat: [ :n |
							n isViennaPatternIdentifierNode: aString ]
							do: [ :n | ^ n ] ].
					(def isViennaFunctionDefinitionNode: aString) ifTrue: [ ^ def ].
					(def isViennaOperationDefinitionNode: aString) ifTrue: [ ^ def ] ] ] ].
	self interface importDefinitionList ifNotNil: [ :imports |
		imports do: [ :importDef |
			importDef second isViennaImportModuleSignatureNode ifTrue: [
				importDef second do: [ :imps |
					imps do: [ :import |
						(import at: import size) ifNotNil: [ :rename |
							rename first = aString ifTrue: [ ^ import ] ] ] ] ] ] ].
	^ nil
]

{ #category : 'accessing' }
ViennaModuleNode >> exportDefinition [

	^ self interface exportDefinition
]

{ #category : 'testing' }
ViennaModuleNode >> exportsIdentifier: aString [

	^ self exportDefinition exportsIdentifier: aString
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> findResolverForIdentifier: aString [

	self toplevelDefinitionsDo: [ :definition |
		(definition bindsIdentifier: aString) ifTrue: [ ^ self ] ].
	self importDefinitionsDo: [ :importDefinition |
		importDefinition importsDo: [ :import |
			(import rename notNil and: [ import rename identifier = aString ])
				ifTrue: [ ^ self ] ] ].
	^ nil
]

{ #category : 'pretty printing' }
ViennaModuleNode >> formatWith: aViennaAbstractFormatter [

	| identifier interface moduleBody |
	identifier := aViennaAbstractFormatter moduleName: self identifier.
	interface := aViennaAbstractFormatter format: self interface.
	moduleBody := self moduleBody
		              ifNil: [ '' ]
		              ifNotNil: [ :node |
		              String cr ++ (aViennaAbstractFormatter format: node) ].
	^ aViennaAbstractFormatter empty
	  ++ (aViennaAbstractFormatter keyword: 'module ') ++ identifier
	  ++ String cr ++ interface ++ moduleBody ++ String cr
	  ++ (aViennaAbstractFormatter keyword: 'end ') ++ identifier
]

{ #category : 'private' }
ViennaModuleNode >> freeIdentifiersExcept: aSet do: aBlock [

	self moduleBody
		freeIdentifiersExcept:
			aSet , self moduleBody uniqueBoundIdentifiers
			, self uniqueImportedIdentifiers
		do: aBlock
]

{ #category : 'testing' }
ViennaModuleNode >> hasScope [

	^ true
]

{ #category : 'accessing' }
ViennaModuleNode >> identifier [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaModuleNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : 'accessing' }
ViennaModuleNode >> identifiers [

	^ { self identifier }
]

{ #category : 'accessing' }
ViennaModuleNode >> importAtModuleIdentifier: aString identifier: anotherString [

	(self importDefinitionAtModuleIdentifier: aString) ifNotNil: [
		:importDefinition |
		importDefinition importsDo: [ :import |
			import identifier = anotherString ifTrue: [ ^ import ] ] ].
	^ nil
]

{ #category : 'accessing' }
ViennaModuleNode >> importAtModuleIdentifier: aString rename: anotherString [

	(self importDefinitionAtModuleIdentifier: aString) ifNotNil: [
		:importDefinition |
		importDefinition importsDo: [ :import |
			(import rename notNil and: [
				 import rename identifier = anotherString ]) ifTrue: [ ^ import ] ] ].
	^ nil
]

{ #category : 'accessing' }
ViennaModuleNode >> importDefinitionAtModuleIdentifier: aString [

	self interface importDefinitionList ifNotNil: [ :importDefinitionList |
		importDefinitionList do: [ :importDefinition |
			importDefinition moduleIdentifier = aString ifTrue: [
				^ importDefinition ] ] ].
	^ nil
]

{ #category : 'enumerating' }
ViennaModuleNode >> importDefinitionsDo: aBlock [

	self interface importDefinitionList ifNotNil: [ :importDefinitionList |
		importDefinitionList do: aBlock ]
]

{ #category : 'enumerating' }
ViennaModuleNode >> importSignaturesDo: aBlock [

	self interface importSignaturesDo: aBlock
]

{ #category : 'testing' }
ViennaModuleNode >> importsFrom: moduleIdentifier identifier: identifier [

	self interface importDefinitionList ifNotNil: [ :importDefinitionList |
		importDefinitionList do: [ :importDefinition |
			importDefinition moduleIdentifier = moduleIdentifier ifTrue: [
				importDefinition
					allDescendantsSuchThat: [ :node |
					node isViennaImportNode: identifier ]
					do: [ :node | ^ true ] ] ] ].
	^ false
]

{ #category : 'testing' }
ViennaModuleNode >> importsIdentifier: aString [

	self interface boundIdentifiersDo: [ :string |
		string = aString ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'accessing' }
ViennaModuleNode >> interface [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaModuleNode >> interface: aViennaInterfaceNode [

	self at: 2 put: aViennaInterfaceNode
]

{ #category : 'testing' }
ViennaModuleNode >> isReferenced [

	self document ifNil: [ ^ false ].
	self modulesDo: [ :module |
		module importsFrom: self identifier do: [ :node | ^ true ] ].
	^ false
]

{ #category : 'testing' }
ViennaModuleNode >> isTestModuleOrViennaUnit [

	^ (self identifier endsWith: 'Test') or: [
		  self identifier = 'UnitTesting' ]
]

{ #category : 'testing' }
ViennaModuleNode >> isViennaModuleNode [

	^ true
]

{ #category : 'testing' }
ViennaModuleNode >> isViennaModuleNode: aString [

	^ self identifier = aString
]

{ #category : 'testing' }
ViennaModuleNode >> label [

	^ 'Module'
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> lookupIdentifier: aString [

	self toplevelDefinitionsDo: [ :definition |
		(definition bindsIdentifier: aString) ifTrue: [
			definition isViennaStateDefinitionNode ifTrue: [
				definition fieldsDo: [ :field |
					field identifier = aString ifTrue: [ ^ field ] ] ].
			((aString beginsWith: 'pre_') and: [
				 definition isFunctionDefinition or: [
					 definition isOperationDefinition ] ]) ifTrue: [
				^ definition preFunction ].
			((aString beginsWith: 'post_') and: [
				 definition isFunctionDefinition or: [
					 definition isOperationDefinition ] ]) ifTrue: [
				^ definition postFunction ].
			^ definition ] ].
	self importDefinitionsDo: [ :importDefinition |
		importDefinition importsDo: [ :import |
			(import rename notNil and: [ import rename identifier = aString ])
				ifTrue: [ ^ import ] ] ].
	^ nil
]

{ #category : 'typechecking' }
ViennaModuleNode >> maximalType [

	self interface importDefinitionList ifNotNil: #typecheck.
	self moduleBody typecheck.
	self interface exportDefinition ifNotNil: #typecheck.
	^ ViennaType unit
]

{ #category : 'accessing' }
ViennaModuleNode >> module [

	^ self
]

{ #category : 'accessing' }
ViennaModuleNode >> moduleBody [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaModuleNode >> moduleBody: aViennaModuleBodyNode [

	self at: 3 put: aViennaModuleBodyNode
]

{ #category : 'accessing' }
ViennaModuleNode >> moduleOrFlatDocument [

	^ self
]

{ #category : 'enumerating' }
ViennaModuleNode >> namedTracesDo: aBlock [

	self sectionsDo: [ :section |
		section isViennaTracesDefinitionsNode ifTrue: [ section do: aBlock ] ]
]

{ #category : 'accessing' }
ViennaModuleNode >> sections [

	^ self moduleBody asArray
]

{ #category : 'enumerating' }
ViennaModuleNode >> sectionsDo: aBlock [

	self moduleBody sectionsDo: aBlock
]

{ #category : 'testing' }
ViennaModuleNode >> shortName [

	^ self identifier
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> stateDefinition [

	self sectionsDo: [ :section |
		section isViennaStateDefinitionNode ifTrue: [ ^ section ] ].
	^ nil
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> stateDefinitionIfAbsentPut: errorBlock [

	^ self stateDefinition ifNil: [
		  | def |
		  def := errorBlock value.
		  self moduleBody add: def.
		  def ]
]

{ #category : 'enumerating' }
ViennaModuleNode >> testOperationsDo: aBlock [

	self toplevelDefinitionsDo: [ :toplevel |
		toplevel isOperationDefinition and: [
			(toplevel identifier beginsWith: 'test') ifTrue: [
				aBlock value: toplevel ] ] ]
]

{ #category : 'enumerating' }
ViennaModuleNode >> toplevelDefinitionsDo: aBlock [

	self moduleBody toplevelDefinitionsDo: aBlock
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> toplevelIdentifiers [

	^ Array streamContents: [ :stream |
		  self toplevelIdentifiersDo: [ :i | stream nextPut: i ] ]
]

{ #category : 'accessing-definitions' }
ViennaModuleNode >> toplevelIdentifiersDo: aBlock [

	self toplevelDefinitionsDo: [ :toplevelDefinition |
		toplevelDefinition isViennaValueDefinitionNode
			ifTrue: [ toplevelDefinition identifiers do: aBlock ]
			ifFalse: [ aBlock value: toplevelDefinition identifier ] ]
]

{ #category : 'accessing' }
ViennaModuleNode >> uniqueImportedIdentifiers [

	^ self interface uniqueBoundIdentifiers
]
