Class {
	#name : #ViennaASTBrowser,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'historyList',
		'moduleList',
		'categoryList',
		'definitionList',
		'sourceText',
		'playground'
	],
	#classVars : [
		'SectionNames'
	],
	#category : #'ViennaTalk-Browser-Core'
}

{ #category : #specs }
ViennaASTBrowser class >> defaultSpec [
	^ SpPanedLayout newVertical
		position: 0.5;
		add:
			(SpBoxLayout newHorizontal
				add:
					(SpBoxLayout newVertical
						add: #historyList height: self buttonHeight;
						add: #moduleList);
				add: #categoryList;
				add: #definitionList);
		add: #sourceText
]

{ #category : #examples }
ViennaASTBrowser class >> exampleATC [
	(ViennaASTBrowser
		on:
			(ViennaVDMParser new
				parse:
					'module ATC_TERMINLOGY -- Air-Traffic Control (ATC) System abstract model from the book "ProofinVDM."
-- This is the top-level specification of the ATC subsystem,
exports all
definitions
types
     Space = token;
     Aircraft = token;
     Controller = token;

state ATC of
    onduty : set of Controller
    control : inmap Space to Controller
    capacity : map Space to nat
    location : map Aircraft to Space
inv mk_ATC(cs, con, cap, loc) ==
    ((rng con subset cs and dom con subset dom cap)
        and rng loc subset dom con)
    and (forall s in set rng loc & numOfAircraft(s, loc) <= cap(s))
init σ == σ = mk_ATC({}, {|->}, {|->}, {|->})
end

functions
    numOfAircraft : Space * map Aircraft to Space -> nat
    numOfAircraft(s, loc) == card (dom (loc :> {s}));
    
    isactivated : Space * ATC -> bool
    isactivated(s, δ) == s in set dom δ.control;
    
    isKnown : Aircraft * ATC -> bool
    isKnown(p, δ) == p in set dom δ.location;
    
    controllerOf : Aircraft * ATC -> Controller
    controllerOf(p, δ) == δ.control(δ.location(p))
    pre isKnown(p, δ);

operations
    Commission(s:Space, n:nat)
    ext wr capacity:map Space to nat
    pre s not in set dom capacity
    post capacity = capacity~ ++ {s |-> n};
    
    ResetCapacity(s:Space, n:nat)
    ext rd location:map Aircraft to Space wr capacity:map Space to nat
    pre s in set dom capacity and numOfAircraft(s, location) <= n
    post capacity = capacity~ ++ {s |-> n};
    
    Decommission(s:Space)
    ext rd control:inmap Space to Controller wr capacity:map Space to nat
    pre s in set dom capacity \ dom control
    post capacity = {s} <-: capacity~;
    
    ClockOn(c:Controller)
    ext wr onduty:set of Controller
    pre c not in set onduty
    post onduty = onduty~ union {c};
    
    ClockOff(c:Controller)
    ext wr onduty:set of Controller rd control:inmap Space to Controller
    pre c in set onduty \ rng control
    post onduty = onduty~ \ {c};
    
    Activate(s:Space, c:Controller)
    ext rd onduty:set of Controller wr control:inmap Space to Controller rd capacity:map Space to nat
    pre s in set dom capacity \ dom control and rng control <> onduty
    post control = control~ ++ {s |-> c};
    
    Reassign(s:Space, c:Controller)
    ext rd onduty:set of Controller wr control:inmap Space to Controller
    pre s in set dom control and rng control <> onduty
    post control = control~ ++ {s |-> c} and c <> control~(s);
    
    Deactivate(s:Space)
    ext wr control:inmap Space to Controller rd location:map Aircraft to Space
    pre s in set dom control \ rng location
    post control = {s} <-: control~;
    
    AddFlight(p:Aircraft, s:Space)
    ext rd control:inmap Space to Controller rd capacity:map Space to nat wr location:map Aircraft to Space
    pre (s in set dom control and p not in set dom location)
    and numOfAircraft(s, location) < capacity(s)
    post location = location~ ++ {p |-> s};
    
    Handover(p:Aircraft, s:Space)
    ext rd control:inmap Space to Controller rd capacity:map Space to nat wr location:map Aircraft to Space
    pre ((s in set dom control and p in set dom location) and location(p) <> s)
    and numOfAircraft(s, location) < capacity(s)
    post location = location~ ++ {p |-> s};
    
    RemoveFlight(p:Aircraft)
    ext wr location:map Aircraft to Space
    pre p in set dom location
    post location = {p} <-: location~;

end ATC_TERMINLOGY

module ATC  -- Air-Traffic Control System concreate model from the book "ProofinVDM."
-- This is the top-level executable specification of the ATC subsystem,
imports
    from ATC_TERMINLOGY
        types
            Controller renamed Controller;
            Space renamed Space;
            Aircraft renamed Aircraft;
exports all
definitions
state ATC of
    onduty : set of Controller
    control : inmap Space to Controller
    capacity : map Space to nat
    location : map Aircraft to Space
inv mk_ATC(cs, con, cap, loc) ==
    ((rng con subset cs and dom con subset dom cap)
        and rng loc subset dom con)
    and (forall s in set rng loc & numOfAircraft(s, loc) <= cap(s))
init σ == σ = mk_ATC({}, {|->}, {|->}, {|->})
end

functions
    numOfAircraft : Space * map Aircraft to Space -> nat
    numOfAircraft(s, loc) == card (dom (loc :> {s}));

operations
    Commission : Space * nat ==> map Space to nat
    Commission(s, n) ==
        (capacity := capacity ++ {s |-> n};
        return capacity);
    
    Decommission : Space ==> map Space to nat
    Decommission(s) ==
        (capacity := {s} <-: capacity;
        return capacity)
    pre  s in set dom capacity \ dom control
    post  capacity = {s} <-: capacity~;
    
    ResetCapacity : Space * nat ==> map Space to nat
    ResetCapacity(s, n) ==
        (capacity := capacity ++ {s |-> n};
        return capacity)
    pre  s in set dom capacity and numOfAircraft(s, location) <= n
    post  capacity = capacity~ ++ {s |-> n};
    
    ClockOn : Controller ==> set of Controller
    ClockOn(c) ==
        (onduty := onduty union {c};
        return onduty)
    pre  c not in set onduty
    post  onduty = onduty~ union {c};
    
    ClockOff : Controller ==> set of Controller
    ClockOff(c) ==
        (onduty := onduty \ {c};
        return onduty)
    pre  c in set onduty \ rng control
    post  onduty = onduty~ \ {c};
    
    Activate : Space * Controller ==> inmap Space to Controller
    Activate(s, c) ==
        (control := control ++ {s |-> c};
        return control)
    pre  s in set dom capacity \ dom control and rng control <> onduty
    post  control = control~ ++ {s |-> c};
    
    Handover : Aircraft * Space ==> map Aircraft to Space
    Handover(p, s) ==
        (location := location ++ {p |-> s};
        return location)
    pre 
        ((s in set dom control and p in set dom location) and location(p) <> s)
        and numOfAircraft(s, location) < capacity(s)
    post  location = location~ ++ {p |-> s};
    
    AddFlight : Aircraft * Space ==> map Aircraft to Space
    AddFlight(p, s) ==
        (location := location ++ {p |-> s};
        return location)
    pre 
        (s in set dom control and p not in set dom location)
        and numOfAircraft(s, location) < capacity(s)
    post  location = location~ ++ {p |-> s};
    
    RemoveFlight : Aircraft ==> map Aircraft to Space
    RemoveFlight(p) ==
        (location := {p} <-: location;
        return location)
    pre  p in set dom location
    post  location = {p} <-: location~;
    
    Deactivate : Space ==> inmap Space to Controller
    Deactivate(s) ==
        (control := {s} <-: control;
        return control)
    pre  s in set dom control \ rng location
    post  control = {s} <-: control~;
    
    Reassign : Space * Controller ==> inmap Space to Controller
    Reassign(s, c) ==
        (control := control ++ {s |-> c};
        return control)
    pre  s in set dom control and rng control <> onduty
    post  control = control~ ++ {s |-> c} and c <> control~(s);

operations
    test01 : () ==> seq of bool
    test01() ==
-- Unit test with the test result.
        def
            r = [];
            m1 = Commission(mk_token("Kadena"), 2);
            r = r ^ [m1(mk_token("Kadena")) = 2];
            m2 = ResetCapacity(mk_token("Kadena"), 5);
            r = r ^ [m2(mk_token("Kadena")) = 5];
            m3 = Commission(mk_token("Kadena"), 3);
            r = r ^ [m3(mk_token("Kadena")) = 3];
            r = r ^ [ClockOn(mk_token("Sahara")) = {mk_token("Sahara")}];
            r =
                r
                ^ [Activate(mk_token("Kadena"), mk_token("Sahara"))
                = {mk_token("Kadena") |-> mk_token("Sahara")}];
            r =
                r
                ^ [AddFlight(mk_token("F35_1"), mk_token("Kadena"))
                = {mk_token("F35_1") |-> mk_token("Kadena")}];
            r =
                r
                ^ [AddFlight(mk_token("F18_1"), mk_token("Kadena"))
                = {mk_token("F35_1") |-> mk_token("Kadena"),
                mk_token("F18_1") |-> mk_token("Kadena")}];
            r =
                r
                ^ [numOfAircraft(
                    mk_token("Kadena"),
                    {mk_token("F35_1") |-> mk_token("Kadena"),
                    mk_token("F18_1") |-> mk_token("Kadena")})
                = 2];
            r =
                r
                ^ [numOfAircraft(
                    mk_token("Yokota"),
                    {mk_token("F35_1") |-> mk_token("Yokota"),
                    mk_token("F18_1") |-> mk_token("Yokota")})
                = 2];
        in return r;
    
    test02 : () ==> ATC
    test02() ==
        (onduty := ClockOn(mk_token("Sahara"));
        onduty := ClockOff(mk_token("Sahara"));
-- test cases by using debugger
        onduty := ClockOn(mk_token("Sahara"));
        capacity := Commission(mk_token("Kadena"), 4);
        capacity := Commission(mk_token("Yokota"), 2);
        capacity := Decommission(mk_token("Yokota"));
        onduty := onduty union ClockOn(mk_token("Sakoh"));
        onduty := onduty union ClockOn(mk_token("Oda"));
        capacity := Commission(mk_token("Yokota"), 2);
        control := Activate(mk_token("Yokota"), mk_token("Sahara"));
        control := Activate(mk_token("Kadena"), mk_token("Oda"));
        location := AddFlight(mk_token("F35_1"), mk_token("Kadena"));
        location := AddFlight(mk_token("F18_1"), mk_token("Kadena"));
        location := AddFlight(mk_token("F18_3"), mk_token("Yokota"));
        location := AddFlight(mk_token("F35_2"), mk_token("Yokota"));
        location := Handover(mk_token("F35_2"), mk_token("Kadena"));
        location := Handover(mk_token("F18_3"), mk_token("Kadena"));
        control := Deactivate(mk_token("Yokota"));
        location := RemoveFlight(mk_token("F18_3"));
        control := Activate(mk_token("Yokota"), mk_token("Sahara"));
        onduty := ClockOn(mk_token("PGL"));
        control := Reassign(mk_token("Kadena"), mk_token("PGL"));
        location := RemoveFlight(mk_token("F35_1"));
        location := RemoveFlight(mk_token("F18_1"));
        location := RemoveFlight(mk_token("F35_2"));
        control := Deactivate(mk_token("Kadena"));
        return ATC);
    
    getATC : () ==> ATC
    getATC() == return ATC;
    
    getLocation : () ==> map Aircraft to Space
    getLocation() == return ATC.location;
-- Combinatorial test

end ATC')) openWithSpec
]

{ #category : #examples }
ViennaASTBrowser class >> exampleCounter [
	(ViennaASTBrowser
		on:
			(ViennaVDMParser new
				parse:
					'module Counter exports all definitions
					types
     Display = seq of char inv display == elems display subset rng nat2char;

values
     num_digits : nat1 = 3;
     base : nat = 10 ** num_digits;
     nat2char =
        {0 |-> ''0'', 1 |-> ''1''  , 2 |-> ''2'', 3 |-> ''3'', 4 |-> ''4'', 5 |-> ''5'',
        6 |-> ''6'', 7 |-> ''7'', 8 |-> ''8'', 9 |-> ''9''};

functions
    show : nat -> Display
    show(x) ==
        [nat2char(x div 10 ** (num_digits - index) mod 10)
            | index in set {1, ..., num_digits}]
    post let
        string2nat : seq of char -> nat
        string2nat(s) ==
            cases s:
                [] -> 0,
                [c] -> (inverse nat2char)(c),
                head ^ [c] -> string2nat(head)  * 10 + (inverse nat2char)(c)
                end
    in x = string2nat(RESULT);

state counter of
    count : nat
init s == s = mk_counter(0)
end

operations
    reset : () ==> ()
    reset() == count := 0
    post  count = 0;
    
    step : () ==> nat
    step() ==
        (count := count + 1 mod base;
        return count);
    
    display : () ==> Display
    display() == return show(count);
end Counter')) openWithSpec
]

{ #category : #accessing }
ViennaASTBrowser class >> sectionNames [
	^ SectionNames
		ifNil: [ SectionNames := Dictionary new
				at: 'Module' put: '- all -';
				at: 'TypeDefinitions' put: 'types';
				at: 'ValueDefinitions' put: 'values';
				at: 'StateDefinition' put: 'state';
				at: 'FunctionDefinitions' put: 'functions';
				at: 'OperationDefinitions' put: 'operations';
				at: 'ImportTypesSignature' put: 'types';
				at: 'ImportValuesSignature' put: 'values';
				at: 'ImportFunctionsSignature' put: 'functions';
				at: 'ImportOperationsSignature' put: 'operations';
				at: 'ImportModuleSignatureAll' put: 'all';
				yourself ]
]

{ #category : #menus }
ViennaASTBrowser class >> viennaDevMenuOn: aBuilder [
	<ViennaDev>
	(aBuilder item: #'Refactoring example (ATC)')
		action: [ self exampleATC  ];
		order: 1.1;
		help: 'Example spec on refactoring borwser';
		icon: nil
]

{ #category : #operations }
ViennaASTBrowser >> accept: aStringOrText [
	| newNode newAst copyMap parent oldNode |
	newNode := self parser
		parse: aStringOrText asString
		onError: [ ^ false ].
	copyMap := IdentityDictionary new.
	newAst := self specification copyWhole: copyMap.
	oldNode := copyMap at: self definition ifAbsent: [ ^ false ].
	oldNode label = newNode label
		ifFalse: [ ^ false ].
	parent := oldNode parent.
	1 to: parent size do: [ :index | 
		(parent at: index) == oldNode
			ifTrue: [ parent at: index put: newNode ] ].
	copyMap keys
		do: [ :old | 
			(copyMap at: old) == oldNode
				ifTrue: [ copyMap at: old put: newNode ] ].
	self model: newAst comment: 'manual edit' with: copyMap.
	^ newNode
]

{ #category : #operations }
ViennaASTBrowser >> addExplicitFunction [
	(UIManager default request: 'a new function name')
		ifNotNil: [ :functionName | 
			| ast |
			ast := self parser
				parse: functionName , ' : () -> ? ' , functionName , '() == undefined'.
			ast isPetit2Failure
				ifTrue: [ ^ self ].
			self category label = 'FunctionDefinitions'
				ifFalse: [ ^ self ].
			(self category module definitionOfLocalName: functionName)
				ifNotNil: [ UIManager default alert: functionName , ' is already defined.'.
					^ self ].
			self append: ast to: self category ]
]

{ #category : #operations }
ViennaASTBrowser >> addExplicitOperation [
	(UIManager default request: 'a new operation name')
		ifNotNil: [ :operationName | 
			| ast |
			ast := self parser
				parse: operationName , ' : () ==> () ' , operationName , '() == skip'.
			ast isPetit2Failure
				ifTrue: [ ^ self ].
			self category label = 'OperationDefinitions'
				ifFalse: [ ^ self ].
			(self category module definitionOfLocalName: operationName)
				ifNotNil: [ UIManager default alert: operationName , ' is already defined.'.
					^ self ].
			self append: ast to: self category ]
]

{ #category : #operations }
ViennaASTBrowser >> addImplicitFunction [
	(UIManager default request: 'a new function name')
		ifNotNil: [ :functionName | 
			| ast |
			ast := self parser parse: 'functions ', functionName , ' () res:? post true'.
			ast isPetit2Failure
				ifTrue: [ ^ self ].
			self category label = 'FunctionDefinitions'
				ifFalse: [ ^ self ].
			(self category module definitionOfLocalName: functionName)
				ifNotNil: [ UIManager default alert: functionName , ' is already defined.'.
					^ self ].
			self append: ast first to: self category ]
]

{ #category : #operations }
ViennaASTBrowser >> addImplicitOperation [
	(UIManager default request: 'a new operation name')
		ifNotNil: [ :operationName | 
			| ast |
			ast := self parser parse: 'operations ', operationName , ' () post true'.
			ast isPetit2Failure
				ifTrue: [ ^ self ].
			self category label = 'OperationDefinitions'
				ifFalse: [ ^ self ].
			(self category module definitionOfLocalName: operationName)
				ifNotNil: [ UIManager default alert: operationName , ' is already defined.'.
					^ self ].
			self append: ast first to: self category ]
]

{ #category : #operations }
ViennaASTBrowser >> addRecordType [
	(UIManager default request: 'a new record name')
		ifNotNil: [ :typeName | 
			| ast |
			ast := self parser parse: typeName , '::'.
			ast isPetit2Failure
				ifTrue: [ ^ self ].
			self category label = 'TypeDefinitions'
				ifFalse: [ ^ self ].
			(self category module definitionOfLocalName: typeName)
				ifNotNil: [ UIManager default alert: typeName , ' is already defined.'.
					^ self ].
			self append: ast to: self category ]
]

{ #category : #operations }
ViennaASTBrowser >> addTypeAlias [
	(UIManager default request: 'a new type name')
		ifNotNil: [ :typeName | 
			| ast |
			ast := self parser parse: typeName , ' = token'.
			ast isPetit2Failure
				ifTrue: [ ^ self ].
			self category label = 'TypeDefinitions'
				ifFalse: [ ^ self ].
			(self category module definitionOfLocalName: typeName)
				ifNotNil: [ UIManager default alert: typeName , ' is already defined.'.
					^ self ].
			self append: ast to: self category ]
]

{ #category : #operations }
ViennaASTBrowser >> addValue [
	(UIManager default request: 'a new value name')
		ifNotNil: [ :valueName | 
			| ast |
			ast := self parser parse: valueName , ' = undefined'.
			ast isPetit2Failure
				ifTrue: [ ^ self ].
			self category label = 'ValueDefinitions'
				ifFalse: [ ^ self ].
			(self category module definitionOfLocalName: valueName)
				ifNotNil: [ UIManager default alert: valueName , ' is already defined.'.
					^ self ].
			self append: ast to: self category ]
]

{ #category : #operations }
ViennaASTBrowser >> append: aViennaNode to: parentNode [
	| copyMap newAst |
	copyMap := IdentityDictionary new.
	newAst := parentNode root copyWhole: copyMap.
	(copyMap at: parentNode ifAbsent: [ ^ nil ]) add: aViennaNode.
	self model: newAst comment: 'add ' , aViennaNode name asString with: copyMap.
	definitionList selectItem: aViennaNode
]

{ #category : #accessing }
ViennaASTBrowser >> category [
	^ categoryList selection selectedItem
]

{ #category : #accessing }
ViennaASTBrowser >> definition [
	^ definitionList selection selectedItem
]

{ #category : #accessing }
ViennaASTBrowser >> definitionBase [
	| node |
	node := self definition.
	node ifNil: [ ^ nil ].
	(#('AccessTypeDefinition' 'AccessValueDefinition')
		includes: node label)
		ifTrue: [ ^ node second ].
	(#('AccessFunctionDefinition' 'AccessOperationDefinition')
		includes: node label)
		ifTrue: [ ^ node second first ].
	^ node
]

{ #category : #menus }
ViennaASTBrowser >> definitionListContextMenu [
	| menu |
	menu := self newMenu.
	self category label = 'TypeDefinitions'
		ifTrue: [ menu
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'New type alias';
								action: [ self addTypeAlias ] ];
						addItem: [ :item | 
							item
								name: 'New record type';
								action: [ self addRecordType ] ] ] ].
	self category label = 'ValueDefinitions'
		ifTrue: [ menu
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'New value';
								action: [ self addValue ] ] ] ].
	self category label = 'FunctionDefinitions'
		ifTrue: [ menu
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'New explicit function';
								action: [ self addExplicitFunction ] ];
						addItem: [ :item | 
							item
								name: 'New implicit function';
								action: [ self addImplicitFunction ] ] ] ].
	self category label = 'OperationDefinitions'
		ifTrue: [ menu
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'New explicit operation';
								action: [ self addExplicitOperation ] ];
						addItem: [ :item | 
							item
								name: 'New implicit operation';
								action: [ self addImplicitOperation ] ] ] ].
	self definitionBase
		ifNotNil: [ :definition | 
			menu
				addGroup: [ :group | 
					(ViennaRefactoring sortedInstancesOn: definition)
						do: [ :refactoring | 
							group
								addItem: [ :item | 
									item
										name: refactoring name;
										action: [ self executeRefactoring: refactoring ] ] ] ] ].
	menu
		addGroup: [ :group | 
			menu
				addItem: [ :item | 
					item
						name: 'inspect';
						action: [ self definitionBase inspect ] ] ].
	^ menu
]

{ #category : #private }
ViennaASTBrowser >> definitionsFromCategory: aViennaNode [
	aViennaNode isViennaNode
		ifTrue: [ aViennaNode label = 'Module'
				ifTrue: [ ^ ((self module
						ifNotNil: [ :ast | 
							(ast
								detect: [ :node | node isViennaNode and: [ node label = 'ModuleBody' ] ]
								ifNone: [  ])
								ifNotNil: [ :body | body collect: [ :node | node first ] ]
								ifNil: [ Array new ] ]
						ifNil: [ Array new ])
						collect: [ :def | self definitionsFromCategory: def ])
						inject: #()
						into: [ :array :each | array , each ] ].
			aViennaNode label = 'ImportModuleSignatureAll'
				ifTrue: [ ^ Array with: aViennaNode second ].
			aViennaNode label = 'StateDefinition'
				ifTrue: [ ^ Array new ].
			^ aViennaNode asArray ].
	^ Array new
]

{ #category : #private }
ViennaASTBrowser >> displayCategory: aViennaNode [
	aViennaNode ifNil: [ ^ '-' ].
	(#('ImportTypesSignature' 'ImportValuesSignature' 'ImportFunctionsSignature' 'ImportOperationsSignature')
		includes: aViennaNode label)
		ifTrue: [ ^ 'from ' , aViennaNode parent parent first , ' '
				,
					(self class sectionNames
						at: aViennaNode label
						ifAbsent: [ aViennaNode label ]) ].
	self class sectionNames
		at: aViennaNode label
		ifPresent: [ :name | ^ name ].
	^ aViennaNode label
]

{ #category : #private }
ViennaASTBrowser >> displayDefinition: aViennaNode [
	aViennaNode
		allDescendantsDo: [ :node | 
			(#('Module' 'TypeDefinitions' 'ValueDefinitions' 'FunctionDefinitions' 'OperationDefinitions')
				includes: node label)
				ifTrue: [ ^ ' - all - ' ].
			node label = 'FunctionsDefinition'
				ifTrue: [ ^ ' - all - ' ].
			node label = 'TypeDefinition'
				ifTrue: [ ^ node first ].
			node label = 'RecordTypeDefinition'
				ifTrue: [ ^ node first ].
			node label = 'ValueDefinition'
				ifTrue: [ ^ node first source ].
			node label = 'StateDefinition'
				ifTrue: [ ^ node first ].
			node label = 'ExplicitFunctionDefinition'
				ifTrue: [ ^ node first ].
			node label = 'ImplicitFunctionDefinition'
				ifTrue: [ ^ node first ].
			node label = 'ExplicitOperationDefinition'
				ifTrue: [ ^ node first ].
			node label = 'ImplicitOperationDefinition'
				ifTrue: [ ^ node first ].
			node label = 'ImportModuleDefinitionAll'
				ifTrue: [ ^ 'all' ].
			(#('ImportTypesSignature' 'ImportValuesSignature' 'ImportFunctionsSignature' 'ImportOperationsSignature')
				includes: node label)
				ifTrue: [ ^ '- all -' ].
			(#('TypeImport' 'ValueImport' 'FunctionImport' 'OperationImport')
				includes: node label)
				ifTrue: [ ^ node last
						ifNotNil: [ :localName | localName first ]
						ifNil: [ node parent parent parent first , '`' , node name ] ] ].
	^ '-'
]

{ #category : #operations }
ViennaASTBrowser >> executeRefactoring: aViennaRefactoring [
	| newAst copyMap refactoring |
	copyMap := IdentityDictionary new.
	newAst := self specification copyWhole: copyMap.
	refactoring := aViennaRefactoring class new
		ast: (copyMap at: aViennaRefactoring ast ifAbsent: [ ^ false ]).
	refactoring check
		ifFalse: [ ^ false ].
	refactoring execute.
	self model: newAst comment: refactoring name with: copyMap
]

{ #category : #private }
ViennaASTBrowser >> getSource: aViennaNode [
	aViennaNode ifNil: [ ^ String ].
	^ aViennaNode tracingHighlightedSource
]

{ #category : #initialization }
ViennaASTBrowser >> initializePresenters [
	super initializePresenters.
	historyList := self newDropList
		items:
			{{DateAndTime now.
			'initial'.
			self model}};
		display: [ :triple | 
			| time |
			time := DateAndTime now - triple first.
			triple second
				,
					(time < 1 second
						ifTrue: [ '' ]
						ifFalse: [ '(' , (time roundTo: 1 second) humanReadablePrintString , ')' ]) ];
		whenSelectionChangedDo: [ | assoc |
			assoc := historyList selectedItem.
			assoc = historyList listItems last
				ifFalse: [ self model: assoc third.
					historyList
						items:
							historyList listItems
								,
									{{DateAndTime now.
									'version'.
									self model}};
						selectItem: historyList listItems last ] ];
		yourself.
	moduleList := self newList
		beSingleSelection;
		display: [ :ast | ast first ];
		whenSelectionChangedDo: [ self updateCategoryList ];
		yourself.
	categoryList := self newList
		beSingleSelection;
		display: [ :ast | self displayCategory: ast ];
		whenSelectionChangedDo: [ self updateDefinitionList ];
		yourself.
	definitionList := self newList
		beSingleSelection;
		contextMenu: [ self definitionListContextMenu ];
		display:
				[ :ast | ast ifNotNil: [ self displayDefinition: ast ] ifNil: [ '-' ] ];
		whenSelectionChangedDo: [ self updateSource ].
	sourceText := self newText
		contextMenu: [ self sourceTextContextMenu ];
		acceptBlock: [ :text | self accept: text ];
		yourself.
	self
		whenBuiltDo: [ :w | 
			| f |
			f := ViennaLauncher font.
			w widget
				allMorphsDo: [ :m | 
					(m respondsTo: #font:)
						ifTrue: [ m font: f ] ] ]
]

{ #category : #initialization }
ViennaASTBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Browser';
		initialExtent: 800 @ 600
]

{ #category : #accessing }
ViennaASTBrowser >> model: aViennaNode comment: aString with: anIdentityDictionary [
	| module category definition |
	module := self module.
	category := self category.
	definition := self definition.
	self model: aViennaNode.
	historyList
		items:
			historyList listItems
				,
					{{DateAndTime now.
					aString.
					aViennaNode}};
		selectItem: historyList listItems last.
	UIManager default inform: aString.
	self updateModuleList.
	moduleList
		selectItem: (anIdentityDictionary at: module ifAbsent: [ nil ]).
	categoryList
		selectItem: (anIdentityDictionary at: category ifAbsent: [ nil ]).
	definitionList
		selectItem: (anIdentityDictionary at: definition ifAbsent: [ nil ])
]

{ #category : #accessing }
ViennaASTBrowser >> model: aViennaNode with: anIdentityDictionary [
	| module category definition |
	module := self module.
	category := self category.
	definition := self definition.
	self model: aViennaNode.
	self updateModuleList.
	moduleList
		selectItem: (anIdentityDictionary at: module ifAbsent: [ nil ]).
	categoryList
		selectItem: (anIdentityDictionary at: category ifAbsent: [ nil ]).
	definitionList
		selectItem: (anIdentityDictionary at: definition ifAbsent: [ nil ])
]

{ #category : #accessing }
ViennaASTBrowser >> modelChanged [
	self updateModuleList
]

{ #category : #accessing }
ViennaASTBrowser >> module [
	^ moduleList selection selectedItem
]

{ #category : #private }
ViennaASTBrowser >> parser [
	| parser |
	parser := ViennaVDMParser new.
	^ parser module end / parser typeDefinitions end
		/ parser valueDefinitions end / parser functionDefinitions end
		/ parser operationDefinitions end / parser stateDefinition end
		/ parser document end / parser importModuleSignature end
		/ parser accessTypeDefinition end / parser accessValueDefinition end
		/ parser stateDefinition end / parser accessFunctionDefinition end
		/ parser accessOperationDefinition end / parser typeImport end
		/ parser valueImport end / parser functionImport end
		/ parser operationImport end
]

{ #category : #menus }
ViennaASTBrowser >> sourceTextContextMenu [
	| menu |
	menu := self newMenu.
	(sourceText text string asViennaTracingString
		nodeContaining: sourceText selectionInterval
		ifAbsent: [ nil ])
		ifNotNil: [ :node | 
			menu
				addGroup: [ :group | 
					(ViennaRefactoring sortedInstancesOn: node)
						do: [ :refactoring | 
							group
								addItem: [ :item | 
									item
										name: refactoring name;
										action: [ self executeRefactoring: refactoring ] ] ] ] ].
	^ menu
]

{ #category : #accessing }
ViennaASTBrowser >> specification [
	^ self model
]

{ #category : #updating }
ViennaASTBrowser >> updateCategoryList [
	| newItems oldSelection |
	newItems := (Array with: self module)
		,
			(self module
				ifNotNil: [ :ast | 
					(ast second first
						ifNotNil: [ :importDefinitionList | 
							(importDefinitionList
								collect: [ :importDefinition | importDefinition second asArray ])
								flattened ]
						ifNil: [ Array new ])
						,
							((ast
								detect: [ :node | node isViennaNode and: [ node label = 'ModuleBody' ] ]
								ifNone: [  ])
								ifNotNil: [ :body | body collect: [ :node | node first ] ]
								ifNil: [ Array new ]) ]
				ifNil: [ Array new ]).
	oldSelection := categoryList selection selectedItem.
	categoryList items: newItems.
	(newItems includes: oldSelection)
		ifTrue: [ categoryList selectItem: oldSelection ]
		ifFalse: [ categoryList unselectAll ]
]

{ #category : #updating }
ViennaASTBrowser >> updateDefinitionList [
	| newItems oldSelection |
	newItems := (Array with: self category)
		,
			(self category
				ifNotNil: [ :ast | self definitionsFromCategory: ast ]
				ifNil: [ Array new ]).
	oldSelection := definitionList selection selectedItem.
	definitionList items: newItems.
	(newItems includes: oldSelection)
		ifTrue: [ definitionList selectItem: oldSelection ]
		ifFalse: [ definitionList unselectAll ]
]

{ #category : #updating }
ViennaASTBrowser >> updateModuleList [
	| newItems oldSelection |
	newItems := self specification
		ifNotNil: [ :ast | ast asArray ]
		ifNil: [ Array new ].
	oldSelection := moduleList selection selectedItem.
	moduleList items: newItems.
	(newItems includes: oldSelection)
		ifTrue: [ moduleList selectItem: oldSelection ]
		ifFalse: [ moduleList unselectAll ]
]

{ #category : #updating }
ViennaASTBrowser >> updateSource [
	self definition
		ifNotNil: [ :node | sourceText text: (self getSource: node) ]
		ifNil: [ sourceText text: '' ]
]
