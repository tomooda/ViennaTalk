Class {
	#name : 'ViennaRefactoringBrowser',
	#superclass : 'SpPresenterWithModel',
	#traits : 'THiDeEditTags',
	#classTraits : 'THiDeEditTags classTrait',
	#instVars : [
		'fileReference',
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
		'epiLogMatcherDropList',
		'epiLogList',
		'epiLogDiffList',
		'epiLogDiffText',
		'epiLogCherrypickList',
		'epiLogCherrypickText',
		'epiLogSourceText',
		'epiLogNotebook',
		'sliceNodes',
		'sliceAttribute',
		'runsAllTests',
		'autoTestButton',
		'runTestButton',
		'revertEpiLogButton',
		'removeEpiLogButton',
		'editEpiLogCommentButton',
		'hideStorage',
		'editEpiLogTagButton',
		'addToNarrativeButton',
		'updateEpiLogButton',
		'showsArtifactTimelineButton',
		'showsUserTimelineButton',
		'narrativeDropList',
		'createNewNarrativeButton',
		'removeNarrativeButton',
		'epiLogListSizeDropList',
		'gitRemoteCommitList',
		'gitOutgoingCommitList',
		'gitCommitButton',
		'gitCommitMenuButton',
		'gitPullButton',
		'gitPushButton',
		'gitMergeButton',
		'gitFetchButton',
		'gitDiffList',
		'gitDiffText',
		'runMutationTestingButton',
		'removeAllEpiLogButton',
		'clearEpiLogCheckBox',
		'epiLogCherrypickButton'
	],
	#classVars : [
		'GreenSignalIcon',
		'RedSignalIcon',
		'TrafficSide',
		'YellowSignalIcon'
	],
	#category : 'ViennaTalk-Browser-Core-Browsers',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'Browsers'
}

