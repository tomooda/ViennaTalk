Class {
	#name : #ViennaASTBrowser,
	#superclass : #SpPresenterWithModel,
	#instVars : [
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
				add: #moduleList;
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
	self definitionBase
		ifNotNil: [ :definition | 
			| node |
			node := definition.
			[ node notNil ]
				whileTrue: [ menu
						addGroup: [ :group | 
							ViennaRefactoring
								on: node
								do: [ :refactoring | 
									group
										addItem: [ :item | 
											item
												name: refactoring name;
												action: [ refactoring execute.
													self
														updateModuleList;
														updateCategoryList;
														updateDefinitionList;
														updateSource ] ] ] ].
					node := node parent ] ].
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
			aViennaNode label = 'StateDefinition'
				ifTrue: [ ^ aViennaNode second asArray  ].
			^ aViennaNode asArray ].
	^ Array new
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
			node label = 'Field'
				ifTrue: [ ^ aViennaNode first ].
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
				ifTrue: [ ^ node first ] ].
	^ '-'
]

{ #category : #initialization }
ViennaASTBrowser >> initializePresenters [
	super initializePresenter.
	moduleList := self newList
		beSingleSelection;
		display: [ :ast | ast first ];
		whenSelectionChangedDo: [ self updateCategoryList ];
		yourself.
	categoryList := self newList
		beSingleSelection;
		display: [ :ast | 
			ast
				ifNotNil: [ self class sectionNames at: ast label ifAbsent: [ ast label ] ]
				ifNil: [ '-' ] ];
		whenSelectionChangedDo: [ self updateDefinitionList ];
		yourself.
	definitionList := self newList
		beSingleSelection;
		contextMenu: [ self definitionListContextMenu ];
		display:
				[ :ast | ast ifNotNil: [ self displayDefinition: ast ] ifNil: [ '-' ] ];
		whenSelectionChangedDo: [ :selection | 
			(selection notNil and: [ ActiveHand shiftPressed ])
				ifTrue: [ self updateAppendSource ]
				ifFalse: [ self updateSource ] ].
	sourceText := self newText
		contextMenu: [ self sourceTextContextMenu ];
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
ViennaASTBrowser >> modelChanged [
	self updateModuleList
]

{ #category : #accessing }
ViennaASTBrowser >> module [
	^ moduleList selection selectedItem
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
					ViennaRefactoring
						on: node
						do: [ :refactoring | 
							group
								addItem: [ :item | 
									item
										name: refactoring name;
										action: [ refactoring execute.
											self
												updateModuleList;
												updateCategoryList;
												updateDefinitionList;
												updateSource ] ] ] ] ].
	^ menu
]

{ #category : #updating }
ViennaASTBrowser >> updateAppendSource [
	self definition
		ifNotNil: [ :node | 
			sourceText
				text: sourceText text , String cr asText , node tracingHighlightedSource ]
]

{ #category : #updating }
ViennaASTBrowser >> updateCategoryList [
	| newItems oldSelection |
	newItems := (Array with: self module)
		,
			(self module
				ifNotNil: [ :ast | 
					(ast
						detect: [ :node | node isViennaNode and: [ node label = 'ModuleBody' ] ]
						ifNone: [  ])
						ifNotNil: [ :body | body collect: [ :node | node first ] ]
						ifNil: [ Array new ] ]
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
	newItems := self model
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
		ifNotNil: [ :node | sourceText text: node tracingHighlightedSource ]
]
