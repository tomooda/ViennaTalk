Class {
	#name : #ViennaRefactoringBrowser,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'animation',
		'menuBar',
		'notebook',
		'moduleList',
		'categoryList',
		'definitionList',
		'sourceText',
		'testResultTable',
		'sourceSignalButton',
		'talkbackLabel',
		'playgroundText',
		'stateTable',
		'initStateButton',
		'pendingSyntaxError',
		'pendingTypeError',
		'testProcess',
		'highlighterProcess',
		'dirty',
		'refreshStateButton',
		'showsTimeLineButton',
		'showsConstructionLineButton',
		'epiLogMatcherDropList',
		'epiLogList',
		'epiLogDiffList',
		'epiLogDiffText'
	],
	#classVars : [
		'GreenSignalIcon',
		'RedSignalIcon',
		'TrafficSide',
		'YellowSignalIcon'
	],
	#category : #'ViennaTalk-Browser-Core-Browsers'
}

{ #category : #settings }
ViennaRefactoringBrowser class >> beLeftSideTraffic [

	self trafficSide: #left
]

{ #category : #settings }
ViennaRefactoringBrowser class >> beRightSideTraffic [

	self trafficSide: #right
]

{ #category : #icons }
ViennaRefactoringBrowser class >> createSignalIcon: color1 with: color2 with: color3 [

	| form |
	form := Form extent: 42 @ 12 depth: 32.
	form getCanvas
		fillColor: Color transparent;
		fillOval: (1 @ 0 extent: 12 @ 12)
		color: color1
		borderWidth: 1
		borderColor: color1 darker;
		fillOval: (15 @ 0 extent: 12 @ 12)
		color: color2
		borderWidth: 1
		borderColor: color2 darker;
		fillOval: (29 @ 0 extent: 12 @ 12)
		color: color3
		borderWidth: 1
		borderColor: color3 darker.
	^ form
]

{ #category : #layout }
ViennaRefactoringBrowser class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #menuBar height: self buttonHeight;
		  add: (SpPanedLayout newVertical
				   positionOfSlider: 0.3;
				   add: (SpBoxLayout newHorizontal
						    add: #moduleList;
						    add: #categoryList;
						    add: #definitionList);
				   add: #notebook);
		  yourself
]

{ #category : #settings }
ViennaRefactoringBrowser class >> defaultTrafficSide [

	^ #left
]

{ #category : #'instance creation' }
ViennaRefactoringBrowser class >> empty [

	<script: 'ViennaRefactoringBrowser empty open'>
	^ self new
]

{ #category : #examples }
ViennaRefactoringBrowser class >> exampleATC [

	(ViennaRefactoringBrowser on: (ViennaVDMParser new parse:
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

end ATC')) open
]

{ #category : #examples }
ViennaRefactoringBrowser class >> exampleCounter [

	(ViennaRefactoringBrowser on:
		 (ViennaVDMParser new parse:
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
')) open
]

{ #category : #icons }
ViennaRefactoringBrowser class >> greenSignalIcon [

	^ GreenSignalIcon ifNil: [
		  GreenSignalIcon := self
			                     ifLeftSideTraffic: [
				                     self
					                     createSignalIcon: Color green lighter
					                     with: Color darkGray
					                     with: Color darkGray ]
			                     ifRightSideTraffic: [
				                     self
					                     createSignalIcon: Color darkGray
					                     with: Color darkGray
					                     with: Color green lighter ] ]
]

{ #category : #settings }
ViennaRefactoringBrowser class >> ifLeftSideTraffic: leftBlock ifRightSideTraffic: rightBlock [

	^ (TrafficSide ifNil: [ TrafficSide := self defaultTrafficSide ])
	  = #left
		  ifTrue: leftBlock
		  ifFalse: rightBlock
]

{ #category : #icons }
ViennaRefactoringBrowser class >> redSignalIcon [

	^ RedSignalIcon ifNil: [
		  RedSignalIcon := self
			                   ifLeftSideTraffic: [
				                   self
					                   createSignalIcon: Color darkGray
					                   with: Color darkGray
					                   with: Color red lighter ]
			                   ifRightSideTraffic: [
				                   self
					                   createSignalIcon: Color red lighter
					                   with: Color darkGray
					                   with: Color darkGray ] ]
]

{ #category : #settings }
ViennaRefactoringBrowser class >> trafficSide [

	^ TrafficSide ifNil: [ TrafficSide := self defaultTrafficSide ]
]

{ #category : #settings }
ViennaRefactoringBrowser class >> trafficSide: aSymbol [

	TrafficSide := aSymbol = #left
		               ifTrue: [ #left ]
		               ifFalse: [ #right ].
	GreenSignalIcon := nil.
	YellowSignalIcon := nil.
	RedSignalIcon := nil.
	self allInstancesDo: [ :browser | browser updateSourceSignalButton ]
]

{ #category : #settings }
ViennaRefactoringBrowser class >> trafficSides [

	^ #( left right )
]

{ #category : #menus }
ViennaRefactoringBrowser class >> viennaDevMenuOn: aBuilder [
	<ViennaDev>
	(aBuilder item: #'Refactoring example (ATC)')
		action: [ self exampleATC  ];
		order: 3;
		help: 'Example spec on refactoring borwser';
		icon: nil
]

{ #category : #settings }
ViennaRefactoringBrowser class >> viennaSettingsOn: aBuilder [

	<systemsettings>
	(aBuilder pickOne: #trafficSide)
		parent: #ViennaTalkAppearances;
		target: self;
		description: 'The look of traffic signal';
		label: 'Traffic side';
		domainValues: self trafficSides;
		default: self trafficSide;
		order: 0.9
]

{ #category : #menus }
ViennaRefactoringBrowser class >> viennaToolsMenuOn: aBuilder [

	<ViennaToolsMenu>
	(aBuilder item: #'VDM Refactoring Browser')
		action: [ self empty open ];
		order: 0.1;
		help: 'AST-based VDM-SL browser with refactoring support';
		icon: nil
]

{ #category : #menus }
ViennaRefactoringBrowser class >> worldMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #'VDM Refactoring Browser')
		action: [ self empty open ];
		order: 0.1;
		parent: #ViennaTalk;
		help: 'AST-based VDM-SL browser with refactoring support';
		icon: nil
]

{ #category : #icons }
ViennaRefactoringBrowser class >> yellowSignalIcon [

	^ YellowSignalIcon ifNil: [
		  YellowSignalIcon := self
			                      ifLeftSideTraffic: [
				                      self
					                      createSignalIcon: Color darkGray
					                      with: Color yellow lighter
					                      with: Color darkGray ]
			                      ifRightSideTraffic: [
				                      self
					                      createSignalIcon: Color darkGray
					                      with: Color yellow lighter
					                      with: Color darkGray ] ]
]

{ #category : #operations }
ViennaRefactoringBrowser >> accept: aStringOrText [

	| newNode newAst copyMap parent oldNode module category definition |
	newNode := self parser
		           parse: aStringOrText asString
		           onError: [ ^ false ].
	module := self module.
	category := self category.
	definition := self definition.
	copyMap := IdentityDictionary new.
	newAst := self specification copyWhole: copyMap.
	oldNode := copyMap at: self definition ifAbsent: [ ^ false ].
	oldNode class = newNode class ifFalse: [ ^ false ].
	parent := oldNode parent.
	1 to: parent size do: [ :index |
		(parent at: index) == oldNode ifTrue: [
			parent at: index put: newNode ] ].
	copyMap keys do: [ :old |
		(copyMap at: old) == oldNode ifTrue: [ copyMap at: old put: newNode ] ].
	self epiLogManualEdit: newAst.
	self updateModuleList.
	moduleList selectItem: (copyMap at: module ifAbsent: [ nil ]).
	categoryList selectItem: (copyMap at: category ifAbsent: [ nil ]).
	definitionList selectItem: (copyMap at: definition ifAbsent: [ nil ]).
	^ newNode
]

{ #category : #menus }
ViennaRefactoringBrowser >> addRefactoringMenuGroupOn: aViennaNode to: aMenuPresenter with: aBlock [

	aMenuPresenter addGroup: [ :group |
		(ViennaRefactoring sortedInstancesOn: aViennaNode) do: [
			:refactoring |
			group addItem: [ :item |
				item
					name: refactoring name;
					action: [ self executeRefactoring: refactoring ] ] ].
		aBlock cull: group ]
]

{ #category : #accessing }
ViennaRefactoringBrowser >> category [
	^ categoryList selection selectedItem
]

{ #category : #menus }
ViennaRefactoringBrowser >> categoryListContextMenu [

	| menu |
	menu := self newMenu.
	self category ifNotNil: [ :category |
		menu addGroup: [ :group |
			(ViennaRefactoring
				 sortedInstancesOn: category
				 suchthat: #isForCategoryList) do: [ :refactoring |
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

{ #category : #private }
ViennaRefactoringBrowser >> clearDirty [

	dirty := false
]

{ #category : #'private-unit testing' }
ViennaRefactoringBrowser >> debugTestResultItem: aViennaTestResultItem [

	^ (ViennaTranspiledAnimation new
		   specification: self specification ifError: [ :msg | ^ nil ];
		   yourself)
		  debug: aViennaTestResultItem operation , '()'
		  in: aViennaTestResultItem module
		  ifError: [ :msg | msg ]
]

{ #category : #accessing }
ViennaRefactoringBrowser >> definition [
	^ definitionList selection selectedItem
]

{ #category : #accessing }
ViennaRefactoringBrowser >> definitionBase [

	^ self definition
]

{ #category : #menus }
ViennaRefactoringBrowser >> definitionListContextMenu [

	| menu |
	menu := self newMenu.
	self definitionBase ifNotNil: [ :definition |
		menu addGroup: [ :group |
			(ViennaRefactoring
				 sortedInstancesOn: definition
				 suchthat: #isForDefinitionList) do: [ :refactoring |
				group addItem: [ :item |
					item
						name: refactoring name;
						action: [ self executeRefactoring: refactoring ] ] ] ] ].
	menu addGroup: [ :group |
		menu addItem: [ :item |
			item
				name: 'inspect';
				action: [ self definitionBase inspect ] ] ].
	^ menu
]

{ #category : #private }
ViennaRefactoringBrowser >> definitionsFromCategory: aViennaNode [

	^ aViennaNode isViennaNode
		  ifTrue: [
			  (aViennaNode isViennaModuleNode or: [
				   aViennaNode isViennaSectionNode ])
				  ifTrue: [
					  Array streamContents: [ :stream |
						  aViennaNode toplevelDefinitionsDo: [ :node |
							  stream nextPut: node ] ] ]
				  ifFalse: [ Array new ] ]
		  ifFalse: [ Array new ]
]

{ #category : #private }
ViennaRefactoringBrowser >> displayCategory: aViennaNode [

	aViennaNode ifNil: [ ^ '-' ].
	aViennaNode isViennaImportSignatureNode ifTrue: [
		^ 'from ' , aViennaNode moduleIdentifier , ' '
		  , aViennaNode refactoringBrowserSectionName ].
	^ aViennaNode refactoringBrowserSectionName ifNil: [ '?' ]
]

{ #category : #private }
ViennaRefactoringBrowser >> displayDefinition: aViennaNode [

	aViennaNode allDescendantsDo: [ :node |
		node isViennaModuleNode ifTrue: [ ^ ' - all - ' ].
		node isViennaSectionNode ifTrue: [ ^ ' - all - ' ].
		node isViennaTypeSynonymNode ifTrue: [ ^ node identifier ].
		node isViennaRecordTypeDefinitionNode ifTrue: [ ^ node identifier ].
		node isViennaValueDefinitionNode ifTrue: [ ^ node pattern source ].
		node isViennaStateDefinitionNode ifTrue: [ ^ node identifier ].
		node isViennaExplicitFunctionDefinitionNode ifTrue: [
			^ node identifier ].
		node isViennaImplicitFunctionDefinitionNode ifTrue: [
			^ node identifier ].
		node isViennaExplicitOperationDefinitionNode ifTrue: [
			^ node identifier ].
		node isViennaImplicitOperationDefinitionNode ifTrue: [
			^ node identifier ].
		node isViennaImportSignatureNode ifTrue: [ ^ '- all -' ].
		node isViennaImportNode ifTrue: [
			^ node rename
				  ifNotNil: [ :localName | localName shortName ]
				  ifNil: [ node module identifier , '`' , node identifier ] ] ].
	^ '-'
]

{ #category : #accessing }
ViennaRefactoringBrowser >> epiLog [

	^ self model
]

{ #category : #accessing }
ViennaRefactoringBrowser >> epiLog: aViennaEpiLog [

	self model: aViennaEpiLog
]

{ #category : #'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogEvaluation: aString [

	self epiLog: (self epiLog newEvaluation: aString)
]

{ #category : #'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogExecution: aString state: aDictionary [

	self epiLog: (self epiLog newExecution: aString state: aDictionary)
]

{ #category : #'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogInitialization: aDictionary [

	self epiLog: (self epiLog newInitialization: aDictionary)
]

{ #category : #menus }
ViennaRefactoringBrowser >> epiLogListContextMenu [

	| menu |
	menu := self newMenu.
	epiLogList selectedItem ifNotNil: [ :epilog |
		menu addGroup: [ :group |
			group addItem: [ :item |
				item
					name: 'Revert to';
					action: [ self revertTo: epilog ] ] ] ].
	^ menu
]

{ #category : #'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogLoading: aViennaModularDocumentNode [

	self epiLog: (self epiLog newLoading: aViennaModularDocumentNode)
]

{ #category : #'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogManualEdit: aViennaModularDocumentNode [

	self epiLog:
		((self epiLog newModification: aViennaModularDocumentNode)
			 comment: 'manual edit';
			 yourself)
]

{ #category : #'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogMergeFRAM: aViennaModularDocumentNode [

	self epiLog:
		((self epiLog newModification: aViennaModularDocumentNode)
			 comment: 'merge from FRAM';
			 yourself)
]

{ #category : #'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogRefactoring: aViennaModularDocumentNode with: aViennaRefactoring [

	self epiLog:
		((self epiLog newModification: aViennaModularDocumentNode)
			 comment: aViennaRefactoring name;
			 yourself)
]

{ #category : #'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogRevertion: aViennaEpiLog [

	self epiLog: (self epiLog newRevertion: aViennaEpiLog)
]

{ #category : #layouts }
ViennaRefactoringBrowser >> epilogPageLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.4;
		  add: (SpBoxLayout newVertical
				   add: (SpBoxLayout newHorizontal
						    add: showsTimeLineButton;
						    add: showsConstructionLineButton;
						    yourself)
				   expand: false;
				   add: epiLogMatcherDropList expand: false;
				   add: epiLogList;
				   yourself);
		  add: (SpPanedLayout newVertical
				   positionOfSlider: 0.3;
				   add: epiLogDiffList;
				   add: epiLogDiffText);
		  yourself
]

{ #category : #operations }
ViennaRefactoringBrowser >> executeRefactoring: aViennaRefactoring [

	| newAst copyMap refactoring result |
	copyMap := IdentityDictionary new.
	newAst := self specification copyWhole: copyMap.
	refactoring := aViennaRefactoring class new ast:
		               (copyMap
			                at: aViennaRefactoring ast
			                ifAbsent: [ ^ false ]).
	refactoring check ifFalse: [ ^ false ].
	result := refactoring execute.
	self epiLogRefactoring: newAst with: refactoring.
	self updateModuleList.
	result ifNotNil: [
		moduleList selectItem: result module.
		categoryList selectItem:
			(result section ifNil: [ moduleList selectedItem ]).
		definitionList selectItem:
			(result topLevelDefinition ifNil: [ categoryList selectedItem ]) ]
]

{ #category : #operations }
ViennaRefactoringBrowser >> export [

	(UIManager default
		 confirm: 'Export to'
		 trueChoice: 'Directory'
		 falseChoice: 'File')
		ifTrue: [ self exportDirectory ]
		ifFalse: [ self exportFile ]
]

{ #category : #operations }
ViennaRefactoringBrowser >> exportDirectory [

	(UIManager default
		 chooseDirectory: 'Export directory'
		 from: FileLocator viennaTalkDocumentDirectory) ifNotNil: [ :dir |
		self specification modulesDo: [ :moduleNode |
			| file |
			file := dir / moduleNode name withExtension: 'vdmsl'.
			file
				ensureDeleteAll;
				writeStreamDo: [ :stream |
					stream nextPutAll:
							((ViennaVDMFormatter format: moduleNode) withLineEndings:
									 OSPlatform current lineEnding) ] ].
		UIManager default message: 'Exported to ' , dir basename , '/.'.
		self clearDirty ]
]

{ #category : #operations }
ViennaRefactoringBrowser >> exportFile [

	(UIManager default
		 chooseForSaveFileReference: 'Export file'
		 extensions: #( 'vdmsl' )
		 path: FileLocator viennaTalkDocumentDirectory asFileReference)
		ifNotNil: [ :file |
			file
				ensureDeleteAll;
				writeStreamDo: [ :stream |
					stream nextPutAll:
							(self source withLineEndings: OSPlatform current lineEnding) ].
			UIManager default message: 'Exported to ' , file basename , '.'.
			self clearDirty ]
]

{ #category : #private }
ViennaRefactoringBrowser >> getSource: aViennaNode [
	aViennaNode ifNil: [ ^ String ].
	^ aViennaNode tracingHighlightedSource
]

{ #category : #operations }
ViennaRefactoringBrowser >> highlightSlice: aViennaNode [

	(aViennaNode
		 detectParent: #isViennaOperationDefinitionNode
		 ifNone: [ nil ]) ifNotNil: [ :operation |
		| slicer |
		slicer := ViennaSlicer
			          operation: operation
			          criteria: { aViennaNode }
			          startNode: aViennaNode.
		slicer sliceNodes , { aViennaNode } ifNotEmpty: [ :nodes |
			| source text gray textWidget |
			source := sourceText text string asViennaTracingString.
			sourceText withAdapterDo: [ :a |
				a widgetDo: [ :w | textWidget := w ] ].
			text := textWidget text.
			gray := Color gray: 0.9.
			nodes do: [ :node |
				(source intervalForSource: node) key ifNotEmpty: [ :interval |
					text
						addAttribute: TextBackgroundColor yellow
						from: interval first
						to: interval last ] ].
			textWidget textArea ifNotNil: #compose ] ]
]

{ #category : #operations }
ViennaRefactoringBrowser >> highlightSourceText [

	highlighterProcess ifNotNil: [
		highlighterProcess terminate.
		highlighterProcess := nil ].
	highlighterProcess := [
	                      | source highlighter context result newNode newAst copyMap parent oldNode |
	                      source := sourceText text asString copy.
	                      highlighter := ViennaVDMHighlighter new.
	                      highlighter text: source asText.
	                      context := ViennaPP2HighlightingContext new.
	                      result := highlighter
		                                parse: source
		                                withContext: context.
	                      result isPetit2Failure
		                      ifTrue: [ self notifySintaxError: result ]
		                      ifFalse: [
			                      self notifySintaxError: nil.
			                      source size = highlighter text runs size
				                      ifTrue: [
					                      sourceText withAdapterDo: [ :a |
						                      a widgetDo: [ :w |
							                      w text runs: highlighter text runs.
							                      w changed ] ] ].
			                      newNode := result returnValue.
			                      copyMap := IdentityDictionary new.
			                      newAst := self specification copyWhole:
				                                copyMap.
			                      oldNode := copyMap
				                                 at: self definition
				                                 ifAbsent: [  ].
			                      oldNode class = newNode class ifTrue: [
				                      parent := oldNode parent.
				                      1 to: parent size do: [ :index |
					                      (parent at: index) == oldNode ifTrue: [
						                      parent at: index put: newNode ] ].
				                      copyMap keys do: [ :old |
					                      (copyMap at: old) == oldNode ifTrue: [
						                      copyMap at: old put: newNode ] ].
				                      [
				                      newNode typecheck.
				                      self notifyTypeError: nil ]
					                      on: ViennaTypeError
					                      do: [ :ex | self notifyTypeError: ex ] ] ].
	                      highlighterProcess := nil ] forkAt:
		                      Processor userBackgroundPriority
]

{ #category : #controlling }
ViennaRefactoringBrowser >> ifShowsTimeLine: timeLineBlock ifShowsConstructionLine: constructionLineBlock [

	showsTimeLineButton state = true ifTrue: [ ^ timeLineBlock value ].
	showsConstructionLineButton state = true ifTrue: [
		^ constructionLineBlock value ].
	^ nil
]

{ #category : #operations }
ViennaRefactoringBrowser >> importDirectory [
	| modelFiles testFiles source |
	(UIManager default
		chooseDirectory: 'Import directory'
		from: FileLocator viennaTalkDocumentDirectory)
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
		 path: FileLocator viennaTalkDocumentDirectory) ifNotNil: [ :file | 
		self load: file contents withInternalLineEndings ]
]

{ #category : #operations }
ViennaRefactoringBrowser >> initState [

	animation init.
	self updateStateTable.
	self epiLogInitialization: animation state
]

{ #category : #initialization }
ViennaRefactoringBrowser >> initialize [

	animation := ViennaAnimation default.
	animation announcer
		when: ViennaStateChanged do: [ self updateStateTable ];
		when: ViennaSpecificationChanged do: [ self updateStateTableItems ].
	super initialize.
	self epiLog: ViennaEpiLog vanilla.
	dirty := false
]

{ #category : #initialization }
ViennaRefactoringBrowser >> initializeEpiLogPagePresenters [

	showsTimeLineButton := self newRadioButton
		                       label: 'time line';
		                       whenActivatedDo: [ self updateEpiLogList ];
		                       yourself.
	showsConstructionLineButton := self newRadioButton
		                               label: 'construction line';
		                               whenActivatedDo: [
			                               self updateEpiLogList ];
		                               yourself.
	showsTimeLineButton associatedRadioButtons:
		{ showsConstructionLineButton }.
	epiLogMatcherDropList := self newDropList
		                         items: { ViennaEpiLogMatcher all };
		                         startWithSelection;
		                         whenSelectionChangedDo: [
			                         self updateEpiLogList ];
		                         yourself.
	epiLogList := self newTable
		              hideColumnHeaders;
		              beResizable;
		              addColumn:
			              (SpStringTableColumn evaluated: [ :epilog |
					               | time |
					               time := DateAndTime now - epilog timestamp.
					               time < 1 minutes
						               ifTrue: [ 'now' ]
						               ifFalse: [ time printRoughly , ' ago' ] ]);
		              addColumn:
			              (SpStringTableColumn evaluated: #printString);
		              addColumn: (SpStringTableColumn evaluated: #comment);
		              contextMenu: [ self epiLogListContextMenu ];
		              whenSelectionChangedDo: [ self updateEpiLogDiffList ];
		              yourself.
	epiLogDiffList := self newTable
		                  hideColumnHeaders;
		                  beResizable;
		                  addColumn:
			                  (SpStringTableColumn evaluated: #printSummary);
		                  addColumn:
			                  (SpStringTableColumn evaluated: #printNames);
		                  whenSelectionChangedDo: [
			                  self updateEpiLogDiffText ];
		                  yourself.
	epiLogDiffText := self newText.
	epiLogList whenBuiltDo: [ self updateEpiLogList ]
]

{ #category : #initialization }
ViennaRefactoringBrowser >> initializePlaygroundPagePresenters [

	playgroundText := self newVDMSource
		                  animation: [ animation ];
		                  module: [ self module ];
		                  withoutLineNumbers;
		                  whenEvaluatedDo: [ :expression |
			                  self epiLogEvaluation: expression ];
		                  whenExecutedDo: [ :statement |
			                  self
				                  epiLogExecution: statement
				                  state: animation state ];
		                  yourself.
	stateTable := self newTable
		              addColumn: (SpStringTableColumn
				               title: 'module'
				               evaluated: [ :string |
					               string copyFrom: 1 to: (string indexOf: $`) - 1 ]);
		              addColumn: (SpStringTableColumn
				               title: 'variable'
				               evaluated: [ :string |
					               string
						               copyFrom: (string indexOf: $`) + 1
						               to: string size ]);
		              addColumn: (SpStringTableColumn
				               title: 'value'
				               evaluated: [ :string | animation plainAt: string ]);
		              yourself.
	initStateButton := self newButton
		                   icon: (Smalltalk ui iconNamed: #refresh);
		                   label: 'initialize';
		                   action: [ self initState ];
		                   yourself.
	refreshStateButton := self newButton
		                      icon: (Smalltalk ui iconNamed: #smallUpdate);
		                      label: 'refresh';
		                      action: [ self updateStateTableItems ];
		                      yourself
]

{ #category : #initialization }
ViennaRefactoringBrowser >> initializePresenters [

	super initializePresenters.
	menuBar := self menuBar.
	moduleList := self newList
		              beSingleSelection;
		              contextMenu: [ self moduleListContextMenu ];
		              display: [ :ast | ast ifNil: [ '-' ] ifNotNil: #first ];
		              whenSelectionChangedDo: [
			              self
				              updateCategoryList;
				              updateEpiLogMatcherDropList ];
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
		                  whenSelectionChangedDo: [
			                  self
				                  updateSource;
				                  updateEpiLogMatcherDropList ].
	self initializeSourcePagePresenters.
	self initializePlaygroundPagePresenters.
	self initializeEpiLogPagePresenters.
	notebook := self newNotebook
		            addPageTitle: 'Source' provider: [
			            SpPresenter new
				            layout: self sourcePageLayout;
				            yourself ];
		            addPageTitle: 'Playground' provider: [
		            SpPresenter new
			            layout: self playgroundPageLayout;
			            yourself ];
		            addPageTitle: 'EpiLog' provider: [
		            SpPresenter new
			            layout: self epilogPageLayout;
			            yourself ];
		            yourself.
	self whenBuiltDo: [ :w |
		| f |
		f := ViennaLauncher font.
		w widget allMorphsDo: [ :m |
			(m respondsTo: #font:) ifTrue: [ m font: f ] ] ]
]

{ #category : #initialization }
ViennaRefactoringBrowser >> initializeSourcePagePresenters [

	sourceSignalButton := self newButton
		                      color: Color transparent;
		                      icon: self class greenSignalIcon;
		                      action: [ self sourceSignalButtonPressed ];
		                      yourself.
	talkbackLabel := self newLabel
		                 label: '';
		                 displayBackgroundColor: [
			                 self pendingSyntaxError
				                 ifNotNil: [ Color red lighter ]
				                 ifNil: [
					                 self pendingTypeError
						                 ifNotNil: [ Color yellow lighter ]
						                 ifNil: [ Color transparent ] ] ];
		                 yourself.
	sourceText := self newVDMSource
		              animation: [ animation ];
		              module: [ self module ];
		              whenTextChangedDo: [ self onTheFlyCheckSourceText ];
		              whenSubmitDo: [ :text | self accept: text ];
		              whenEvaluatedDo: [ :expression |
			              self epiLogEvaluation: expression ];
		              whenExecutedDo: [ :statement |
			              self
				              epiLogExecution: statement
				              state: animation state ];
		              contextMenu: [ self sourceTextContextMenu ];
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
		                   yourself
]

{ #category : #initialization }
ViennaRefactoringBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 800 @ 600
]

{ #category : #'instance creation' }
ViennaRefactoringBrowser >> instantiate: aPresenterClass [

	^ (super instantiate: aPresenterClass)
		  font: ViennaLauncher font;
		  yourself
]

{ #category : #private }
ViennaRefactoringBrowser >> isDirty [

	^ dirty = true
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
				detect: [ :item | item identifier = anotherString ]
				ifNone: [ ^ self ]).
	self updateSource
]

{ #category : #operations }
ViennaRefactoringBrowser >> load: aString [

	| ast |
	ast := ViennaVDMParser new document end parse: aString.
	ast isPetit2Failure ifTrue: [
		UIManager default alert: 'Failed to parse the source.'.
		^ nil ].
	ast isViennaDocumentNode ifFalse: [ ^ nil ].
	ast isViennaFlatDocumentNode ifTrue: [
		ast := ViennaModularDocumentNode with: (ViennaModuleNode
				        identifier: 'DEFAULT'
				        interface: (ViennaInterfaceNode
						         importDefinitionList: nil
						         exportDefinition:
							         (ViennaExportDefinitionNode exportModuleSignature:
								          ViennaExportModuleSignatureAllNode new))
				        moduleBody: (ViennaModuleBodyNode withAll: ast asArray)) ].
	self epiLogLoading: ast.
	self updateModuleList.
	self clearDirty
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
								   g
									   addItem: [ :i | 
										   i
											   name: 'Merge annotations into FRAM...';
											   action: [ self mergeAnnotationsIntoFRAM ] ];
									   addItem: [ :i | 
										   i
											   name: 'Merge operations from FRAM...';
											   action: [ self mergeOperationsFromFRAM ] ] ]) ];
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
		 path: FileLocator viennaTalkDocumentDirectory) ifNotNil: [ :ref | 
		fram := ViennaFRAMModel fromFile: ref ].
	fram ifNil: [ ^ nil ].
	fram loadSpec: self specification.
	(UIManager default
		 chooseForSaveFileReference: 'Export file'
		 extensions: #( 'xfmv' )
		 path: FileLocator home asFileReference) ifNotNil: [ :ref | 
		fram writeXMLFile: ref ]
]

{ #category : #operations }
ViennaRefactoringBrowser >> mergeOperationsFromFRAM [

	| fram copyMap newAst |
	(UIManager default
		 chooseExistingFileReference: 'Import directory'
		 extensions: #( 'xfmv' )
		 path: FileLocator viennaTalkDocumentDirectory) ifNotNil: [ :ref |
		fram := ViennaFRAMModel fromFile: ref ].
	^ fram ifNotNil: [
		  | module category definition |
		  module := self module.
		  category := self category.
		  definition := self definition.
		  copyMap := IdentityDictionary new.
		  newAst := self specification copyWhole: copyMap.
		  fram appendToSpec: newAst.
		  self epiLogMergeFRAM: newAst.
		  moduleList selectItem: (copyMap at: module ifAbsent: [ nil ]).
		  categoryList selectItem: (copyMap at: category ifAbsent: [ nil ]).
		  definitionList selectItem:
			  (copyMap at: definition ifAbsent: [ nil ]).
		  newAst ]
]

{ #category : #accessing }
ViennaRefactoringBrowser >> modelChanged [

	self model ifNotNil: [ :epiLog |
		self updateEpiLogList.
		self setDirty.
		self typecheck.
		animation ifNotNil: [
			| state |
			state := epiLog state.
			animation
				specification: self specification
				ifError: [ :msg | self notifyAnimationError: msg ].
			animation state: state.
			epiLog state: animation state ].
		UIManager default inform:
			epiLog printString , ' - ' , epiLog comment ]
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
				(ViennaRefactoring
					 sortedInstancesOn: module
					 suchthat: #isForModuleList) do: [ :refactoring |
					group addItem: [ :item |
						item
							name: refactoring name;
							action: [ self executeRefactoring: refactoring ] ] ] ] ]
		ifNil: [
			menu addGroup: [ :group |
				(ViennaRefactoring
					 sortedInstancesOn: self specification
					 suchthat: #isForModuleList) do: [ :refactoring |
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

{ #category : #'instance creation' }
ViennaRefactoringBrowser >> newVDMSource [

	^ self instantiate: ViennaVDMSourcePresenter
]

{ #category : #'operations-source signal' }
ViennaRefactoringBrowser >> notifyAnimationError: aString [

]

{ #category : #'operations-source signal' }
ViennaRefactoringBrowser >> notifySintaxError: aPP2Failure [

	pendingSyntaxError := aPP2Failure.
	self updateSourceSignalButton.
	pendingSyntaxError ifNotNil: [
		| source textWidget |
		source := sourceText text asText.
		sourceText withAdapterDo: [ :a |
			a widgetDo: [ :w | textWidget := w ] ].
		source
			makeColor: Color red
			from: (aPP2Failure furthestPosition min: source size max: 1)
			to: source size.
		textWidget text runs: source runs.
		textWidget changed ]
]

{ #category : #'operations-source signal' }
ViennaRefactoringBrowser >> notifyTypeError: aViennaTypeError [

	| text textWidget |
	pendingTypeError := aViennaTypeError.
	self updateSourceSignalButton.
	sourceText withAdapterDo: [ :a |
		a widgetDo: [ :w |
			textWidget := w.
			textWidget textArea segments copy do: [ :s | s delete ] ] ].
	textWidget ifNil: [ ^ self ].
	text := textWidget text.
	textWidget textArea handleParagraphChange: [
		(pendingTypeError ifNotNil: #node) ifNotNil: [ :node |
			| from to |
			from := node start.
			to := node end.
			(from isNil or: [ to isNil ]) ifTrue: [
				(text asString asViennaTracingString intervalForSource: node) key
					ifNotEmpty: [ :interval |
						from := interval first.
						to := interval last ] ].
			(from notNil and: [ to notNil ]) ifTrue: [
				text
					addAttribute: (TextBackgroundColor color: Color yellow darker)
					from: from
					to: to ] ] ].
	textWidget textArea ifNotNil: #compose
]

{ #category : #private }
ViennaRefactoringBrowser >> okToClose [

	self isDirty ifFalse: [ ^ true ].
	(UIManager default
		 confirm: 'Export the spec before close?'
		 orCancel: [ ^ false ]) ifTrue: [ self export ].
	^ true
]

{ #category : #operations }
ViennaRefactoringBrowser >> onTheFlyCheckSourceText [
	self highlightSourceText
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

{ #category : #accessing }
ViennaRefactoringBrowser >> pendingSyntaxError [

	^ pendingSyntaxError
]

{ #category : #accessing }
ViennaRefactoringBrowser >> pendingTypeError [

	^ pendingTypeError
]

{ #category : #layouts }
ViennaRefactoringBrowser >> playgroundPageLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.6;
		  add: playgroundText;
		  add: (SpBoxLayout newVertical
				   add: stateTable;
				   add: (SpBoxLayout newHorizontal
						    add: refreshStateButton;
						    add: initStateButton;
						    yourself)
				   expand: false;
				   yourself);
		  yourself
]

{ #category : #accessing }
ViennaRefactoringBrowser >> playgroundSelection [

	| text start end node |
	text := playgroundText text asString.
	playgroundText selectionInterval in: [ :interval |
		start := interval first.
		end := interval last ].
	start > end ifTrue: [
		[ start > 1 and: [ (text at: start - 1) ~= Character cr ] ]
			whileTrue: [ start := start - 1 ].
		[ end < text size and: [ (text at: end + 1) ~= Character cr ] ]
			whileTrue: [ end := end + 1 ].
		playgroundText selectionInterval: (start to: end) ].
	node := ViennaVDMParser new expression parse:
		        (text copyFrom: start to: end).
	^ node isPetit2Failure
		  ifTrue: [ nil ]
		  ifFalse: [
			  node
				  parent: self module;
				  yourself ]
]

{ #category : #accessing }
ViennaRefactoringBrowser >> playgroundSelectionText [

	| text start end |
	text := playgroundText text asString.
	playgroundText selectionInterval in: [ :interval |
		start := interval first.
		end := interval last ].
	start > end ifTrue: [
		[ start > 1 and: [ (text at: start - 1) ~= Character cr ] ]
			whileTrue: [ start := start - 1 ].
		[ end < text size and: [ (text at: end + 1) ~= Character cr ] ]
			whileTrue: [ end := end + 1 ].
		playgroundText selectionInterval: (start to: end) ].
	^ (text copyFrom: start to: end) trim
]

{ #category : #menus }
ViennaRefactoringBrowser >> playgroundTextContextMenu [

	| menu |
	menu := self newMenu.
	self playgroundSelection ifNotNil: [ :node |
		menu addGroup: [ :group |
			group
				addItem: [ :item |
					item
						name: 'Evaluate it';
						action: [ playgroundText doEvaluateIt ] ];
				addItem: [ :item |
					item
						name: 'Type it';
						action: [ playgroundText doTypeIt ] ];
				addItem: [ :item |
					item
						name: 'Execute it';
						action: [ playgroundText doExecuteIt ] ] ] ].
	^ menu
]

{ #category : #operations }
ViennaRefactoringBrowser >> revertTo: aViennaEpiLog [

	self epiLogRevertion: aViennaEpiLog.
	self updateModuleList
]

{ #category : #operations }
ViennaRefactoringBrowser >> runAllTests [

	testProcess ifNotNil: [ testProcess terminate ].
	testProcess := [
	               | ast testAnimation |
	               testResultTable items: #(  ).
	               ast := self specification ifNil: [ ^ nil ].
	               testAnimation := ViennaAnimation default
		                                specification:
			                                (ViennaVDMFormatter format: ast);
		                                yourself.
	               (ast at: 1) isViennaModuleNode ifTrue: [
		               ast do: [ :moduleNode |
			               | moduleName |
			               moduleName := moduleNode identifier.
			               (moduleName endsWith: 'Test') ifTrue: [
				               moduleNode sectionsDo: [ :section |
					               section isViennaOperationDefinitionsNode ifTrue: [
						               section toplevelDefinitionsDo: [
							               :operationDefinition |
							               operationDefinition
								               isViennaExplicitOperationDefinitionNode
								               ifTrue: [
									               | operationName |
									               operationName := operationDefinition
										                                identifier.
									               (operationName size > 4 and: [
										                (operationName copyFrom: 1 to: 4) = 'test' ])
										               ifTrue: [
											               testResultTable items:
												               (testResultTable specification items
													                copyWith: (self
															                 runTestModule: moduleName
															                 operation: operationName
															                 animation: testAnimation)) ] ] ] ] ] ] ] ].
	               testProcess := nil ] forkAt:
		               Processor userBackgroundPriority
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

{ #category : #private }
ViennaRefactoringBrowser >> setDirty [

	dirty := true
]

{ #category : #accessing }
ViennaRefactoringBrowser >> source [
	^ self specification
		ifNil: [ String new ]
		ifNotNil: [ :ast | ViennaVDMFormatter format: ast ]
]

{ #category : #layouts }
ViennaRefactoringBrowser >> sourcePageLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.6;
		  add: (SpBoxLayout newVertical
				   add: (SpBoxLayout newHorizontal
						    add: sourceSignalButton width: 48;
						    add: talkbackLabel;
						    yourself)
				   height: 16;
				   add: sourceText);
		  add: testResultTable
]

{ #category : #accessing }
ViennaRefactoringBrowser >> sourceSelection [

	^ sourceText text string asViennaTracingString
		  nodeContaining: sourceText selectionInterval
		  ifAbsent: [ nil ]
]

{ #category : #accessing }
ViennaRefactoringBrowser >> sourceSelectionText [

	| text start end |
	text := sourceText text asString.
	sourceText selectionInterval in: [ :interval |
		start := interval first.
		end := interval last ].
	start > end ifTrue: [
		[ start > 1 and: [ (text at: start - 1) ~= Character cr ] ]
			whileTrue: [ start := start - 1 ].
		[ end < text size and: [ (text at: end + 1) ~= Character cr ] ]
			whileTrue: [ end := end + 1 ].
		sourceText selectionInterval: (start to: end) ].
	^ (text copyFrom: start to: end) trim
]

{ #category : #'operations-source signal' }
ViennaRefactoringBrowser >> sourceSignalButtonPressed [
]

{ #category : #menus }
ViennaRefactoringBrowser >> sourceTextContextMenu [

	| menu |
	menu := self newMenu.
	self sourceSelection ifNotNil: [ :node |
		menu addGroup: [ :group |
			group
				addItem: [ :item |
					item
						name: 'Evaluate it';
						action: [ sourceText doEvaluateIt ] ];
				addItem: [ :item |
					item
						name: 'Type it';
						action: [ sourceText doTypeIt ] ] ].
		self addRefactoringMenuGroupOn: node to: menu with: [ :group |  ].
		(node detectParent: #isViennaOperationDefinitionNode ifNone: [ nil ])
			ifNotNil: [
				menu addGroup: [ :group |
					group addItem: [ :item |
						item
							name: 'Highlight slice';
							action: [ self highlightSlice: node ] ] ] ] ].
	^ menu
]

{ #category : #accessing }
ViennaRefactoringBrowser >> specification [

	^ self epiLog specification
]

{ #category : #menus }
ViennaRefactoringBrowser >> testResultTableContextMenu [

	^ self newMenu addGroup: [ :group |
		  group
			  addItem: [ :item |
				  item
					  name: 'Debug it with transpiler';
					  action: [
						  testResultTable selection selectedItem ifNotNil: [
								  :testResultItem | self debugTestResultItem: testResultItem ] ] ];
			  addItem: [ :item |
				  item
					  name: 'Jump to test operation';
					  action: [
						  testResultTable selection selectedItem ifNotNil: [
								  :testResultItem |
								  self
									  jumpToModule: testResultItem module
									  operation: testResultItem operation ] ] ] ]
]

{ #category : #accessing }
ViennaRefactoringBrowser >> title [

	^ 'Vienna Refactoring Browser'
]

{ #category : #operations }
ViennaRefactoringBrowser >> typecheck [

	[
	self specification
		forgetTypecheck;
		typecheck.
	self notifyTypeError: nil ]
		on: ViennaTypeError
		do: [ :ex | self notifyTypeError: ex ]
]

{ #category : #updating }
ViennaRefactoringBrowser >> updateCategoryList [

	| newItems oldSelection |
	newItems := Array streamContents: [ :stream |
		            stream nextPut: self module.
		            self module ifNotNil: [ :moduleNode |
			            moduleNode importSignaturesDo: [ :importSignature |
				            stream nextPut: importSignature ].
			            moduleNode sectionsDo: [ :section |
				            stream nextPut: section ] ] ].
	oldSelection := categoryList selection selectedItem.
	categoryList items: newItems.
	(newItems includes: oldSelection) ifTrue: [
		categoryList selectItem: oldSelection ]
]

{ #category : #updating }
ViennaRefactoringBrowser >> updateDefinitionList [

	| newItems oldSelection |
	newItems := (Array with: self category) , (self category
		             ifNotNil: [ :ast | self definitionsFromCategory: ast ]
		             ifNil: [ Array new ]).
	oldSelection := definitionList selection selectedItem.
	definitionList items: newItems.
	(newItems includes: oldSelection) ifTrue: [
		definitionList selectItem: oldSelection ]
]

{ #category : #updating }
ViennaRefactoringBrowser >> updateEpiLogDiffList [

	epiLogList selectedItem ifNotNil: [ :epilog |
		epiLogDiffList items: (Array streamContents: [ :stream |
				 epilog diffSetFromPrev changesDo: [ :change |
					 stream nextPut: change ] ]) ]
]

{ #category : #updating }
ViennaRefactoringBrowser >> updateEpiLogDiffText [

	epiLogDiffList selectedItem
		ifNotNil: [ :diff |
			| text |
			text := diff sourceDiffText.
			epiLogDiffText text: text string asString asText.
			epiLogDiffText withAdapterDo: [ :a |
				a widgetDo: [ :w |
					w text runs: text runs.
					w textArea compose ] ] ]
		ifNil: [ epiLogDiffText text: '' ]
]

{ #category : #updating }
ViennaRefactoringBrowser >> updateEpiLogList [

	epiLogList ifNotNil: [
		epiLogList
			items: ((self epiLog ifNil: [ #(  ) ] ifNotNil: [ :epiLog |
					  self
						  ifShowsTimeLine: [ epiLog timeLine ]
						  ifShowsConstructionLine: [ epiLog constructionLine ] ])
					 select:
					 (epiLogMatcherDropList selectedItem ifNil: [ [ :epilog | true ] ]))
			selectsFirst: true ]
]

{ #category : #updating }
ViennaRefactoringBrowser >> updateEpiLogMatcherDropList [

	| selection |
	selection := epiLogMatcherDropList selectedItem.
	epiLogMatcherDropList items: (Array streamContents: [ :stream |
			 stream nextPut: ViennaEpiLogMatcher all.
			 moduleList selectedItem ifNotNil: [ :module |
				 stream nextPut: (ViennaEpiLogMatcher module: module identifier) ].
			 definitionList selectedItem ifNotNil: [ :definition |
				 definition isViennaTopLevelDefinitionNode ifTrue: [
					 definition identifiers do: [ :identifier |
						 stream nextPut: (ViennaEpiLogMatcher
								  identifier: identifier
								  module: definition module identifier) ] ] ] ]) sorted.
	(epiLogMatcherDropList items includes: selection) ifTrue: [
		epiLogMatcherDropList selectItem: selection ]
]

{ #category : #updating }
ViennaRefactoringBrowser >> updateModuleList [

	| newItems oldSelection |
	newItems := self specification
		            ifNotNil: [ :documentNode |
		            documentNode modules ifEmpty: [ Array with: nil ] ]
		            ifNil: [ Array with: nil ].
	oldSelection := moduleList selection selectedItem.
	moduleList items: newItems.
	(newItems includes: oldSelection) ifTrue: [
		moduleList selectItem: oldSelection ]
]

{ #category : #updating }
ViennaRefactoringBrowser >> updateSource [
	self definition
		ifNotNil: [ :node | sourceText text: (self getSource: node) ]
		ifNil: [ sourceText text: '' ]
]

{ #category : #updating }
ViennaRefactoringBrowser >> updateSourceSignalButton [

	pendingSyntaxError ifNotNil: [
		talkbackLabel label: pendingSyntaxError printString.
		^ sourceSignalButton icon: self class redSignalIcon ].
	pendingTypeError ifNotNil: [
		talkbackLabel label: pendingTypeError printString.
		^ sourceSignalButton icon: self class yellowSignalIcon ].
	talkbackLabel label: ''.
	^ sourceSignalButton icon: self class greenSignalIcon
]

{ #category : #updating }
ViennaRefactoringBrowser >> updateStateTable [

	stateTable refresh
]

{ #category : #updating }
ViennaRefactoringBrowser >> updateStateTableItems [

	stateTable items: animation state keys asSortedCollection
]

{ #category : #updating }
ViennaRefactoringBrowser >> windowIsClosing [

	testProcess ifNotNil: [
		testProcess terminate.
		testProcess := nil ].
	highlighterProcess ifNotNil: [
		highlighterProcess terminate.
		highlighterProcess := nil ]
]