{ #category : 'services' }
ViennaRefactoringBrowser class >> acceptExternalDrop: aString extension: anotherString [

	<fileService>
	anotherString = 'vdmsl' ifTrue: [ ^ self fileServices ].
	aString asFileReference ifNotNil: [ :ref |
		ref isDirectory ifTrue: [ ^ self directoryServices ] ].
	^ #(  )
]

{ #category : 'settings' }
ViennaRefactoringBrowser class >> beLeftSideTraffic [

	self trafficSide: #left
]

{ #category : 'settings' }
ViennaRefactoringBrowser class >> beRightSideTraffic [

	self trafficSide: #right
]

{ #category : 'icons' }
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

{ #category : 'settings' }
ViennaRefactoringBrowser class >> defaultTrafficSide [

	^ #left
]

{ #category : 'services' }
ViennaRefactoringBrowser class >> directoryServices [

	^ { ((SimpleServiceEntry
		    provider: self
		    label: 'VDM Refactoring Browser'
		    selector: #openFromDisk:
		    description:
		    'Open a VDM Refactoring Browser on this directory, allowing you to view and edit its source'
		    buttonLabel: 'VDM') argumentGetter: [ :file |
		   file asFileReference ]) }
]

{ #category : 'instance creation' }
ViennaRefactoringBrowser class >> empty [

	<script: 'ViennaRefactoringBrowser empty open'>
	^ self new
]

{ #category : 'examples' }
ViennaRefactoringBrowser class >> exampleATC [

	(ViennaRefactoringBrowser on: (ViennaVDMParser current parse:
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

{ #category : 'examples' }
ViennaRefactoringBrowser class >> exampleCounter [

	(ViennaRefactoringBrowser on:
		 (ViennaVDMParser current parse:
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

{ #category : 'services' }
ViennaRefactoringBrowser class >> fileServices [

	^ { ((SimpleServiceEntry
		    provider: self
		    label: 'VDM Refactoring Browser'
		    selector: #openFromDisk:
		    description:
		    'Open a VDM Refactoring Browser on this file, allowing you to view and edit its source'
		    buttonLabel: 'VDM') argumentGetter: [ :file |
		   file asFileReference ]) }
]

{ #category : 'icons' }
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

{ #category : 'settings' }
ViennaRefactoringBrowser class >> ifLeftSideTraffic: leftBlock ifRightSideTraffic: rightBlock [

	^ (TrafficSide ifNil: [ TrafficSide := self defaultTrafficSide ])
	  = #left
		  ifTrue: leftBlock
		  ifFalse: rightBlock
]

{ #category : 'class initialization' }
ViennaRefactoringBrowser class >> initialize [

	Smalltalk
		at: #ViennaLauncher
		ifPresent: [ :launcherClass | launcherClass reopen ]
]

{ #category : 'services' }
ViennaRefactoringBrowser class >> openFromDisk: aFileReference [

	^ self new
		  load: aFileReference;
		  open
]

{ #category : 'icons' }
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

{ #category : 'settings' }
ViennaRefactoringBrowser class >> trafficSide [

	^ TrafficSide ifNil: [ TrafficSide := self defaultTrafficSide ]
]

{ #category : 'settings' }
ViennaRefactoringBrowser class >> trafficSide: aSymbol [

	TrafficSide := aSymbol = #left
		               ifTrue: [ #left ]
		               ifFalse: [ #right ].
	GreenSignalIcon := nil.
	YellowSignalIcon := nil.
	RedSignalIcon := nil.
	self allInstancesDo: [ :browser | browser updateSourceSignalButton ]
]

{ #category : 'settings' }
ViennaRefactoringBrowser class >> trafficSides [

	^ #( left right )
]

{ #category : 'menus' }
ViennaRefactoringBrowser class >> viennaDevMenuOn: aBuilder [
	<ViennaDev>
	(aBuilder item: #'Refactoring example (ATC)')
		action: [ self exampleATC  ];
		order: 3;
		help: 'Example spec on refactoring borwser';
		icon: nil
]

{ #category : 'settings' }
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

{ #category : 'menus' }
ViennaRefactoringBrowser class >> viennaToolsMenuOn: aBuilder [

	<ViennaToolsMenu>
	(aBuilder item: #'VDM Refactoring Browser')
		action: [ self empty open ];
		order: 0.1;
		help: 'AST-based VDM-SL browser with refactoring support';
		icon: nil
]

{ #category : 'menus' }
ViennaRefactoringBrowser class >> worldMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #'VDM Refactoring Browser')
		action: [ self empty open ];
		order: 0.1;
		parent: #ViennaTalk;
		help: 'AST-based VDM-SL browser with refactoring support';
		icon: nil
]

{ #category : 'icons' }
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

{ #category : 'operations' }
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

{ #category : 'menus' }
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

{ #category : 'operations-slicing' }
ViennaRefactoringBrowser >> addSlice: aViennaNode [

	| slicer |
	slicer := ViennaSlicer on: aViennaNode.
	sliceNodes addAll: slicer sliceNodes , { aViennaNode }.
	self sliceNodesChanged
]

{ #category : 'menus' }
ViennaRefactoringBrowser >> addSliceMenuOnOperation: aViennaExplicitOperationDefinitionNode [

	| menu |
	menu := self newMenu.
	aViennaExplicitOperationDefinitionNode module stateDefinition
		ifNotNil: [ :stateDefinition |
			menu addGroup: [ :group |
				stateDefinition fieldList do: [ :field |
					group addItem: [ :item |
						item
							name: field identifier;
							action: [
								self
									addSliceOnOperation: aViennaExplicitOperationDefinitionNode
									criteria:
										{ ((ViennaLocalNameNode identifier: field identifier)
											 parent: aViennaExplicitOperationDefinitionNode;
											 resolve) } ] ] ].
				group addItem: [ :item |
					item
						name: 'all state variables';
						action: [
							self
								addSliceOnOperation: aViennaExplicitOperationDefinitionNode
								criteria: (stateDefinition fieldList collect: [ :field |
											 (ViennaLocalNameNode identifier: field identifier)
												 parent: aViennaExplicitOperationDefinitionNode;
												 resolve ]) ] ] ] ].
	^ menu
]

{ #category : 'menus' }
ViennaRefactoringBrowser >> addSliceMenuOnState: aViennaStateDefinitionNode [

	| menu |
	menu := self newMenu.
	menu addGroup: [ :group |
		aViennaStateDefinitionNode fieldList do: [ :field |
			group addItem: [ :item |
				item
					name: field identifier;
					action: [
						self
							addSliceOnOperation: aViennaStateDefinitionNode
							criteria:
								{ ((ViennaLocalNameNode identifier: field identifier)
									 parent: aViennaStateDefinitionNode;
									 resolve) } ] ] ].
		group addItem: [ :item |
			item
				name: 'all state variables';
				action: [
					self
						addSliceOnOperation: aViennaStateDefinitionNode
						criteria:
							(aViennaStateDefinitionNode fieldList collect: [ :field |
									 (ViennaLocalNameNode identifier: field identifier)
										 parent: aViennaStateDefinitionNode;
										 resolve ]) ] ] ].
	^ menu
]

{ #category : 'operations-slicing' }
ViennaRefactoringBrowser >> addSliceOnOperation: aViennaExplicitOperationDefinitionNode criteria: aCollectionOfViennaNode [

	| slicer |
	slicer := ViennaSlicer
		          toplevelDefinition: aViennaExplicitOperationDefinitionNode
		          criteria: aCollectionOfViennaNode.
	sliceNodes addAll: slicer sliceNodes , slicer criteria.
	self sliceNodesChanged
]

{ #category : 'operations-slicing' }
ViennaRefactoringBrowser >> addSliceOnState: aViennaStateDefinitionNode criteria: aCollectionOfViennaNode [

	| slicer |
	slicer := ViennaSlicer
		          toplevelDefinition: aViennaStateDefinitionNode
		          criteria: aCollectionOfViennaNode.
	sliceNodes addAll: slicer sliceNodes , slicer criteria.
	self sliceNodesChanged
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> addToNarrativeMenu [

	| currentNarrative storage |
	currentNarrative := narrativeDropList selectedItem ifNotNil:
		                    #narrative.
	storage := self epiLog hideStorage.
	epiLogList selectedItems ifNotEmpty: [ :epiLog |
		^ self newMenu
			  addGroup: [ :group |
				  storage narratives do: [ :narrative |
						  currentNarrative = narrative ifFalse: [
								  group addItem: [ :item |
										  item
											  icon: (self iconNamed: #forward);
											  name: narrative name;
											  action: [ narrative addAll: epiLog ] ] ] ] ];
			  addGroup: [ :group |
				  group addItem: [ :item |
					  item
						  name: 'New timeline...';
						  icon: (self iconNamed: #add);
						  action: [
							  self createNewNarrativeDo: [ :narrative |
									  narrative addAll: epiLog.
									  self updateEpiLogList ] ] ] ] ].
	^ nil
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> applyChange: change to: aViennaNode [

	| from |
	from := change from.
	from document == aViennaNode document
		ifTrue: [
			aViennaNode allDescendantsDo: [ :node |
				node == from ifTrue: [
					node parent replace: node with: change to copyFragment ] ] ]
		ifFalse: [
			| moduleName |
			moduleName := from module identifier.
			change to addToModule:
				(aViennaNode document moduleNamed: moduleName) ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> artifactTimelineSelected [

	showsUserTimelineButton state: false.
	narrativeDropList resetSelection.
	self selectedTimelineChanged
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> category [
	^ categoryList selection selectedItem
]

{ #category : 'menus' }
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

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> cherrypick [

	epiLogCherrypickList selectedItems ifNotEmpty: [ :diffs |
		| newDocument map |
		newDocument := self specification copyWhole:
			               (map := IdentityDictionary new).
		diffs do: [ :diff |
			(diff class
				 from: (map at: diff from ifAbsent: [ diff from ])
				 to: diff to) applyTo: newDocument ].
		self
			epiLogManualEdit: newDocument
			comment:
			'Cherrypick: ' , (', ' join: (diffs collect: #printString)).
		self updateModuleList ]
]

{ #category : 'private' }
ViennaRefactoringBrowser >> clearDirty [

	dirty := false
]

{ #category : 'operations-slicing' }
ViennaRefactoringBrowser >> clearSlice [

	sliceNodes removeAll.
	self sliceNodesChanged
]

{ #category : 'testing' }
ViennaRefactoringBrowser >> clearsEpiLogWhenGitCommit [

	^ clearEpiLogCheckBox state
]

{ #category : 'private' }
ViennaRefactoringBrowser >> confirm: queryString label: titleString [

	^ self application newConfirm
		  title: titleString;
		  label: queryString;
		  openModal
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> createNewNarrative [

	self createNewNarrativeDo: [  ]
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> createNewNarrativeDo: aBlock [

	self epiLog ifNotNil: [ :epiLog |
		| storage |
		storage := epiLog hideStorage.
		[
		(UIManager default
			 request: 'New timeline name'
			 initialAnswer: 'my timeline'
			 title: 'EpiLog') ifNil: [ ^ self ] ifNotNil: [ :name |
			(storage hasNarrativeNamed: name) ifFalse: [
				| id narrative result |
				id := (narrative := storage newNarrativeNamed: name) identity.
				narrativeDropList selectItem: (narrativeDropList items
						 detect: [ :assoc | assoc value = id ]
						 ifNone: [ nil ]).
				result := aBlock cull: narrative.
				self updateNarrativeDropList: narrative.
				^ result ].
			UIManager default alert: name , ' is already used.' title: 'EpiLog' ] ]
			repeat ]
]

{ #category : 'operations-tests' }
ViennaRefactoringBrowser >> debugTestResultItem: aViennaTestResultItem [

	^ (ViennaTranspiledAnimation new
		   specification: self specification ifError: [ :msg | ^ nil ];
		   yourself)
		  debug: aViennaTestResultItem operation , '()'
		  in: aViennaTestResultItem module
		  ifError: [ :msg | msg ]
]

{ #category : 'layouts' }
ViennaRefactoringBrowser >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: menuBar height: self class buttonHeight;
		  add: (SpPanedLayout newVertical
				   positionOfSlider: 0.3;
				   add: (SpPanedLayout newHorizontal
						    positionOfSlider: 0.4;
						    add: moduleList;
						    add: (SpPanedLayout newHorizontal
								     positionOfSlider: 0.3;
								     add: categoryList;
								     add: definitionList));
				   add: notebook);
		  yourself
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> definition [
	^ definitionList selection selectedItem
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> definitionBase [

	^ self definition
]

{ #category : 'menus' }
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
						action: [ self executeRefactoring: refactoring ] ] ] ].
		menu addGroup: [ :group |
			definition isViennaExplicitOperationDefinitionNode ifTrue: [
				group addItem: [ :item |
					item
						name: 'Add slice for ...';
						subMenu: (self addSliceMenuOnOperation: definition) ] ].
			definition isViennaStateDefinitionNode ifTrue: [
				group addItem: [ :item |
					item
						name: 'Add slice for ...';
						subMenu: (self addSliceMenuOnState: definition) ] ].
			sliceNodes ifNotEmpty: [
				group addItem: [ :item |
					item
						name: 'Clear slices';
						action: [ self clearSlice ] ] ] ] ].
	menu addGroup: [ :group |
		menu addItem: [ :item |
			item
				name: 'inspect';
				action: [ self definitionBase inspect ] ] ].
	^ menu
]

{ #category : 'private' }
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

{ #category : 'private' }
ViennaRefactoringBrowser >> displayCategory: aViennaNode [

	aViennaNode ifNil: [ ^ '-' ].
	aViennaNode isViennaImportSignatureNode ifTrue: [
		^ 'from ' , aViennaNode moduleIdentifier , ' '
		  , aViennaNode refactoringBrowserSectionName ].
	^ aViennaNode refactoringBrowserSectionName ifNil: [ '?' ]
]

{ #category : 'private' }
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
				  ifNil: [ node module identifier , '`' , node identifier ] ].
		node isViennaNamedTraceNode ifTrue: [ ^ node identifier ] ].
	^ '-'
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> editEpiLogComment [

	epiLogList selectedItem ifNotNil: [ :epiLog |
		(UIManager default request: 'Comment' initialAnswer: epiLog comment)
			ifNotNil: [ :comment | epiLog comment: comment ].
		epiLogList refresh ]
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> editEpiLogTag [

	epiLogList selectedItem ifNotNil: [ :epiLog |
		| tags |
		tags := epiLog hideStorage chronicleTags asSortedCollection.
		self
			editTags: tags
			on: epiLog
			okAction: [ self updateEpiLogMatcherDropList ] ]
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> editTags: aCollectionOfAvailableTagString on: aViennaEpiLog okAction: aBlock [

	self
		editTags: aCollectionOfAvailableTagString
		on: aViennaEpiLog
		title: 'Edit tags'
		createNewTagTitle: 'Create new...'
		okAction: aBlock
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> epiLog [

	^ self model
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> epiLog: aViennaEpiLog [

	self model: aViennaEpiLog
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> epiLogArtifactTimelineEnumerator [

	^ ViennaEpiLogArtifactTimelineEnumerator current
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> epiLogChanges [

	^ (ViennaNodeDiffSet fromNodeChanges:
		   (Array streamContents: [ :stream |
			    (epiLogList selectedItems asSortedCollection: [ :older :newer |
				     older timestamp <= newer timestamp ]) do: [ :epilog |
				    (self epiLogEnumerator diffSet: epilog) changesDo: [ :change |
					    stream nextPut: change ] ] ])) condenseChanges
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> epiLogCherrypickChanges [

	^ epiLogList selectedItem
		  ifNotNil: [ :epiLog |
			  (ViennaNodeDiffSet
				   from: self specification
				   to: epiLog specification) condenseChanges ]
		  ifNil: [ Array new ]
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> epiLogEnumerator [

	showsUserTimelineButton state = true ifTrue: [
		^ self epiLogUserTimelineEnumerator ].
	showsArtifactTimelineButton state = true ifTrue: [
		^ self epiLogArtifactTimelineEnumerator ].
	^ narrativeDropList selectedItem
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogEvaluation: aString [

	self epiLog: (self epiLog newEvaluation: aString)
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogExecution: aString state: aDictionary [

	self epiLog: (self epiLog newExecution: aString state: aDictionary)
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogInitialization: aDictionary [

	self epiLog: (self epiLog newInitialization: aDictionary)
]

{ #category : 'menus' }
ViennaRefactoringBrowser >> epiLogListContextMenu [

	| menu |
	menu := self newMenu.
	epiLogList selectedItem ifNotNil: [ :epilog |
		menu addGroup: [ :group |
			group
				addItem: [ :item |
					item
						name: 'Revert to';
						action: [ self revertTo: epilog ] ];
				addItem: [ :item |
					item
						name: 'Comment';
						action: [ self editEpiLogComment ] ];
				addItem: [ :item |
					item
						name: 'Remove';
						action: [ self removeEpiLog ] ];
				addItem: [ :item |
					item
						name: 'Tag';
						action: [ self editEpiLogTag ] ] ].
		menu addGroup: [ :group |
			group addItem: [ :item |
				item
					name: 'Unselect';
					action: [ epiLogList unselectAll ] ] ] ].
	^ menu
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> epiLogListSelectionChanged [

	self
		updateEpiLogSourceText;
		updateEpiLogDiffList;
		updateEpiLogCherrypickList;
		updateEpiLogMatcherDropList;
		updateEpiLogButtons
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogLoading: aViennaModularDocumentNode [

	| storage |
	storage := ViennaHiDeStorage for: fileReference.
	self epiLog: (self epiLog
			 newLoading: aViennaModularDocumentNode
			 after: (storage chronicleTail ifNil: [
					  ViennaEpiLog vanilla
						  specification: aViennaModularDocumentNode;
						  state: Dictionary new;
						  hideStorage: storage;
						  hideSave;
						  yourself ]))
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogManualEdit: aViennaModularDocumentNode [

	self
		epiLogManualEdit: aViennaModularDocumentNode
		comment: 'manual edit'
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogManualEdit: aViennaModularDocumentNode comment: aString [

	self epiLog:
		((self epiLog newModification: aViennaModularDocumentNode)
			 comment: aString;
			 yourself)
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogMergeFRAM: aViennaModularDocumentNode [

	self epiLog:
		((self epiLog newModification: aViennaModularDocumentNode)
			 comment: 'merge from FRAM';
			 yourself)
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogRefactoring: aViennaModularDocumentNode with: aViennaRefactoring [

	self epiLog:
		((self epiLog newModification: aViennaModularDocumentNode)
			 comment: aViennaRefactoring name;
			 yourself)
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogRevertion: aViennaEpiLog [

	self epiLog: (self epiLog newRevertion: aViennaEpiLog)
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> epiLogUserTimelineEnumerator [

	^ ViennaEpiLogUserTimelineEnumerator current
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogVanilla [

	self epiLog: ViennaEpiLog vanilla
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> epiLogVanilla: aViennaModularDocumentNode state: aDictionary [

	self epiLog:
		(self epiLog
			 newVanilla: aViennaModularDocumentNode
			 state: aDictionary)
]

{ #category : 'layouts' }
ViennaRefactoringBrowser >> epilogPageLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.6;
		  add: (SpBoxLayout newVertical
				   add: (SpBoxLayout newHorizontal
						    add: showsUserTimelineButton width: 150;
						    add: showsArtifactTimelineButton width: 150;
						    add: narrativeDropList;
						    add: createNewNarrativeButton
						    width: self class buttonHeight;
						    add: removeNarrativeButton width: self class buttonHeight;
						    yourself)
				   expand: false;
				   add: (SpBoxLayout newHorizontal
						    vAlignEnd;
						    add: self filterIcon expand: false;
						    add: '  ' asPresenter expand: false;
						    add: epiLogMatcherDropList;
						    add: ' show ' asPresenter expand: false;
						    add: epiLogListSizeDropList expand: false;
						    add: ' items' asPresenter expand: false;
						    yourself)
				   expand: false;
				   add: epiLogList;
				   add: (SpBoxLayout newHorizontal
						    add: updateEpiLogButton;
						    add: revertEpiLogButton;
						    add: editEpiLogTagButton;
						    add: editEpiLogCommentButton;
						    add: addToNarrativeButton;
						    add: removeEpiLogButton;
						    add: removeAllEpiLogButton;
						    yourself)
				   expand: false;
				   yourself);
		  add: epiLogNotebook;
		  yourself
]

{ #category : 'operations' }
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

{ #category : 'accessing' }
ViennaRefactoringBrowser >> fileReference: aFileReference [

	fileReference := aFileReference
]

{ #category : 'icons' }
ViennaRefactoringBrowser >> filterIcon [

	| form fillColor a b c |
	fillColor := Color white.
	form := Form extent: 32 @ 32 depth: 32.
	a := 3.
	b := 2.
	c := 32.
	form getCanvas
		drawPolygon: {
				( a @ (1+a)).
				( a @ 1).
				(c - a @ 1).
				(c - a @ (1+a)).
				(c // 2 + b @ (c // 2)).
				(c // 2 + b @ (c - a - b)).
				(c // 2 - b @ (c - a)).
				(c // 2 - b @ (c // 2)) }
		color: (Color gray: 0.7)
		borderWidth: 3
		borderColor: Color gray;
		flush.
	^ form scaledToExactSize: 16 @ 16
]

{ #category : 'private' }
ViennaRefactoringBrowser >> findIntervalFromContext: aContext source: aViennaTracingSource [

	| context smalltalkNode specificationContext vdmNode map currentNode |
	context := aContext.
	[
	[
	(context receiver isKindOf: ViennaTranspiledObject) and: [
		context selector ~= #inv ] ] whileFalse: [
		context := context sender.
		context ifNil: [ ^ 0 to: -1 ] ].
	specificationContext := context specificationContext.
	specificationContext ifNil: [ ^ 0 to: -1 ].
	smalltalkNode := specificationContext method sourceNodeForPC:
		                 specificationContext pc - 1.
	vdmNode := specificationContext specification.
	map := specificationContext methodClass debuggerNodeMapAt:
		       specificationContext selector.
	currentNode := nil.
	map keysAndValuesDo: [ :sNode :vNode |
		(sNode = smalltalkNode and: [ sNode start = smalltalkNode start ])
			ifTrue: [ currentNode := vNode ] ].
	(aViennaTracingSource intervalForSource: currentNode) key
		ifNotEmpty: [ :interval | ^ interval ].
	context := context sender.
	context notNil ] whileTrue.
	^ 0 to: -1
]

{ #category : 'private' }
ViennaRefactoringBrowser >> findIntervalsFromContext: aContext source: aViennaTracingSource [

	| intervals context smalltalkNode specificationContext vdmNode map currentNode |
	intervals := OrderedCollection new.
	context := aContext.
	[
	[ context receiver isKindOf: ViennaTranspiledObject ] whileFalse: [
		context := context sender.
		context ifNil: [ ^ intervals ] ].
	specificationContext := context specificationContext.
	specificationContext ifNil: [ ^ intervals ].
	smalltalkNode := specificationContext method sourceNodeForPC:
		                 specificationContext pc - 1.
	vdmNode := specificationContext specification.
	map := specificationContext methodClass debuggerNodeMapAt:
		       specificationContext selector.
	currentNode := nil.
	map keysAndValuesDo: [ :sNode :vNode |
		(sNode = smalltalkNode and: [ sNode start = smalltalkNode start ])
			ifTrue: [ currentNode := vNode ] ].
	(aViennaTracingSource intervalForSource: currentNode) key
		ifNotEmpty: [ :interval |
			(intervals anySatisfy: [ :i |
				 (interval rangeIncludes: i first) or: [
					 interval rangeIncludes: i last ] ]) ifFalse: [
				intervals add: interval ] ].
	context := context sender.
	context notNil ] whileTrue.
	^ intervals
]

{ #category : 'operations' }
ViennaRefactoringBrowser >> generateSmalltalkClasses [

	self specification ifNotNil: [ :ast |
		(ViennaVDM2SmalltalkClass new
			 source: animation specification;
			 generate: ast) ifNotNil: [ :class | class browse ] ]
]

{ #category : 'private' }
ViennaRefactoringBrowser >> getSource: aViennaNode [

	aViennaNode ifNil: [ ^ String new ].
	^ aViennaNode tracingHighlightedSource
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitCanCommit [

	^ self gitHasDirtyWorkingCopy
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitCanCommitAndPush [

	^ self gitHasDirtyWorkingCopy and: [
		  (self icebergRepositoryDo: [ :repository |
			   repository branch includesCommit:
				   repository branch upstream commit ]) = true ]
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitCanMerge [

	self icebergRepositoryDo: [ :repository |
		^ self gitHasDirtyWorkingCopy not and: [
			  (repository branch upstream includesCommit:
				   repository branch commit) not and: [
				  (repository branch includesCommit:
					   repository branch upstream commit) not ] ] ].
	^ false
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitCanPull [

	self icebergRepositoryDo: [ :repository |
		^ self gitHasDirtyWorkingCopy not and: [
			  (repository branch upstream includesCommit:
				   repository branch commit) and: [
				  (repository branch includesCommit:
					   repository branch upstream commit) not ] ] ].
	^ false
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitCanPush [

	self icebergRepositoryDo: [ :repository |
		^ (repository branch includesCommit:
			   repository branch upstream commit) and: [
			  (repository branch upstream includesCommit:
				   repository branch commit) not ] ].
	^ false
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitChanges [

	self specification ifNotNil: [ :ast |
		self icebergRepositoryDo: [ :repository |
			^ (ViennaNodeDiffSet
				   from: (self sourceFrom: repository branch commit fileSystem)
						   asViennaDocumentAst
				   to: ast) condenseChanges ] ].
	^ {  }
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitCommit [

	self gitCanCommit ifTrue: [
		| text |
		(text := self newText) openDialog
			title: 'Commit Message';
			okAction: [
				self gitCommitWithMessage: text text.
				self
					updateGitOutgoingCommitList;
					updateGitDiffList;
					updateGitButtons ] ]
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitCommitAndPush [

	self gitCanCommitAndPush ifTrue: [
		| text |
		(text := self newText) openDialog
			title: 'Commit Message';
			okAction: [
				self gitCommitWithMessage: text text.
				self icebergRepositoryDo: #push.
				self
					updateGitOutgoingCommitList;
					updateGitRemoteCommitList;
					updateGitDiffList;
					updateGitButtons ] ]
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitCommitWithMessage: aString [

	self icebergRepositoryDo: [ :repository |
		| newCommit |
		repository addFilesToIndex:
			((repository location filesMatching: '*.vdmsl') collect: #basename).
		newCommit := repository
			             commitIndexWithMessage: aString
			             andParents: { repository branch commit }.
		self updateGitOutgoingCommitList.
		self clearsEpiLogWhenGitCommit
			ifTrue: [
				self epiLogVanilla: self specification state: animation state.
				self epiLog hideStorage garbageCollect ]
			ifFalse: [
				self
					epiLogManualEdit: self specification
					comment: 'commit ' , newCommit id asString , String cr , aString ].
		self updateEpiLogList ]
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitFetch [

	self icebergRepositoryDo: #fetch.
	self updateGitRemoteCommitList.
	self updateGitButtons
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitHasDirtyWorkingCopy [

	self icebergRepositoryDo: [ :repository |
		| headFileSystem |
		headFileSystem := repository branch commit fileSystem.
		(fileReference filesMatching: '*.vdmsl') do: [ :fileRef |
			| wcRef |
			wcRef := headFileSystem / fileRef basename.
			(wcRef exists and: [ fileRef contents = wcRef contents ]) ifFalse: [
				^ true ] ] ].
	^ false
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitLocalBranchIncludes: anIceCommit [

	self icebergRepositoryDo: [ :repository |
		^ repository branch includesCommit: anIceCommit ].
	^ false
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitMerge [

	self gitCanMerge ifTrue: [
		self icebergRepositoryDo: [ :repository |
			| localCommit remoteCommit baseCommit baseAst localChanges remoteChanges merger |
			localCommit := repository branch commit.
			remoteCommit := repository branch upstream commit.
			baseCommit := localCommit commonAncestorWithCommit: remoteCommit.
			baseCommit ifNil: [ ^nil ].
			baseAst := (self sourceFrom: baseCommit fileSystem)
				           asViennaDocumentAst.
			localChanges := (ViennaNodeDiffSet
				                 from: baseAst
				                 to:
				                 (self sourceFrom: localCommit fileSystem)
					                 asViennaDocumentAst) condenseChanges select:
				                #isViennaTopLevelDefinitionNodeChange.
			remoteChanges := (ViennaNodeDiffSet
				                  from: baseAst
				                  to:
				                  (self sourceFrom: remoteCommit fileSystem)
					                  asViennaDocumentAst) condenseChanges select:
				                 #isViennaTopLevelDefinitionNodeChange.
			merger := ViennaChangesMerger
				          remoteChanges: remoteChanges
				          localChanges: localChanges.
			merger asModalWindow
				okAction: [
					| mergedChanges mergedCommit |
					mergedChanges := merger mergedChanges.
					mergedChanges do: [ :change |
							self applyChange: change to: baseAst ].
					self
						epiLogManualEdit: baseAst
						comment: 'merge ' , localCommit id asString.
					self updateModuleList.
					mergedCommit := repository
						                commitIndexWithMessage:
							                'Merge ' , localCommit id asString
						                andParents: {
								                localCommit.
								                remoteCommit }.
					self
						updateGitOutgoingCommitList;
						updateGitRemoteCommitList;
						updateGitDiffList;
						updateGitButtons ];
				open ] ]
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitOutgoingCommitsDo: aBlock [

	self icebergRepositoryDo: [ :repository |
		| upstreamBranch |
		upstreamBranch := repository branch upstream.
		repository branch commits do: [ :commit |
			(upstreamBranch includesCommit: commit) ifTrue: [ ^ self ].
			aBlock cull: commit ] ]
]

{ #category : 'layouts' }
ViennaRefactoringBrowser >> gitPageLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.65;
		  add: (SpBoxLayout newHorizontal
				   add: (SpPanedLayout newVertical
						    positionOfSlider: 0.4;
						    add: (SpBoxLayout newVertical
								     add: 'Local' asPresenter expand: false;
								     add: gitOutgoingCommitList;
								     add: (SpBoxLayout newHorizontal
										      add: gitPullButton expand: false;
										      add: gitPushButton expand: false;
										      yourself)
								     expand: false;
								     yourself);
						    add: (SpBoxLayout newVertical
								     add: 'Remote' asPresenter expand: false;
								     add: gitRemoteCommitList;
								     add: (SpBoxLayout newHorizontal
										      add: gitFetchButton expand: false;
										      add: gitMergeButton expand: false;
										      yourself)
								     expand: false;
								     yourself);
						    yourself);
				   add: ' ' asPresenter width: 7;
				   yourself);
		  add: (SpBoxLayout newVertical
				   add: 'Working copy' asPresenter expand: false;
				   add: (SpPanedLayout newVertical
						    positionOfSlider: 0.35;
						    add: gitDiffList;
						    add: gitDiffText);
				   add: (SpBoxLayout newHorizontal
						    add: gitCommitButton expand: false;
						    add: gitCommitMenuButton width: 20;
						    add: clearEpiLogCheckBox expand: false;
						    yourself)
				   expand: false;
				   yourself);
		  yourself
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitPull [

	self icebergRepositoryDo: [ :repository |
		self gitCanPull
			ifTrue: [
				repository branch commit: repository branch upstream commit.
				self reload.
				self updateGitPage ]
			ifFalse: [
			self alert: 'Can not pull into dirty working copy or local commits' ] ]
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitPush [

	self gitCanPush ifTrue: [
		self icebergRepositoryDo: #push.
		self
			updateGitOutgoingCommitList;
			updateGitRemoteCommitList;
			updateGitDiffList;
			updateGitButtons ]
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> gitRemoteCommitsDo: aBlock [

	self icebergRepositoryDo: [ :repository |
		| headId |
		headId := repository branch commit id.
		repository branch upstream commits do: aBlock ]
]

{ #category : 'testing' }
ViennaRefactoringBrowser >> hasFileReference [

	^ fileReference notNil and: [ fileReference exists ]
]

{ #category : 'testing' }
ViennaRefactoringBrowser >> hasGit [

	^ fileReference notNil and: [ (fileReference / '.git') isDirectory ]
]

{ #category : 'testing' }
ViennaRefactoringBrowser >> hasTypeError: aViennaNode [

	^ pendingTypeError notNil and: [
		  | errorNode |
		  errorNode := pendingTypeError node.
		  aViennaNode hasDescendantSuchThat: [ :node | errorNode == node ] ]
]

{ #category : 'operations' }
ViennaRefactoringBrowser >> highlightSourceText [

	highlighterProcess ifNotNil: [
		highlighterProcess terminate.
		highlighterProcess := nil ].
	highlighterProcess := [
	                      | source highlighter context result newNode newAst copyMap parent oldNode |
	                      source := sourceText text asString asString copy.
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

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> icebergRepositoryDo: aBlock [

	^ (fileReference notNil and: [ fileReference isDirectory ]) ifTrue: [
		  (IceRepository repositoryNamed: fileReference basename)
			  ifNotNil: aBlock
			  ifNil: [
				  self hasGit ifTrue: [
					  aBlock cull: ((IceRepositoryCreator new
							    repository: nil;
							    location: fileReference;
							    createRepository)
							   register;
							   yourself) ] ] ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> ifHiDeHoVisible: aBlock [

	notebook ifNotNil: [
		(notebook selectedPage ifNotNil: #title) = 'HiDeHo' ifTrue: aBlock ]
]

{ #category : 'operations' }
ViennaRefactoringBrowser >> initState [

	animation init.
	self updateStateTable.
	self epiLogInitialization: animation state
]

{ #category : 'initialization' }
ViennaRefactoringBrowser >> initialize [

	animation := ViennaAnimation default.
	animation announcer
		when: ViennaStateChanged do: [ self updateStateTable ] for: self;
		when: ViennaSpecificationChanged
		do: [ self updateStateTableItems ]
		for: self.
	runsAllTests := false.
	self epiLogVanilla.
	dirty := false.
	sliceNodes := IdentitySet new.
	super initialize
]

{ #category : 'initialization' }
ViennaRefactoringBrowser >> initializeEpiLogPagePresenters [

	showsUserTimelineButton := self newCheckBox
		                           label: 'user timeline';
		                           state: true;
		                           whenActivatedDo: [
			                           self userTimelineSelected ];
		                           yourself.
	showsArtifactTimelineButton := self newCheckBox
		                               label: 'artifact timeline';
		                               state: false;
		                               whenActivatedDo: [
			                               self artifactTimelineSelected ];
		                               yourself.
	narrativeDropList := self newDropList
		                     display: [ :narrativeEnumerator |
			                     narrativeEnumerator name ];
		                     displayIcon: [ :narrativeEnumerator |
			                     narrativeEnumerator icon ];
		                     startWithoutSelection;
		                     whenSelectedItemChangedDo: [ :item |
			                     item ifNotNil: [
					                     self narrativeTimelineSelected ] ];
		                     yourself.
	createNewNarrativeButton := self newButton
		                            icon: (self iconNamed: #add);
		                            action: [ self createNewNarrative ];
		                            yourself.
	removeNarrativeButton := self newButton
		                         icon: (self iconNamed: #remove);
		                         action: [ self removeNarrative ];
		                         yourself.
	epiLogMatcherDropList := self newDropList
		                         displayIcon: [ :matcher | matcher icon ];
		                         items: { ViennaEpiLogMatcher all };
		                         startWithSelection;
		                         whenSelectionChangedDo: [
			                         self updateEpiLogList ];
		                         yourself.
	epiLogListSizeDropList := self newDropList
		                          display: [ :assoc | assoc key ];
		                          items: {
				                          ('~50' -> 50).
				                          ('~100' -> 100).
				                          ('~1,000' -> 1000).
				                          ('all' -> nil) };
		                          startWithSelection;
		                          whenSelectionChangedDo: [
			                          self updateEpiLogList ];
		                          yourself.
	epiLogList := self newTable
		              beMultipleSelection;
		              showColumnHeaders;
		              beResizable;
		              addColumn: ((SpStringTableColumn
				                title: 'timestamp'
				                evaluated: [ :epilog |
					                ViennaLauncher formatDateAndTime:
							                epilog timestamp ])
				               beExpandable;
				               yourself);
		              addColumn:
			              ((SpStringTableColumn
				                title: 'operation'
				                evaluated: #printString)
				               beExpandable;
				               yourself);
		              addColumn:
			              ((SpStringTableColumn
				                title: 'comment'
				                evaluated: #comment)
				               beExpandable;
				               yourself);
		              contextMenu: [ self epiLogListContextMenu ];
		              bindKeyCombination: Character escape
		              toAction: [ epiLogList unselectAll ];
		              whenSelectionChangedDo: [
		              self epiLogListSelectionChanged ];
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
	epiLogSourceText := self newVDMSource.
	epiLogCherrypickList := self newTable
		                        hideColumnHeaders;
		                        beMultipleSelection;
		                        beResizable;
		                        addColumn:
			                        (SpStringTableColumn evaluated:
					                         #printSummary);
		                        addColumn:
			                        (SpStringTableColumn evaluated: #printNames);
		                        whenSelectionChangedDo: [
			                        self updateEpiLogCherrypickText ];
		                        yourself.
	epiLogCherrypickText := self newText.
	epiLogCherrypickButton := self newButton
		                          label: 'Cherrypick';
		                          action: [ self cherrypick ];
		                          yourself.
	epiLogNotebook := self newNotebook
		                  addPageTitle: 'Diff' provider: [
			                  SpPresenter new
				                  layout: (SpPanedLayout newVertical
						                   positionOfSlider: 0.3;
						                   add: epiLogDiffList;
						                   add: epiLogDiffText);
				                  yourself ];
		                  addPageTitle: 'Version Source'
		                  provider: [ epiLogSourceText ];
		                  addPageTitle: 'Cherrypick' provider: [
		                  SpPresenter new
			                  layout: (SpBoxLayout newVertical
					                   add: (SpPanedLayout newVertical
							                    positionOfSlider: 0.3;
							                    add: epiLogCherrypickList;
							                    add: epiLogCherrypickText);
					                   add: epiLogCherrypickButton expand: false;
					                   yourself);
			                  yourself ];
		                  yourself.
	updateEpiLogButton := self newButton
		                      icon: (self iconNamed: #refreshCircling);
		                      label: 'Update';
		                      action: [ self updateEpiLogList ];
		                      yourself.
	revertEpiLogButton := self newButton
		                      icon: (self iconNamed: #smallRedo);
		                      label: 'Revert';
		                      action: [ self revertToEpiLog ];
		                      yourself.
	editEpiLogTagButton := self newButton
		                       icon: self tagIcon;
		                       label: 'Tags';
		                       action: [ self editEpiLogTag ];
		                       yourself.
	editEpiLogCommentButton := self newButton
		                           icon: (self iconNamed: #edit);
		                           label: 'Comment';
		                           action: [ self editEpiLogComment ];
		                           yourself.
	addToNarrativeButton := self newButton
		                        icon: (self iconNamed: #folder);
		                        label: 'Add to..';
		                        action: [
			                        self addToNarrativeMenu
				                        openWithSpecAtPointer ];
		                        yourself.
	removeEpiLogButton := self newButton
		                      icon: (self iconNamed: #smallDelete);
		                      label: 'Delete';
		                      action: [ self removeEpiLog ];
		                      yourself.
	removeAllEpiLogButton := self newButton
		                         icon: (self iconNamed: #delete);
		                         label: 'Forget all';
		                         action: [ self removeAllEpiLog ];
		                         yourself.
	epiLogList whenBuiltDo: [ self userTimelineSelected ]
]

{ #category : 'initialization' }
ViennaRefactoringBrowser >> initializeGitPagePresenters [

	gitRemoteCommitList := self newTable
		                       beResizable;
		                       addColumn: ((SpStringTableColumn
				                         title: 'date'
				                         evaluated: [ :commit |
					                         ViennaLauncher formatDateAndTime:
							                         commit datetime ])
				                        displayBackgroundColor: [ :commit |
					                        (self gitLocalBranchIncludes: commit)
						                        ifTrue: [ Color transparent ]
						                        ifFalse: [ Color yellow alpha: 0.3 ] ];
				                        width: 100);
		                       addColumn:
			                       ((SpStringTableColumn
				                         title: 'author'
				                         evaluated: #author)
				                        displayBackgroundColor: [ :commit |
					                        (self gitLocalBranchIncludes: commit)
						                        ifTrue: [ Color transparent ]
						                        ifFalse: [ Color yellow alpha: 0.3 ] ];
				                        width: 100);
		                       addColumn:
			                       ((SpStringTableColumn
				                         title: 'comment'
				                         evaluated: [ :commit |
					                         commit comment lines first
					                         , (commit comment lines size > 2
							                          ifTrue: [ '...' ]
							                          ifFalse: [ '' ]) ])
				                        displayBackgroundColor: [ :commit |
					                        (self gitLocalBranchIncludes: commit)
						                        ifTrue: [ Color transparent ]
						                        ifFalse: [ Color yellow alpha: 0.3 ] ];
				                        yourself);
		                       whenSelectionChangedDo: [
		                       self selectedGitRemoteCommitChanged ];
		                       whenActivatedDo: [ :selection |
		                       gitRemoteCommitList unselectAll ];
		                       yourself.
	gitOutgoingCommitList := self newTable
		                         beResizable;
		                         addColumn: ((SpStringTableColumn
				                           title: 'date'
				                           evaluated: [ :commit |
					                           ViennaLauncher formatDateAndTime:
							                           commit datetime ]) width: 100);
		                         addColumn:
			                         ((SpStringTableColumn
				                           title: 'author'
				                           evaluated: #author) width: 100);
		                         addColumn:
			                         (SpStringTableColumn
				                          title: 'comment'
				                          evaluated: [ :commit |
					                          commit comment lines first
					                          , (commit comment lines size > 2
							                           ifTrue: [ '...' ]
							                           ifFalse: [ '' ]) ]);
		                         whenSelectionChangedDo: [
			                         self selectedGitOutgoingCommitChanged ];
		                         activateOnSingleClick;
		                         whenActivatedDo: [ :selection |
			                         gitOutgoingCommitList unselectAll ];
		                         yourself.
	gitDiffList := self newTable
		               hideColumnHeaders;
		               beResizable;
		               addColumn:
			               (SpStringTableColumn evaluated: #printSummary);
		               addColumn:
			               (SpStringTableColumn evaluated: #printNames);
		               whenSelectionChangedDo: [ self updateGitDiffText ];
		               yourself.
	gitDiffText := self newText.

	gitCommitButton := self newButton
		                   icon: (self iconNamed: #accept);
		                   label: 'Commit';
		                   action: [ self gitCommit ];
		                   yourself.
	gitCommitMenuButton := self newButton
		                       icon: (self iconNamed: #arrowDown);
		                       action: [ self openGitCommitMenu ];
		                       yourself.
	gitPushButton := self newButton
		                 icon: (self iconNamed: #down);
		                 label: 'Push';
		                 action: [ self gitPush ];
		                 yourself.
	gitPullButton := self newButton
		                 icon: (self iconNamed: #up);
		                 label: 'Pull';
		                 action: [ self gitPull ];
		                 yourself.
	gitFetchButton := self newButton
		                  icon: (self iconNamed: #refreshCircling);
		                  label: 'Fetch';
		                  action: [ self gitFetch ];
		                  yourself.
	gitMergeButton := self newButton
		                  icon: (self iconNamed: #merge);
		                  label: 'Merge';
		                  action: [ self gitMerge ];
		                  yourself.
	clearEpiLogCheckBox := self newCheckBox
		                       label: 'Clear EpiLog when commit';
		                       state: false;
		                       yourself
]

{ #category : 'initialization' }
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
		              beResizable;
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
				               evaluated: [ :string |
					               animation plainAt: string ifAbsent: [ '-' ] ]);
		              yourself.
	initStateButton := self newButton
		                   icon: (self iconNamed: #refresh);
		                   label: 'initialize';
		                   action: [ self initState ];
		                   yourself.
	refreshStateButton := self newButton
		                      icon: (self iconNamed: #smallUpdate);
		                      label: 'refresh';
		                      action: [ self updateStateTableItems ];
		                      yourself
]

{ #category : 'initialization' }
ViennaRefactoringBrowser >> initializePresenters [

	super initializePresenters.
	menuBar := self menuBar.
	moduleList := self newList
		              borderWidth: 1;
		              borderColor: Color darkGray;
		              beSingleSelection;
		              contextMenu: [ self moduleListContextMenu ];
		              displayBackgroundColor: [ :ast |
			              self listBackgroundColorFor: ast ];
		              display: [ :ast | ast ifNil: [ '-' ] ifNotNil: #first ];
		              sortingBlock: #identifier ascending;
		              whenSelectionChangedDo: [
			              self
				              updateTestButtons;
				              updateCategoryList;
				              updateEpiLogMatcherDropList;
				              updateEpiLogSourceText ];
		              yourself.
	categoryList := self newList
		                borderWidth: 1;
		                borderColor: Color darkGray;
		                beSingleSelection;
		                contextMenu: [ self categoryListContextMenu ];
		                displayBackgroundColor: [ :ast |
			                self listBackgroundColorFor: ast ];
		                display: [ :ast | self displayCategory: ast ];
		                whenSelectionChangedDo: [ self updateDefinitionList ];
		                yourself.
	definitionList := self newList
		                  borderWidth: 1;
		                  borderColor: Color darkGray;
		                  beSingleSelection;
		                  displayBackgroundColor: [ :ast |
			                  self listBackgroundColorFor: ast ];
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
	self initializeGitPagePresenters.
	notebook := self newNotebook
		            addPageTitle: 'Source' provider: [
			            SpPresenter new
				            layout: self sourcePageLayout;
				            yourself ];
		            addPageTitle: 'Playground' provider: [
		            SpPresenter new
			            layout: self playgroundPageLayout;
			            yourself ];
		            addPageTitle: 'HiDeHo' provider: [
		            SpPresenter new
			            layout: self epilogPageLayout;
			            yourself ];
		            addPageTitle: 'Git' provider: [
		            SpPresenter new
			            layout: self gitPageLayout;
			            yourself ];
		            whenSelectedPageChangedDo: [
			            notebook selectedPage ifNotNil: [ :page |
				            page title = 'HiDeHo' ifTrue: [ self updateEpiLogPage ].
				            page title = 'Git' ifTrue: [
					            [ self updateGitPage ] forkAt:
						            Processor userBackgroundPriority ] ] ];
		            yourself.
	self whenBuiltDo: [ :w |
		| f |
		f := ViennaLauncher font.
		w widget allMorphsDo: [ :m |
			(m respondsTo: #font:) ifTrue: [ m font: f ] ] ]
]

{ #category : 'initialization' }
ViennaRefactoringBrowser >> initializeSourcePagePresenters [

	sourceSignalButton := self newButton
		                      color: Color transparent;
		                      icon: self class greenSignalIcon;
		                      action: [ self sourceSignalButtonPressed ];
		                      yourself.
	talkbackLabel := self newLabel
		                 label: '';
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
	autoTestButton := self newButton
		                  label: 'auto run';
		                  icon: (self iconNamed: #smallUpdate);
		                  action: [ self toggleRunsAllTests ];
		                  yourself.
	runTestButton := self newButton
		                 label: 'run';
		                 icon: (self iconNamed: #smallDoIt);
		                 action: [ self runAllTests ];
		                 yourself.
	testResultTable := self newTable
		                   beResizable;
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
			                   ((SpStringTableColumn evaluated: #testName)
				                    title: 'test';
				                    sortFunction: #testName ascending);
		                   addColumn:
			                   ((SpStringTableColumn evaluated: #message)
				                    title: 'message';
				                    sortFunction: #message ascending);
		                   showColumnHeaders;
		                   beResizable;
		                   sortingBlock: [ :upper :lower |
		                   upper sortingOrder <= lower sortingOrder ];
		                   contextMenu: [ self testResultTableContextMenu ];
		                   whenSelectionChangedDo: [ self testResultChanged ];
		                   yourself.
	runMutationTestingButton := self newButton
		                            label: 'Mutation testing';
		                            icon: (self iconNamed: #exception);
		                            action: [ self runMutationTesting ];
		                            yourself
]

{ #category : 'initialization' }
ViennaRefactoringBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 1000 @ 800
]

{ #category : 'instance creation' }
ViennaRefactoringBrowser >> instantiate: aPresenterClass [

	^ (super instantiate: aPresenterClass)
		  font: ViennaLauncher font;
		  yourself
]

{ #category : 'private' }
ViennaRefactoringBrowser >> isDirty [

	^ dirty = true
]

{ #category : 'operations' }
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

{ #category : 'accessing' }
ViennaRefactoringBrowser >> listBackgroundColorFor: aViennaNode [

	aViennaNode ifNil: [ ^ Color transparent ].
	(aViennaNode hasDescendantSuchThat: [ :node |
		 sliceNodes includes: node ]) ifTrue: [ ^ self sliceColor ].
	pendingTypeError ifNotNil: [
		(pendingTypeError node includesParent: aViennaNode) ifTrue: [
			^ Color yellow ] ].
	^ Color transparent
]

{ #category : 'operations' }
ViennaRefactoringBrowser >> load: aFileReference [

	self fileReference: aFileReference.
	self reload
]

{ #category : 'operations' }
ViennaRefactoringBrowser >> loadFromDirectory [

	(UIManager default
		 chooseDirectory: 'Directory to open'
		 from: FileLocator viennaTalkDocumentDirectory) ifNotNil: [ :dir |
		self load: dir ]
]

{ #category : 'operations' }
ViennaRefactoringBrowser >> loadFromFile [

	(UIManager default
		 chooseExistingFileReference: 'File to open'
		 extensions: #( 'vdmsl' )
		 path: FileLocator viennaTalkDocumentDirectory) ifNotNil: [ :file |
		self load: file ]
]

{ #category : 'operations' }
ViennaRefactoringBrowser >> loadSource: aString [

	| ast |
	ast := ViennaVDMParser current document end parse: aString.
	ast isPetit2Failure ifTrue: [
		self alert: 'Failed to parse the source.'.
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

{ #category : 'menus' }
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
											   name: 'Reload';
											   action: [ self reload ];
											   enabled: [ self hasFileReference ] ];
									   addItem: [ :i |
										   i
											   name: 'Load from Directory...';
											   action: [ self loadFromDirectory ] ];
									   addItem: [ :i |
										   i
											   name: 'Load from File...';
											   action: [ self loadFromFile ] ];
									   addItem: [ :i |
										   i
											   name: 'Save';
											   action: [ self save ];
											   enabled: [ self hasFileReference ] ];
									   addItem: [ :i |
										   i
											   name: 'Save As...';
											   action: [ self saveAs ] ] ];
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
											   action: [ self runAllTests ] ] ]) ];
			  addItem: [ :item |
				  item
					  name: 'Smalltalk';
					  subMenu: (self newMenu addGroup: [ :g |
								   g addItem: [ :i |
										   i
											   name: 'Generate Smalltalk classes';
											   action: [ self generateSmalltalkClasses ] ] ]) ] ]
]

{ #category : 'operations' }
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

{ #category : 'operations' }
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

{ #category : 'accessing' }
ViennaRefactoringBrowser >> modelChanged [

	self model ifNotNil: [ :epiLog |
		epiLog hideSave.
		self updateEpiLogPage.
		epiLog hasSpecificationChange ifTrue: [
			self setDirty.
			self save ].
		self typecheck.
		animation ifNotNil: [
			| state |
			state := epiLog state.
			[
			animation
				specification: self specification
				ifError: [ :msg | self notifyAnimationError: msg ].
			animation state: state ]
				on: Error
				do: [ :ex | animation init ].
			epiLog state: animation state ].
		self updateTestButtons.
		(epiLog hasSpecificationChange and: [ runsAllTests ]) ifTrue: [
			self runAllTests ].
		UIManager default inform:
			epiLog printString , ' - ' , epiLog comment ]
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> module [
	^ moduleList selection selectedItem
]

{ #category : 'menus' }
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

{ #category : 'operations-tests' }
ViennaRefactoringBrowser >> mutatedSpecificationsDo: aBlock [

	self specification ifNotNil: [ :baseAst |
		{
			ViennaAddOneMutation new.
			ViennaNegateMutation new } do: [ :mutation |
			mutation
				allMutationsTo: (self module testTargetModule
						 ifNil: [ baseAst ]
						 ifNotNil: [ :m | baseAst moduleNamed: m identifier ])
				do: [ :mutatedAst |
					aBlock value: baseAst value: mutation value: mutatedAst ] ] ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> narrativeTimelineSelected [

	showsUserTimelineButton state: false.
	showsArtifactTimelineButton state: false.
	self selectedTimelineChanged
]

{ #category : 'operations-source signal' }
ViennaRefactoringBrowser >> notifyAnimationError: aString [

]

{ #category : 'operations-source signal' }
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

{ #category : 'operations-source signal' }
ViennaRefactoringBrowser >> notifyTypeError: aViennaTypeError [

	pendingTypeError := aViennaTypeError.
	self updateSourceSignalButton.
	self updateSourceWithTypeError
]

{ #category : 'private' }
ViennaRefactoringBrowser >> okToClose [

	self isDirty ifFalse: [ ^ true ].
	(UIManager default
		 confirm: 'Export the spec before close?'
		 orCancel: [ ^ false ]) ifTrue: [ self save ].
	^ true
]

{ #category : 'operations' }
ViennaRefactoringBrowser >> onTheFlyCheckSourceText [

	self highlightSourceText
]

{ #category : 'interface opening' }
ViennaRefactoringBrowser >> open [

	Smalltalk at: #ViennaLauncher ifPresent: [ :launcher |
		launcher isMultiWindowMode ifTrue: [
			^ self build
				  openInExternalWindow;
				  layoutFrame: (0 @ 0 extent: 1 @ 1);
				  yourself ] ].
	^ super open
]

{ #category : 'operations-git' }
ViennaRefactoringBrowser >> openGitCommitMenu [

	(self newMenu addGroup: [ :group |
		 group
			 addItem: [ :item |
				 item
					 name: 'Commit';
					 action: [ self gitCommit ] ];
			 addItem: [ :item |
				 item
					 name: 'Commit and Push';
					 action: [ self gitCommitAndPush ] ] ]) openWithSpecAtPointer
]

{ #category : 'interface opening' }
ViennaRefactoringBrowser >> openInExternalWindow [

	<script: 'ViennaRefactoringBrowser new openInExternalWindow'>
	| morph |
	morph := self build.
	morph
		openInExternalWindow;
		layoutFrame: (0 @ 0 extent: 1 @ 1)
]

{ #category : 'private' }
ViennaRefactoringBrowser >> parser [

	| parser |
	parser := ViennaVDMParser current.
	^ parser tracesDefinitions end / parser namedTrace end
	  / parser module end / parser typeDefinitions end
	  / parser valueDefinitions end / parser functionDefinitions end
	  / parser operationDefinitions end / parser stateDefinition end
	  / parser document end / parser importModuleSignature end
	  / parser accessTypeDefinition end
	  / parser accessValueDefinition end / parser stateDefinition end
	  / parser accessFunctionDefinition end
	  / parser accessOperationDefinition end / parser typeImport end
	  / parser valueImport end / parser functionImport end
	  / parser operationImport end
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> pendingSyntaxError [

	^ pendingSyntaxError
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> pendingTypeError [

	^ pendingTypeError
]

{ #category : 'layouts' }
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

{ #category : 'accessing' }
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
	node := ViennaVDMParser current expression parse:
		        (text copyFrom: start to: end).
	^ node isPetit2Failure
		  ifTrue: [ nil ]
		  ifFalse: [
			  node
				  parent: self module;
				  yourself ]
]

{ #category : 'accessing' }
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

{ #category : 'menus' }
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

{ #category : 'operations' }
ViennaRefactoringBrowser >> reload [

	^ fileReference ifNotNil: [ :ref |
		  (self loadSource: (self sourceFrom: ref)) ifNil: [
			  (self
				   confirm: 'Do you want to open a File syntax debugger?'
				   label: 'ViennaTalk') ifTrue: [
				  ViennaFileSyntaxDebugger openOn: ref ] ] ]
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> removeAllEpiLog [

	(self confirm: 'Remove all from EpiLog?' label: 'EpiLog') ifTrue: [
		self epiLogVanilla: self specification state: animation state.
		self epiLog hideStorage garbageCollect.
		self updateEpiLogList ]
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> removeEpiLog [

	narrativeDropList selectedItem
		ifNotNil: [ :enumerator |
		self removeEpiLogFromNarrative: enumerator narrative ]
		ifNil: [ self removeEpiLogFromChronicle ]
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> removeEpiLogFromChronicle [

	epiLogList selectedItems ifNotEmpty: [ :epiLogs |
		(UIManager default proceed: 'Remove from EpiLog?' title: 'EpiLog')
			ifTrue: [
				epiLogs do: [ :epiLog |
					self epiLog == epiLog ifFalse: [ epiLog hideRemove ].
					self updateEpiLogList ] ] ]
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> removeEpiLogFromNarrative: aHiDeNarrative [

	(epiLogList selectedItems copyWithout: self epiLog) ifNotEmpty: [
		:epiLogs |
		(UIManager default
			 proceed: 'Remove from ' , aHiDeNarrative name , '?'
			 title: 'EpiLog') ifTrue: [
			aHiDeNarrative removeAll: epiLogs.
			self updateEpiLogList ] ]
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> removeNarrative [

	narrativeDropList selectedItem ifNotNil: [ :enumerator |
		| narrative |
		narrative := enumerator narrative.
		(UIManager default
			 confirm: 'Remove ' , narrative name , '?'
			 label: 'EpiLog') ifTrue: [
			narrative storage removeNarrative: narrative.
			self updateNarrativeDropList: nil.
			showsArtifactTimelineButton state: true ] ]
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> revertTo: aViennaEpiLog [

	self epiLogRevertion: aViennaEpiLog.
	self updateModuleList
]

{ #category : 'operations-epiLog' }
ViennaRefactoringBrowser >> revertToEpiLog [

	epiLogList selectedItem ifNotNil: [ :epiLog | self revertTo: epiLog ]
]

{ #category : 'operations-tests' }
ViennaRefactoringBrowser >> runAllTests [

	testProcess ifNotNil: [ testProcess terminate ].
	testProcess := [
	               | ast testAnimation |
	               ast := self specification ifNil: [ ^ nil ].
	               testAnimation := ViennaAnimation transpiler
		                                specification: ast;
		                                yourself.
	               testResultTable items:
		               (Array streamContents: [ :stream |
			                ast testOperationsDo: [ :testOperation |
				                | moduleName operationName |
				                moduleName := testOperation module identifier.
				                operationName := testOperation identifier.
				                stream nextPut: (ViennaUnitTestResultItem
						                 module: moduleName
						                 operation: operationName
						                 animation: testAnimation) ].
			                ast namedTracesDo: [ :namedTrace |
				                stream nextPut:
					                (ViennaCombinatorialTestResultItem on: namedTrace) ] ]).
	               testResultTable items do: [ :item |
		               item run.
		               testResultTable refresh ].
	               testProcess := nil ] forkAt:
		               Processor userBackgroundPriority
]

{ #category : 'operations-tests' }
ViennaRefactoringBrowser >> runMutationTesting [

	testProcess ifNotNil: [ testProcess terminate ].
	testProcess := [
	               | resultViewer |
	               resultViewer := ViennaMutationTestResultViewer new.
	               self mutatedSpecificationsDo: [
		               :baseAst
		               :mutation
		               :mutatedAst |
		               resultViewer
			               addMutation: mutation
			               baseSpecification: baseAst
			               mutatedSpecification: mutatedAst ].
	               resultViewer open.
	               resultViewer resultItems do: [ :resultItem |
		               resultItem run.
		               resultViewer refresh ] ] fork
]

{ #category : 'operations' }
ViennaRefactoringBrowser >> save [

	fileReference ifNotNil: [ :ref |
		ref isDirectory
			ifTrue: [
				(ref filesMatching: '*.vdmsl') do: [ :file | file ensureDeleteAll ].
				self specification modulesDo: [ :moduleNode |
					| file |
					file := ref / moduleNode identifier withExtension: 'vdmsl'.
					file
						ensureDeleteAll;
						writeStreamDo: [ :stream |
							stream nextPutAll:
									((ViennaVDMFormatter format: moduleNode) withLineEndings:
											 OSPlatform current lineEnding) ] ] ]
			ifFalse: [
				ref
					ensureDeleteAll;
					writeStreamDo: [ :stream |
						stream nextPutAll:
								(self source withLineEndings: OSPlatform current lineEnding) ] ].
		self clearDirty ]
]

{ #category : 'operations' }
ViennaRefactoringBrowser >> saveAs [

	(UIManager default
		 confirm: 'Save to'
		 trueChoice: 'Directory'
		 falseChoice: 'File')
		ifTrue: [ self saveAsDirectory ]
		ifFalse: [ self saveAsFile ]
]

{ #category : 'operations' }
ViennaRefactoringBrowser >> saveAsDirectory [

	(UIManager default
		 chooseDirectory: 'Directory to save'
		 from: FileLocator viennaTalkDocumentDirectory) ifNotNil: [ :dir |
		(dir filesMatching: '*.vdmsl') do: [ :file | file ensureDeleteAll ].
		self specification modulesDo: [ :moduleNode |
			| file |
			file := dir / moduleNode identifier withExtension: 'vdmsl'.
			file
				ensureDeleteAll;
				writeStreamDo: [ :stream |
					stream nextPutAll:
							((ViennaVDMFormatter format: moduleNode) withLineEndings:
									 OSPlatform current lineEnding) ] ].
		UIManager default message: 'Save to ' , dir basename , '/.'.
		self fileReference: dir.
		self clearDirty ]
]

{ #category : 'operations' }
ViennaRefactoringBrowser >> saveAsFile [

	(UIManager default
		 chooseForSaveFileReference: 'File to save'
		 extensions: #( 'vdmsl' )
		 path: FileLocator viennaTalkDocumentDirectory asFileReference)
		ifNotNil: [ :file |
			file
				ensureDeleteAll;
				writeStreamDo: [ :stream |
					stream nextPutAll:
							(self source withLineEndings: OSPlatform current lineEnding) ].
			UIManager default message: 'Save to ' , file basename , '.'.
			self fileReference: file.
			self clearDirty ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> selectedGitOutgoingCommitChanged [

	self updateGitButtons
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> selectedGitRemoteCommitChanged [

	self updateGitButtons
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> selectedTimelineChanged [

	^ self
		  updateEpiLogMatcherDropList;
		  updateEpiLogList
]

{ #category : 'private' }
ViennaRefactoringBrowser >> setDirty [

	dirty := true
]

{ #category : 'operations-slicing' }
ViennaRefactoringBrowser >> sliceAttribute [

	^ sliceAttribute ifNil: [
		  sliceAttribute := TextBackgroundColor color: self sliceColor ]
]

{ #category : 'operations-slicing' }
ViennaRefactoringBrowser >> sliceColor [

	^ Color cyan alpha: 0.2
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> sliceNodesChanged [

	moduleList refresh.
	categoryList refresh.
	definitionList refresh.
	self updateSource
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> source [
	^ self specification
		ifNil: [ String new ]
		ifNotNil: [ :ast | ViennaVDMFormatter format: ast ]
]

{ #category : 'private' }
ViennaRefactoringBrowser >> sourceFrom: aFileReference [

	^ aFileReference ifNotNil: [ :ref |
		  ref isDirectory
			  ifTrue: [
				  | modelFiles testFiles |
				  modelFiles := OrderedCollection new.
				  testFiles := OrderedCollection new.
				  ref files do: [ :file |
					  (file basename endsWith: '.vdmsl') ifTrue: [
						  (file basename endsWith: 'Test.vdmsl')
							  ifTrue: [ testFiles add: file ]
							  ifFalse: [ modelFiles add: file ] ] ].
				  modelFiles := modelFiles asSortedCollection: [ :less :more |
					                less basename <= more basename ].
				  testFiles := testFiles asSortedCollection: [ :less :more |
					               less basename <= more basename ].
				  String streamContents: [ :writeStream |
					  modelFiles do: [ :file |
						  writeStream nextPutAll:
							  (file contents copyWith: Character cr)
								  withInternalLineEndings ].
					  testFiles do: [ :file |
						  writeStream nextPutAll:
							  (file contents copyWith: Character cr)
								  withInternalLineEndings ] ] ]
			  ifFalse: [ ref contents withInternalLineEndings ] ]
]

{ #category : 'layouts' }
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
		  add: (SpBoxLayout newVertical
				   add: (SpBoxLayout newHorizontal
						    add: autoTestButton expand: false;
						    add: runTestButton expand: false;
						    add: (SpBoxLayout newHorizontal
								     hAlignEnd;
								     add: runMutationTestingButton expand: false);
						    yourself)
				   expand: false;
				   add: testResultTable;
				   yourself);
		  yourself
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> sourceSelection [

	^ sourceText tracingSource
		  nodeContaining: sourceText selectionInterval
		  ifAbsent: [ nil ]
]

{ #category : 'accessing' }
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

{ #category : 'operations-source signal' }
ViennaRefactoringBrowser >> sourceSignalButtonPressed [

	pendingSyntaxError ifNotNil: [ pendingSyntaxError inspect ].
	pendingTypeError ifNotNil: [ pendingTypeError inspect ]
]

{ #category : 'menus' }
ViennaRefactoringBrowser >> sourceTextContextMenu [

	| menu node topLevelDefinition |
	menu := self newMenu.
	node := self sourceSelection.
	topLevelDefinition := node ifNotNil: [ node topLevelDefinition ].
	node ifNotNil: [
		self addRefactoringMenuGroupOn: node to: menu with: [ :group |  ] ].
	menu addGroup: [ :group |
		topLevelDefinition ifNotNil: [
			group addItem: [ :item |
				item
					name: 'Add slice for selection';
					action: [ self addSlice: node ] ] ].
		sliceNodes notEmpty ifTrue: [
			group addItem: [ :item |
				item
					name: 'Clear slices';
					action: [ self clearSlice ] ] ] ].
	^ menu
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> specification [

	^ self epiLog specification
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> testResultChanged [

	self updateSourceWithTypeError
]

{ #category : 'menus' }
ViennaRefactoringBrowser >> testResultTableContextMenu [

	| menu |
	menu := self newMenu.
	testResultTable selection selectedItem ifNotNil: [ :item |
		item buildContextMenu: menu for: self ].
	^ menu
]

{ #category : 'accessing' }
ViennaRefactoringBrowser >> title [

	^ 'Vienna Refactoring Browser'
]

{ #category : 'operations-tests' }
ViennaRefactoringBrowser >> toggleRunsAllTests [

	autoTestButton state: (runsAllTests := runsAllTests not).
	self runAllTests
]

{ #category : 'operations' }
ViennaRefactoringBrowser >> typecheck [

	[
	self specification
		forgetTypecheck;
		typecheck.
	self notifyTypeError: nil ]
		on: ViennaTypeError
		do: [ :ex | self notifyTypeError: ex ]
]

{ #category : 'updating' }
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
	(newItems includes: oldSelection)
		ifTrue: [ categoryList selectItem: oldSelection ]
		ifFalse: [ categoryList selectIndex: 1 ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateDefinitionList [

	| newItems oldSelection |
	newItems := (Array with: self category) , (self category
		             ifNotNil: [ :ast | self definitionsFromCategory: ast ]
		             ifNil: [ Array new ]).
	oldSelection := definitionList selection selectedItem.
	definitionList items: newItems.
	(newItems includes: oldSelection)
		ifTrue: [ definitionList selectItem: oldSelection ]
		ifFalse: [ definitionList selectIndex: 1 ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateEpiLogButtons [

	epiLogList selectedItem
		ifNotNil: [ editEpiLogTagButton enable ]
		ifNil: [ editEpiLogTagButton disable ].
	epiLogList selectedItem ~~ self epiLog
		ifTrue: [
			revertEpiLogButton enable.
			removeEpiLogButton enable ]
		ifFalse: [
			revertEpiLogButton disable.
			removeEpiLogButton disable ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateEpiLogCherrypickList [

	epiLogCherrypickList items: self epiLogCherrypickChanges.
	self updateEpiLogCherrypickText
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateEpiLogCherrypickText [

	epiLogCherrypickList selectedItem
		ifNotNil: [ :diff |
			| text |
			text := diff sourceDiffText.
			epiLogCherrypickText text: text string asString asText.
			epiLogCherrypickText withAdapterDo: [ :a |
				a widgetDo: [ :w |
					w text runs: text runs.
					w textArea compose ] ] ]
		ifNil: [ epiLogCherrypickText text: '' ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateEpiLogDiffList [

	epiLogDiffList items: self epiLogChanges.
	self updateEpiLogDiffText
]

{ #category : 'updating' }
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

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateEpiLogList [

	epiLogList ifNotNil: [
		| selection items |
		selection := epiLogList selectedItem.
		items := (self epiLog
			          ifNil: [ #(  ) ]
			          ifNotNil: [ :epiLog |
			          self epiLogEnumerator arrayFrom: epiLog ]) select:
			         (epiLogMatcherDropList selectedItem ifNil: [
				          [ :epilog | true ] ]).
		(epiLogListSizeDropList selectedItem ifNotNil: #value) ifNotNil: [
			:limit |
			items size > limit ifTrue: [ items := items first: limit ] ].
		epiLogList items: items.
		selection ifNotNil: [
			(items includes: selection)
				ifTrue: [ epiLogList selectItem: selection ]
				ifFalse: [ epiLogList unselectAll ] ].
		self
			updateEpiLogButtons;
			updateEpiLogDiffList;
			updateEpiLogCherrypickList ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateEpiLogMatcherDropList [

	self ifHiDeHoVisible: [
		| selection epiLogs |
		selection := epiLogMatcherDropList selectedItem.
		epiLogMatcherDropList items: (Array streamContents: [ :stream |
				 | tags |
				 tags := Set new.
				 (epiLogs := self epiLog ifNil: [ #(  ) ] ifNotNil: [ :epiLog |
					             self epiLogEnumerator
						             ifNotNil: [ :enumerator |
						             enumerator arrayFrom: epiLog ]
						             ifNil: [ #(  ) ] ]) do: [ :epiLog |
					 tags addAll: epiLog tags ].
				 tags do: [ :tag | stream nextPut: (ViennaEpiLogMatcher tag: tag) ].
				 stream nextPut: ViennaEpiLogMatcher all.
				 epiLogs ifNotEmpty: [
					 stream nextPut: (ViennaEpiLogMatcher heads: epiLogs first).
					 stream nextPut: (ViennaEpiLogMatcher branches: epiLogs first) ].
				 "stream nextPut: (ViennaEpiLogMatcher
						  executionClosureFrom: self epiLog
						  enumerator: self epiLogEnumerator
						  at: (epiLogList selectedItem ifNil: [ self epiLog ])).
				 stream nextPut: (ViennaEpiLogMatcher
						  semanticClosureFrom: self epiLog
						  enumerator: self epiLogEnumerator
						  at: (epiLogList selectedItem ifNil: [ self epiLog ])).
				 stream nextPut: (ViennaEpiLogMatcher
						  syntacticClosureFrom: self epiLog
						  enumerator: self epiLogEnumerator
						  at: (epiLogList selectedItem ifNil: [ self epiLog ]))."
				 moduleList selectedItem ifNotNil: [ :module |
					 stream nextPut: (ViennaEpiLogMatcher module: module identifier) ].
				 definitionList selectedItem ifNotNil: [ :definition |
					 definition isViennaTopLevelDefinitionNode ifTrue: [
						 definition identifiers do: [ :identifier |
							 stream nextPut: (ViennaEpiLogMatcher
									  identifier: identifier
									  module: definition module identifier) ] ] ] ]) sorted.
		(epiLogMatcherDropList items includes: selection) ifTrue: [
			epiLogMatcherDropList selectItem: selection ] ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateEpiLogPage [

	self ifHiDeHoVisible: [
		self
			updateNarrativeDropList;
			updateEpiLogMatcherDropList;
			updateEpiLogList;
			updateEpiLogSourceText ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateEpiLogSourceText [

	self ifHiDeHoVisible: [
		self definition ifNotNil: [ :definition |
			(epiLogList selectedItem ifNil: [ self epiLog ]) specification
				ifNotNil: [ :spec |
					(spec moduleNamed: definition module identifier) ifNotNil: [
						:module |
						epiLogSourceText text: module tracingHighlightedSource.
						^ self ] ] ].
		epiLogSourceText text: '' ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateGitButtons [

	gitFetchButton enabled: true.
	gitPullButton enabled: self gitCanPull.
	gitCommitButton enabled: self gitCanCommit.
	gitCommitMenuButton enabled: self gitCanCommitAndPush.
	gitPushButton enabled: self gitCanPush.
	gitMergeButton enabled: self gitCanMerge
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateGitDiffList [

	gitDiffList items: self gitChanges.
	self updateGitDiffText
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateGitDiffText [

	gitDiffList selectedItem
		ifNotNil: [ :diff |
			| text |
			text := diff sourceDiffText.
			gitDiffText text: text string asString asText.
			gitDiffText withAdapterDo: [ :a |
				a widgetDo: [ :w |
					w text runs: text runs.
					w textArea compose ] ] ]
		ifNil: [ gitDiffText text: '' ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateGitOutgoingCommitList [

	gitOutgoingCommitList items: (Array streamContents: [ :stream |
			 self gitOutgoingCommitsDo: [ :commit | stream nextPut: commit ] ]).
	gitRemoteCommitList refresh
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateGitPage [

	self
		updateGitRemoteCommitList;
		updateGitOutgoingCommitList;
		updateGitDiffList;
		updateGitButtons
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateGitRemoteCommitList [

	gitRemoteCommitList items: (Array streamContents: [ :stream |
			 self icebergRepositoryDo: #fetch.
			 self gitRemoteCommitsDo: [ :commit | stream nextPut: commit ] ]).
	gitOutgoingCommitList refresh
]

{ #category : 'updating' }
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

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateNarrativeDropList [

	self updateNarrativeDropList:
		(narrativeDropList selectedItem ifNotNil: #narrative)
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateNarrativeDropList: aHiDeNarrative [

	self epiLog
		ifNotNil: [ :epiLog |
			| items selection |
			items := epiLog hideStorage narratives collect: [ :narrative |
				         ViennaEpiLogNarrativeTimelineEnumerator on: narrative ].
			selection := items
				             detect: [ :enumerator |
				             enumerator narrative = aHiDeNarrative ]
				             ifNone: [ nil ].
			selection ifNil: [ narrativeDropList resetSelection ].
			narrativeDropList items: items.
			selection ifNotNil: [ narrativeDropList selectItem: selection ] ]
		ifNil: [ narrativeDropList items: {  } ]
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateSource [

	self definition
		ifNotNil: [ :node |
			sourceText text: (self getSource: node).
			self updateSourceWithTypeError ]
		ifNil: [ sourceText text: '' ]
]

{ #category : 'updating' }
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

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateSourceWithTypeError [

	| text textWidget |
	sourceText withAdapterDo: [ :a |
		a widgetDo: [ :w |
			textWidget := w.
			textWidget textArea segments copy do: [ :s | s delete ] ] ].
	textWidget ifNil: [ ^ self ].
	text := sourceText text isText
		        ifTrue: [ sourceText text ]
		        ifFalse: [ textWidget text ].
	textWidget text string asString = text string asString ifTrue: [
		textWidget text runs: text runs ].
	textWidget textArea handleParagraphChange: [
		(pendingTypeError ifNotNil: #node) ifNotNil: [ :node |
			| from to |
			(sourceText tracingSource intervalForSource: node) key ifNotEmpty: [
				:interval |
				from := interval first.
				to := interval last ].
			(from notNil and: [
				 (from between: 1 and: text size) and: [
					 to notNil and: [ to between: 1 and: text size ] ] ]) ifTrue: [
				textWidget text
					addAttribute: (TextBackgroundColor color: Color yellow darker)
					from: from
					to: to ] ].
		sliceNodes ifNotNil: [
			sliceNodes do: [ :node |
				(sourceText tracingSource intervalForSource: node) key
					ifNotEmpty: [ :interval |
						textWidget text
							addAttribute: self sliceAttribute
							from: interval first
							to: interval last ] ] ].
		testResultTable selectedItem ifNotNil: [ :testResult |
			testResult exception ifNotNil: [ :exception |
				(self
					 findIntervalsFromContext: exception signalerContext
					 source: sourceText tracingSource) do: [ :interval |
					textWidget text
						addAttribute:
						(TextBackgroundColor color: (Color red muchLighter alpha: 0.5))
						from: (interval first max: 1)
						to: (interval last min: textWidget text size) ] ] ] ].
	textWidget textArea ifNotNil: #compose
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateStateTable [

	stateTable refresh
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateStateTableItems [

	stateTable items: animation state keys asSortedCollection
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> updateTestButtons [

	runTestButton enabled: self specification hasTests.
	runMutationTestingButton enabled:
		(self module ifNotNil: [ :m | m hasTestTarget ] ifNil: [ false ])
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> userTimelineSelected [

	showsArtifactTimelineButton state: false.
	narrativeDropList resetSelection.
	self selectedTimelineChanged
]

{ #category : 'updating' }
ViennaRefactoringBrowser >> windowIsClosing [

	testProcess ifNotNil: [
		testProcess terminate.
		testProcess := nil ].
	highlighterProcess ifNotNil: [
		highlighterProcess terminate.
		highlighterProcess := nil ]
]
