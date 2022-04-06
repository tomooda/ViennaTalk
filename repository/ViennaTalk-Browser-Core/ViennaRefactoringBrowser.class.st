Class {
	#name : #ViennaRefactoringBrowser,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'menuBar',
		'historyList',
		'moduleList',
		'categoryList',
		'definitionList',
		'sourceText',
		'testProcess',
		'testResultTable'
	],
	#classVars : [
		'SectionNames'
	],
	#category : #'ViennaTalk-Browser-Core'
}

{ #category : #menus }
ViennaRefactoringBrowser class >> VDMBrowserMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'VDM Refactoring Browser')
		action: [ self empty openWithSpec ];
		order: 0.12;
		parent: #ViennaTalk;
		help: 'AST-based VDM-SL browser with refactoring support';
		icon: nil
]

{ #category : #layout }
ViennaRefactoringBrowser class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #menuBar height: self buttonHeight;
		  add: (SpPanedLayout newVertical
				   positionOfSlider: 0.5;
				   add: (SpBoxLayout newHorizontal
						    add: (SpBoxLayout newVertical
								     add: #historyList height: self buttonHeight;
								     add: #moduleList);
						    add: #categoryList;
						    add: #definitionList);
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.8;
						    add: #sourceText;
						    add: #testResultTable))
]

{ #category : #'instance creation' }
ViennaRefactoringBrowser class >> empty [

	<script: 'ViennaRefactoringBrowser empty openWithSpec'>
	^ self on: (ViennaNode label: 'Document')
]

{ #category : #examples }
ViennaRefactoringBrowser class >> exampleATC [
	(ViennaRefactoringBrowser
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
ViennaRefactoringBrowser class >> exampleCounter [
	(ViennaRefactoringBrowser
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
end Counter
module CounterTest
exports all
definitions
end CounterTest
')) openWithSpec
]

{ #category : #accessing }
ViennaRefactoringBrowser class >> sectionNames [
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
ViennaRefactoringBrowser class >> viennaDevMenuOn: aBuilder [
	<ViennaDev>
	(aBuilder item: #'Refactoring example (ATC)')
		action: [ self exampleATC  ];
		order: 1.1;
		help: 'Example spec on refactoring borwser';
		icon: nil
]

{ #category : #menus }
ViennaRefactoringBrowser class >> viennaToolsMenuOn: aBuilder [

	<ViennaToolsMenu>
	(aBuilder item: #'VDM Refactoring Browser')
		action: [ self empty open ];
		order: 0.12;
		help: 'AST-based VDM-SL browser with refactoring support';
		icon: nil
]

{ #category : #operations }
ViennaRefactoringBrowser >> accept: aStringOrText [
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
ViennaRefactoringBrowser >> addExplicitFunction [
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
ViennaRefactoringBrowser >> addExplicitOperation [
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
ViennaRefactoringBrowser >> addImplicitFunction [
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
ViennaRefactoringBrowser >> addImplicitOperation [
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
ViennaRefactoringBrowser >> addModule [

	(UIManager default request: 'New module name' initialAnswer: '') 
		ifNotNil: [ :string | 
			string trim ifNotEmpty: [ :moduleName | 
				| module |
				module := ViennaVDMParser new module end parse:
					          'module ' , moduleName
					          , ' exports all definitions end ' , moduleName.
				module isPetit2Failure ifFalse: [ 
					self append: module to: self specification ] ] ]
]

{ #category : #operations }
ViennaRefactoringBrowser >> addRecordType [
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
ViennaRefactoringBrowser >> addTypeAlias [
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
ViennaRefactoringBrowser >> addValue [
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
ViennaRefactoringBrowser >> append: aViennaNode to: parentNode [
	| copyMap newAst |
	copyMap := IdentityDictionary new.
	newAst := parentNode root copyWhole: copyMap.
	(copyMap at: parentNode ifAbsent: [ ^ nil ]) add: aViennaNode.
	self model: newAst comment: 'add ' , aViennaNode name asString with: copyMap.
	definitionList selectItem: aViennaNode
]

{ #category : #accessing }
ViennaRefactoringBrowser >> category [
	^ categoryList selection selectedItem
]

{ #category : #menus }
ViennaRefactoringBrowser >> categoryListContextMenu [

	| menu |
	menu := self newMenu.
	self category
		ifNotNil: [ :category | 
			menu addGroup: [ :group | 
				(ViennaRefactoring sortedInstancesOn: category) do: [ :refactoring | 
					group addItem: [ :item | 
						item
							name: refactoring name;
							action: [ self executeRefactoring: refactoring ] ] ] ] ]
		ifNil: [ 
			menu addGroup: [ :group | 
				(ViennaRefactoring sortedInstancesOn: self specification) do: [ 
					:refactoring | 
					group addItem: [ :item | 
						item
							name: refactoring name;
							action: [ self executeRefactoring: refactoring ] ] ] ] ].
	menu addGroup: [ :group | 
		menu addItem: [ :item | 
			item
				name: 'inspect';
				action: [ self category inspect ] ] ].
	^ menu
]

{ #category : #accessing }
ViennaRefactoringBrowser >> definition [
	^ definitionList selection selectedItem
]

{ #category : #accessing }
ViennaRefactoringBrowser >> definitionBase [
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
ViennaRefactoringBrowser >> definitionListContextMenu [
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
ViennaRefactoringBrowser >> definitionsFromCategory: aViennaNode [
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
ViennaRefactoringBrowser >> displayCategory: aViennaNode [
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
ViennaRefactoringBrowser >> displayDefinition: aViennaNode [
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
ViennaRefactoringBrowser >> executeRefactoring: aViennaRefactoring [
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

{ #category : #operations }
ViennaRefactoringBrowser >> exportDirectory [
	(UIManager default
		chooseDirectory: 'Export directory'
		from: FileLocator home)
		ifNotNil: [ :dir | 
			self specification
				modulesDo: [ :moduleNode | 
					| file |
					file := dir / moduleNode name withExtension: 'vdmsl'.
					file
						ensureDeleteAll;
						writeStreamDo: [ :stream | 
							stream
								nextPutAll:
									((ViennaVDMFormatter format: moduleNode)
										withLineEndings: OSPlatform current lineEnding) ] ].
			UIManager default message: 'Exported to ' , dir basename , '/.' ]
]

{ #category : #operations }
ViennaRefactoringBrowser >> exportFile [
	(UIManager default
		chooseForSaveFileReference: 'Export file'
		extensions: #('vdmsl')
		path: FileLocator home asFileReference)
		ifNotNil: [ :file | 
			file
				ensureDeleteAll;
				writeStreamDo: [ :stream | 
					stream
						nextPutAll: (self source withLineEndings: OSPlatform current lineEnding) ].
			UIManager default message: 'Exported to ' , file basename , '.' ]
]

{ #category : #private }
ViennaRefactoringBrowser >> getSource: aViennaNode [
	aViennaNode ifNil: [ ^ String ].
	^ aViennaNode tracingHighlightedSource
]

{ #category : #operations }
ViennaRefactoringBrowser >> importDirectory [
	| modelFiles testFiles source |
	(UIManager default
		chooseDirectory: 'Import directory'
		from: FileLocator home)
		ifNotNil: [ :dir | 
			modelFiles := OrderedCollection new.
			testFiles := OrderedCollection new.
			dir files
				do: [ :file | 
					(file basename endsWith: '.vdmsl')
						ifTrue: [ (file basename endsWith: 'Test.vdmsl')
								ifTrue: [ testFiles add: file ]
								ifFalse: [ modelFiles add: file ] ] ].
			modelFiles := modelFiles
				asSortedCollection: [ :less :more | less basename <= more basename ].
			testFiles := testFiles
				asSortedCollection: [ :less :more | less basename <= more basename ].
			source := String
				streamContents: [ :writeStream | 
					modelFiles
						do: [ :file | 
							writeStream
								nextPutAll: (file contents copyWith: Character cr) withInternalLineEndings ].
					testFiles
						do: [ :file | 
							writeStream
								nextPutAll:
									(file contents copyWith: Character cr) withInternalLineEndings ] ].
			self load: source ]
]

{ #category : #operations }
ViennaRefactoringBrowser >> importFile [

	(UIManager default
		 chooseExistingFileReference: 'Import directory'
		 extensions: #( 'vdmsl' )
		 path: FileLocator home) ifNotNil: [ :file | 
		self load: file contents withInternalLineEndings ]
]

{ #category : #initialization }
ViennaRefactoringBrowser >> initializePresenters [

	super initializePresenters.
	menuBar := self menuBar.
	historyList := self newDropList
		               items: { { 
				               DateAndTime now.
				               'initial'.
				               self model } };
		               display: [ :triple | 
			               | time |
			               time := DateAndTime now - triple first.
			               triple second , (time < 1 second
					                ifTrue: [ '' ]
					                ifFalse: [ 
						                '('
						                ,
							                (time roundTo: 1 second)
								                humanReadablePrintString , ')' ]) ];
		               whenSelectionChangedDo: [ 
			               historyList selectedItem ifNotNil: [ :assoc | 
					               assoc = historyList listItems last ifFalse: [ 
							               self model: assoc third.
							               historyList
								               items: historyList listItems , { { 
											               DateAndTime now.
											               'version'.
											               self model } };
								               selectItem: historyList listItems last ] ] ];
		               yourself.
	moduleList := self newList
		              beSingleSelection;
		              contextMenu: [ self moduleListContextMenu ];
		              display: [ :ast | ast ifNil: [ '-' ] ifNotNil: #first ];
		              whenSelectionChangedDo: [ self updateCategoryList ];
		              yourself.
	categoryList := self newList
		                beSingleSelection;
		                contextMenu: [ self categoryListContextMenu ];
		                display: [ :ast | self displayCategory: ast ];
		                whenSelectionChangedDo: [ self updateDefinitionList ];
		                yourself.
	definitionList := self newList
		                  beSingleSelection;
		                  contextMenu: [ self definitionListContextMenu ];
		                  display: [ :ast | 
			                  ast
				                  ifNotNil: [ self displayDefinition: ast ]
				                  ifNil: [ '-' ] ];
		                  whenSelectionChangedDo: [ self updateSource ].
	sourceText := self newText
		              contextMenu: [ self sourceTextContextMenu ];
		              whenSubmitDo: [ :text | self accept: text ];
		              yourself.
	testResultTable := self newTable
		                   addColumn:
			                   ((SpImageTableColumn evaluated: #icon)
				                    title: '';
				                    width: ViennaTestResultItem iconExtent x;
				                    sortFunction: #sortingOrder ascending);
		                   addColumn:
			                   ((SpStringTableColumn evaluated: #module)
				                    title: 'module';
				                    sortFunction: #module ascending);
		                   addColumn:
			                   ((SpStringTableColumn evaluated: #operation)
				                    title: 'operation';
				                    sortFunction: #operation ascending);
		                   addColumn:
			                   ((SpStringTableColumn evaluated: #message)
				                    title: 'message';
				                    sortFunction: #message ascending);
		                   showColumnHeaders;
		                   beResizable;
		                   sortingBlock: [ :upper :lower | 
		                   upper sortingOrder <= lower sortingOrder ];
		                   contextMenu: [ self testResultTableContextMenu ];
		                   yourself.
	self whenBuiltDo: [ :w | 
		| f |
		f := ViennaLauncher font.
		w widget allMorphsDo: [ :m | 
			(m respondsTo: #font:) ifTrue: [ m font: f ] ] ]
]

{ #category : #initialization }
ViennaRefactoringBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Browser';
		initialExtent: 800 @ 600
]

{ #category : #operations }
ViennaRefactoringBrowser >> jumpToModule: aString operation: anotherString [
	| moduleNode |
	moduleNode := (self specification moduleNamed: aString)
		ifNil: [ ^ self ].
	moduleList selectItem: moduleNode.
	self updateCategoryList.
	categoryList selectItem: moduleNode.
	self updateDefinitionList.
	definitionList
		selectItem:
			(definitionList items
				detect: [ :item | item name = anotherString ]
				ifNone: [ ^ self ]).
	self updateSource
]

{ #category : #operations }
ViennaRefactoringBrowser >> load: aString [
	| ast |
	ast := ViennaVDMParser new document end parse: aString.
	ast isPetit2Failure
		ifTrue: [ UIManager default alert: 'Failed to parse the source.'.
			^ nil ].
	ast label = 'Document'
		ifFalse: [ ^ nil ].
	ast first
		ifNotNil: [ :first | 
			first label = 'DefinitionBlock'
				ifTrue: [ ast := ViennaNode
						label: 'Document'
						with:
							(ViennaNode
								label: 'Module'
								with: 'DEFAULT'
								with:
									(ViennaNode
										label: 'Interface'
										with: nil
										with:
											(ViennaNode
												label: 'ExportDefinition'
												with: (ViennaNode label: 'ExportModuleSignatureAll')))
								with: (ViennaNode label: 'ModuleBody' withAll: ast asArray)) ] ].
	historyList
		resetSelection;
		items:
			{{DateAndTime now.
			'load'.
			ast}};
		selectItem: historyList listItems last.
	self model: ast
]

{ #category : #menus }
ViennaRefactoringBrowser >> menuBar [

	^ self newMenuBar addGroup: [ :group | 
		  group
			  addItem: [ :item | 
				  item
					  name: 'File';
					  subMenu: (self newMenu
							   addGroup: [ :g | 
								   g
									   addItem: [ :i | 
										   i
											   name: 'Import from Directory...';
											   action: [ self importDirectory ] ];
									   addItem: [ :i | 
										   i
											   name: 'Import from File...';
											   action: [ self importFile ] ];
									   addItem: [ :i | 
										   i
											   name: 'Export to Directory...';
											   action: [ self exportDirectory ] ];
									   addItem: [ :i | 
										   i
											   name: 'Export to File...';
											   action: [ self exportFile ] ] ];
							   addGroup: [ :g | 
								   g addItem: [ :i | 
									   i
										   name: 'Merge annotations into FRAM...';
										   action: [ self mergeAnnotationsIntoFRAM ] ] ]) ];
			  addItem: [ :item | 
				  item
					  name: 'Test';
					  subMenu: (self newMenu addGroup: [ :g | 
								   g addItem: [ :i | 
										   i
											   name: 'Run all tests';
											   action: [ self runAllTests ] ] ]) ] ]
]

{ #category : #operations }
ViennaRefactoringBrowser >> mergeAnnotationsIntoFRAM [

	| fram |
	(UIManager default
		 chooseExistingFileReference: 'Import directory'
		 extensions: #( 'xfmv' )
		 path: FileLocator home) ifNotNil: [ :ref | 
		fram := ViennaFRAMModel fromFile: ref ].
	fram ifNil: [ ^ nil ].
	fram loadSpec: self specification.
	(UIManager default
		 chooseForSaveFileReference: 'Export file'
		 extensions: #( 'xfmv' )
		 path: FileLocator home asFileReference) ifNotNil: [ :ref | 
		fram writeXMLFile: ref ]
]

{ #category : #accessing }
ViennaRefactoringBrowser >> model: aViennaNode comment: aString with: anIdentityDictionary [
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
ViennaRefactoringBrowser >> model: aViennaNode with: anIdentityDictionary [
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
ViennaRefactoringBrowser >> modelChanged [
	self updateModuleList
]

{ #category : #accessing }
ViennaRefactoringBrowser >> module [
	^ moduleList selection selectedItem
]

{ #category : #menus }
ViennaRefactoringBrowser >> moduleListContextMenu [

	| menu |
	menu := self newMenu.
	self module
		ifNotNil: [ :module | 
			menu addGroup: [ :group | 
				(ViennaRefactoring sortedInstancesOn: module) do: [ :refactoring | 
					group addItem: [ :item | 
						item
							name: refactoring name;
							action: [ self executeRefactoring: refactoring ] ] ] ] ]
		ifNil: [ 
			menu addGroup: [ :group | 
				(ViennaRefactoring sortedInstancesOn: self specification) do: [ 
					:refactoring | 
					group addItem: [ :item | 
						item
							name: refactoring name;
							action: [ self executeRefactoring: refactoring ] ] ] ] ].
	menu addGroup: [ :group | 
		menu addItem: [ :item | 
			item
				name: 'inspect';
				action: [ self module inspect ] ] ].
	^ menu
]

{ #category : #operations }
ViennaRefactoringBrowser >> openDirectory [
	| modelFiles testFiles source |
	(UIManager default
		chooseDirectory: 'Open directory'
		from: FileLocator home)
		ifNotNil: [ :dir | 
			modelFiles := OrderedCollection new.
			testFiles := OrderedCollection new.
			dir files
				do: [ :file | 
					(file basename endsWith: '.vdmsl')
						ifTrue: [ (file basename endsWith: 'Test.vdmsl')
								ifTrue: [ testFiles add: file ]
								ifFalse: [ modelFiles add: file ] ] ].
			modelFiles := modelFiles
				asSortedCollection: [ :less :more | less basename <= more basename ].
			testFiles := testFiles
				asSortedCollection: [ :less :more | less basename <= more basename ].
			source := String
				streamContents: [ :writeStream | 
					modelFiles
						do: [ :file | 
							writeStream
								nextPutAll:
									((file contents copyWith: Character cr)
										copyReplaceAll: String lf
										with: String cr) ].
					testFiles
						do: [ :file | 
							writeStream
								nextPutAll:
									((file contents copyWith: Character cr)
										copyReplaceAll: String lf
										with: String cr) ] ].
			self load: source ]
]

{ #category : #private }
ViennaRefactoringBrowser >> parser [
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

{ #category : #operations }
ViennaRefactoringBrowser >> runAllTests [
	testProcess ifNotNil: [ testProcess terminate ].
	testProcess := [ | ast animation |
	testResultTable items: #().
	ast := self specification ifNil: [ ^ nil ].
	animation := ViennaAnimation default
		specification: (ViennaVDMFormatter format: ast);
		yourself.
	(ast at: 1) label = 'Module'
		ifTrue: [ ast
				do: [ :moduleNode | 
					| moduleName |
					moduleName := moduleNode first.
					(moduleName endsWith: 'Test')
						ifTrue: [ moduleNode third
								do: [ :definitionBlockNode | 
									definitionBlockNode first label = 'OperationDefinitions'
										ifTrue: [ definitionBlockNode first
												do: [ :accessOperationDefinitionNode | 
													| operationName |
													operationName := accessOperationDefinitionNode second
														first first.
													(operationName size > 4
														and: [ (operationName copyFrom: 1 to: 4) = 'test' ])
														ifTrue: [ testResultTable
																items:
																	(testResultTable model items
																		copyWith:
																			(self
																				runTestModule: moduleName
																				operation: operationName
																				animation: animation)) ] ] ] ] ] ] ]
		ifFalse: [  ].
	testProcess := nil ] forkAt: Processor userBackgroundPriority
]

{ #category : #'private-unit testing' }
ViennaRefactoringBrowser >> runTestModule: module operation: operation animation: aViennaAnimation [
	| header |
	header := 'Runtime: Error 4129: Exit '.
	aViennaAnimation state: Dictionary new.
	[ [ aViennaAnimation
		plainEvaluate: operation , '()'
		in: module
		ifError: [ :msg | 
			(msg size > header size
				and: [ (msg copyFrom: 1 to: header size) = header ])
				ifTrue: [ ViennaException
						expression: (ViennaReader new parse: (msg copyFrom: header size + 1 to: msg size)) ]
				ifFalse: [ Error signal: msg ] ] ]
		on: ViennaException
		do: [ :exception | 
			exception expression
				in: [ :expr | 
					(expr isViennaComposite
						and: [ expr constructorName = 'AssertFailure' ])
						ifTrue: [ ^ (ViennaTestFailureResultItem
								module: module
								operation: operation
								message: 'assertion failed: ' , (expr at: 1) asString)
								inform;
								yourself ].
					(expr isViennaComposite
						and: [ expr constructorName = 'AssertEqualsFailure' ])
						ifTrue: [ ^ (ViennaTestFailureResultItem
								module: module
								operation: operation
								message:
								'assertion failed: ' , (expr at: 3) asString , ' expected: '
								, (expr at: 2) viennaString , ' actual: '
								, (expr at: 1) viennaString)
								inform;
								yourself ].
					^ (ViennaTestErrorResultItem
						module: module
						operation: operation
						message: expr viennaString)
						inform;
						yourself ] ] ]
		on: Error
		do: [ :exception | 
			^ (ViennaTestErrorResultItem
				module: module
				operation: operation
				message: exception printString)
				inform;
				yourself ].
	^ ViennaTestSuccessResultItem
		module: module
		operation: operation
		message: 'OK'
]

{ #category : #accessing }
ViennaRefactoringBrowser >> source [
	^ self specification
		ifNil: [ String new ]
		ifNotNil: [ :ast | ViennaVDMFormatter format: ast ]
]

{ #category : #menus }
ViennaRefactoringBrowser >> sourceTextContextMenu [
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
ViennaRefactoringBrowser >> specification [
	^ self model
]

{ #category : #menus }
ViennaRefactoringBrowser >> testResultTableContextMenu [
	^ self newMenu
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: 'Jump to test operation';
						action: [ testResultTable selection selectedItem
								ifNotNil: [ :testResultItem | 
									self
										jumpToModule: testResultItem module
										operation: testResultItem operation ] ] ] ]
]

{ #category : #updating }
ViennaRefactoringBrowser >> updateCategoryList [
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
ViennaRefactoringBrowser >> updateDefinitionList [
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
ViennaRefactoringBrowser >> updateModuleList [

	| newItems oldSelection |
	newItems := self specification
		            ifNotNil: [ :ast | 
		            ast asArray ifEmpty: [ Array with: nil ] ]
		            ifNil: [ Array with: nil ].
	oldSelection := moduleList selection selectedItem.
	moduleList items: newItems.
	(newItems includes: oldSelection)
		ifTrue: [ moduleList selectItem: oldSelection ]
		ifFalse: [ moduleList unselectAll ]
]

{ #category : #updating }
ViennaRefactoringBrowser >> updateSource [
	self definition
		ifNotNil: [ :node | sourceText text: (self getSource: node) ]
		ifNil: [ sourceText text: '' ]
]
