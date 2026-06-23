Class {
	#name : 'VDMPad',
	#superclass : 'Object',
	#instVars : [
		'handlerMap',
		'engine'
	],
	#classVars : [
		'LocalOnly',
		'Server'
	],
	#category : 'ViennaTalk-VDMPad-Core',
	#package : 'ViennaTalk-VDMPad-Core'
}

{ #category : 'instance creation' }
VDMPad class >> default [
	^ self on: self defaultEngine
]

{ #category : 'defaults' }
VDMPad class >> defaultEngine [

	^ ViennaEngineForVDMPad new
]

{ #category : 'defaults' }
VDMPad class >> defaultLocalOnly [
	^ true
]

{ #category : 'defaults' }
VDMPad class >> defaultPort [
	^ 8085
]

{ #category : 'servicing' }
VDMPad class >> flushServer [
	<script: 'VDMPad flushServer'>
	Server
		ifNotNil: [ Server stop.
			Server unregister.
			Server := nil ]
]

{ #category : 'servicing' }
VDMPad class >> installHandler [
	"VDMPad installHandler"

	self server delegate: self default
]

{ #category : 'servicing' }
VDMPad class >> isRunning [
	^ Server notNil and: [ Server isRunning ]
]

{ #category : 'servicing' }
VDMPad class >> isRunning: aBoolean [
	aBoolean = true
		ifTrue: [ 
			self isRunning
				ifFalse: [ self startService ] ]
		ifFalse: [ 
			self isRunning
				ifTrue: [ self stopService ] ]
]

{ #category : 'servicing' }
VDMPad class >> localOnly [
	^ LocalOnly ifNil: [ LocalOnly := self defaultLocalOnly ]
]

{ #category : 'servicing' }
VDMPad class >> localOnly: aBoolean [
	aBoolean ~= false
		ifTrue: [ 
			LocalOnly ~= false
				ifTrue: [ ^ self ].
			LocalOnly := true ]
		ifFalse: [ 
			LocalOnly = false
				ifTrue: [ ^ self ].
			LocalOnly := false ].
	self isRunning
		ifTrue: [ 
			self stopService.
			self startService ]
]

{ #category : 'instance creation' }
VDMPad class >> on: aViennaEngine [
	^ self new
		engine: aViennaEngine;
		yourself
]

{ #category : 'servicing' }
VDMPad class >> server [
	^ Server
		ifNil: [ 
			Server := (ZnMultiThreadedServer on: self defaultPort)
				bindingAddress:
						(LocalOnly ~= false
								ifTrue: [ #[127 0 0 1] ]
								ifFalse: [ nil ]);
				register;
				start;
				yourself ]
]

{ #category : 'servicing' }
VDMPad class >> startService [
	<script: 'VDMPad startService'>
	self installHandler
]

{ #category : 'servicing' }
VDMPad class >> stopService [
	Server
		ifNotNil: [ 
			Server stop.
			Server := nil ]
]

{ #category : 'servicing' }
VDMPad class >> toggleStartStop [
	self isRunning
		ifTrue: [ self stopService ]
		ifFalse: [ self startService ]
]

{ #category : 'settings' }
VDMPad class >> viennaSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder setting: #isRunning)
		parent: #ViennaTalkServices;
		target: self;
		description:
				'If checked then a VDMPad server will be up so that it can be accessed by web browsers and Vienna clients.';
		label: 'VDMPad';
		order: 0.1;
		with: [ 
					(aBuilder setting: #localOnly)
						target: self;
						description:
								'If checked then a VDMPad server will serve only from localhost. Accesses from other hosts will be rejected.';
						label: 'Serves for only localhost' ]
]

{ #category : 'settings' }
VDMPad class >> viennaToolsMenuOn: aBuilder [

	<ViennaToolsMenu>
	(aBuilder item: #'VDMPad server')
		order: 0.0;
		label: 'Toggle VDMPad server';
		help: 'start/top VDMPad server';
		action: [ self toggleStartStop ];
		icon: (self isRunning
				 ifTrue: [ Smalltalk ui iconNamed: #checkBoxOn ]
				 ifFalse: [ Smalltalk ui iconNamed: #checkBoxOff ]);
		withSeparatorAfter
]

{ #category : 'settings' }
VDMPad class >> worldMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'VDMPad server')
		parent: #ViennaTalk;
		order: 0.2;
		with: [ 
					(aBuilder item: #VDMPadStart)
						label: 'start';
						action: [ self startService ];
						order: 0.1;
						parent: #'VDMPad server';
						help: 'start VDMPad server';
						icon: nil;
						enabledBlock: [ self isRunning not ].
					(aBuilder item: #VDMPadStop)
						label: 'stop';
						action: [ self stopService ];
						order: 0.1;
						parent: #'VDMPad server';
						help: 'stop VDMPad server';
						icon: nil;
						enabledBlock: [ self isRunning ] ]
]

{ #category : 'request handling-javascript' }
VDMPad >> VDMPad [
	^ self
		responseJS:
			(String
				streamContents: [ :stream | 
					stream
						nextPutAll: self VDMPadIDE;
						nextPutAll: self VDMPadMenu;
						nextPutAll: self VDMPadEpiLogSrc;
						nextPutAll: '
    VDMPad.setupIdeNodes();
    VDMPad.setupMenuNodes();
    VDMPad.loadFromStorage();' ])
]

{ #category : 'request handling-javascript' }
VDMPad >> VDMPadEpiLog [
	^ self responseJS: self VDMPadEpiLogSrc
]

{ #category : 'request handling-javascript' }
VDMPad >> VDMPadEpiLogSrc [

	^ '
      if (typeof(VDMPad) == "undefined") VDMPad = {};
      if (VDMPad.storage)
          VDMPad.EpiLog = JSON.parse(VDMPad.storage.getItem("`EpiLog")) || [];

      VDMPad.epilogOn = function () { 
          VDMPad.epilogEnabled = true;
          var areaNode = document.getElementById("EpiLogArea");
          if (areaNode) { 
              if (!areaNode.firstElementChild) {
                  var logoNode = document.createElement("div");
                  logoNode.id = "EpiLogLogo";
                  logoNode.style.clear = "both";
                  logoNode.style.fontFamily = "Helvetica, sans-serif";
                  logoNode.style.fontSize = "24px";
                  logoNode.style.fontWeight = "70";
                  logoNode.style.paddingDown = "50px";
                  logoNode.innerText = "EpiLog";
                  var epilogNode = document.createElement("div");
                  epilogNode.id = "here";
                  areaNode.appendChild(logoNode);
                  areaNode.appendChild(epilogNode);
                  VDMPad.epilogRender();
              }   
          }
          VDMPad.epilogButton.turnOn();
      };
      VDMPad.epilogOff = function () { 
          VDMPad.epilogEnabled = false;
          var areaNode = document.getElementById("EpiLogArea");
          while (areaNode.firstElementChild)
              areaNode.firstElementChild.remove();
          VDMPad.epilogRender();
          VDMPad.epilogButton.turnOff();
      };
      VDMPad.toggleEpilog = function () {
          if (VDMPad.epilogEnabled)
              VDMPad.epilogOff();
          else
              VDMPad.epilogOn();
      };
      VDMPad.epilogEqualState = function (state1, state2) { 
          for (var key in state1)
              if (!(key in state2) || state1[key] != state2[key])
                  return false;
          for (var key in state2)
              if (!(key in state1))
                  return false;
          return true;
      };
      VDMPad.epilogAppend = function (log) { 
          (function () {
              var source = log.source;
              var run = {"prestates":log.prestates, "expression":log.expression, "value":log.value, "poststates":log.poststates};
              if (VDMPad.EpiLog.length == 0)
                  return VDMPad.EpiLog.push({"source":source, scenarios:[[run]]});
              var lastPhase = VDMPad.EpiLog[VDMPad.EpiLog.length - 1];
              if (lastPhase.source != log.source)
                  return VDMPad.EpiLog.push({"source":source, scenarios:[[run]]});
              if (lastPhase.scenarios.length == 0)
                  return lastPhase.scenarios.push([run]);
              var lastScenario = lastPhase.scenarios[lastPhase.scenarios.length-1];
              if (lastScenario.length == 0)
                  return lastScenario.push(run);
              var lastRun = lastScenario[lastScenario.length - 1];
              if (VDMPad.epilogEqualState(lastRun.poststates, log.prestates))
                  return lastScenario.push(run);
              lastPhase.scenarios.push([run]);
          })();
          if (VDMPad.storage)
              VDMPad.storage.setItem("`EpiLog", JSON.stringify(VDMPad.EpiLog));
          VDMPad.epilogRender();
      };

      VDMPad.epilogDiffState = function(state1, state2) {
          var diff = {};
          for (var key in state1) {
              if (state1[key] != state2[key]) {
                  diff[key] = state1[key];
              }
          }
          return diff;
      };
    VDMPad.shortVarName = function(name) {
        var index = name.indexOf("`");
        return name.slice(0, index) == "DEFAULT"?name.slice(index+1,name.length):name;
    };

    VDMPad.epilogSourceNode = function(path) {
        var phaseIndex = path[0];
        var source = VDMPad.EpiLog[phaseIndex].source;
        var oldSource = phaseIndex > 0 ? VDMPad.EpiLog[phaseIndex-1].source : "";
        var preNode = document.createElement("pre");
        var codeNode = document.createElement("code");
        codeNode.className = "vdm";
        preNode.style="border:ridge 2px gray;border-radius:5px;background-color:#ffffff; padding: 10px;";
        codeNode.innerText = source;
        preNode.appendChild(codeNode);
        preNode.path = path;
        return preNode;
    };
    
    VDMPad.epilogExpressionValueNode = function(path) {
        var run = VDMPad.EpiLog[path[0]].scenarios[path[1]][path[2]];
        var expression = run.expression;
        var value = run.value;
        var node = document.createElement("span");
        var expressionNode = document.createElement("span");
        expressionNode.innerText = expression;
        var arrowNode = document.createElement("span");
        arrowNode.innerText = " ☞ ";
        var valueNode = document.createElement("span");
        valueNode.innerText = value;
        node.appendChild(expressionNode);
        node.appendChild(arrowNode);
        node.appendChild(valueNode);
        return node;
    }
    
    VDMPad.epilogPrestatesNode = function(path) {
        var newState = VDMPad.EpiLog[path[0]].scenarios[path[1]][path[2]].prestates;
        var oldState = path[2]>0?VDMPad.EpiLog[path[0]].scenarios[path[1]][path[2]-1].poststates:{};
        var state = VDMPad.epilogDiffState(newState, oldState);
        var tableNode = document.createElement("table");
        tableNode.className = "state-table";
        var thNode = document.createElement("tr");
        thNode.className = "state-vars";
        var trNode = document.createElement("tr");
        trNode.className = "state-values";
        var keys = [];
        for (var key in state)
            keys.push(key);
        for (var key of keys.sort()) {
            var td1 = document.createElement("td");
            td1.className = "state-var";
            td1.innerText = VDMPad.shortVarName(key);
            var td2 = document.createElement("td");
            td2.className = "state-value";
            td2.innerText = state[key];
            thNode.appendChild(td1);
            trNode.appendChild(td2);
        }
        tableNode.appendChild(thNode);
        tableNode.appendChild(trNode);
        return tableNode;
    };

    VDMPad.epilogPoststatesNode = function(path) {
        var newState = VDMPad.EpiLog[path[0]].scenarios[path[1]][path[2]].poststates;
        var oldState = VDMPad.EpiLog[path[0]].scenarios[path[1]][path[2]].prestates;
        var state = VDMPad.epilogDiffState(newState, oldState);
        var tableNode = document.createElement("table");
        tableNode.className = "state-table";
        var thNode = document.createElement("tr");
        thNode.className = "state-vars";
        var trNode = document.createElement("tr");
        trNode.className = "state-values";
        var keys = [];
        for (var key in state)
            keys.push(key);
        for (var key of keys.sort()) {
            var td1 = document.createElement("td");
            td1.className = "state-var";
            td1.innerText = VDMPad.shortVarName(key);
            var td2 = document.createElement("td");
            td2.className = "state-value";
            td2.innerText = state[key];
            thNode.appendChild(td1);
            trNode.appendChild(td2);
        }
        tableNode.appendChild(thNode);
        tableNode.appendChild(trNode);
        return tableNode;
    };

    VDMPad.epilogRunNode = function (path) {
        var run = VDMPad.EpiLog[path[0]].scenarios[path[1]][path[2]];
        var runNode = document.createElement("div");
        runNode.className = "run";
        runNode.appendChild(VDMPad.epilogPrestatesNode(path));
        runNode.appendChild(VDMPad.epilogExpressionValueNode(path));
        runNode.appendChild(VDMPad.epilogPoststatesNode(path));
        runNode.path = path;
        if (run.isInvalid)
            runNode.className = "run-invalid";
        runNode.onclick = function(event) {VDMPad.epilogShowRunMenu(runNode);event.stopPropagation();};
        return runNode;
    };

    VDMPad.epilogScenarioNode = function (path) {
        var scenario = VDMPad.EpiLog[path[0]].scenarios[path[1]];
        var scenarioNode = document.createElement("span");
        scenarioNode.className = "scenario";
        for (var index = 0; index < scenario.length; index++)
            scenarioNode.appendChild(VDMPad.epilogRunNode([path[0], path[1], index]));
        scenarioNode.path = path;
        scenarioNode.onclick = function(event) {VDMPad.epilogShowScenarioMenu(scenarioNode);event.stopPropagation();};
        return scenarioNode;
    };

    VDMPad.epilogPhaseNode = function (path) {
        var phase = VDMPad.EpiLog[path[0]];
        var phaseNode = document.createElement("div");
        phaseNode.className = "phase";
        phaseNode.appendChild(VDMPad.epilogSourceNode(path));
        var scenarios = phase.scenarios;
        for (var index = 0; index < scenarios.length; index++)
            phaseNode.appendChild(VDMPad.epilogScenarioNode([path[0], index]));
        var stopNode = document.createElement("div");
        stopNode.style.clear="both";
        phaseNode.appendChild(stopNode);
        phaseNode.path = path;
        phaseNode.onclick = function(event) {VDMPad.epilogShowPhaseMenu(phaseNode);event.stopPropagation();};
        return phaseNode;
    };

    VDMPad.epilogRender = function () {
        var here = document.getElementById("here");
        if (!here) return;
        while (here.firstChild)
            here.removeChild(here.firstChild);
        var phases = VDMPad.EpiLog;
        for (var index = 0; index < phases.length; index++)
            here.appendChild(VDMPad.epilogPhaseNode([index]));
    };

    VDMPad.epilogSelectedNode = null;
    VDMPad.epilogShowPhaseMenu = function (node) {
        VDMPad.epilogRetractMenu();
        var selectionNode = document.createElement("div");
        selectionNode.className = "selection-noborder";
        var deleteButton = document.createElement("span");
        deleteButton.className = "icon";
        deleteButton.innerText = "🗑";
        deleteButton.onclick=function (event) {VDMPad.epilogRemovePhase(node.path); VDMPad.epilogSelectedNode = null; event.stopPropagation();};
        selectionNode.appendChild(deleteButton);
        if (VDMPad.EpiLog[node.path[0]].scenarios.length > 0 && node.path[0] < VDMPad.EpiLog.length - 1) {
            var mergeButton = document.createElement("span");
            mergeButton.className = "icon";
            mergeButton.innerText = "⬇️";
            mergeButton.onclick=function (event) {VDMPad.epilogMergePhase(node.path); VDMPad.epilogSelectedNode = null; event.stopPropagation();};
            selectionNode.appendChild(mergeButton);
        }
        node.insertBefore(selectionNode, node.firstChild);
        VDMPad.epilogSelectedNode = node;
        selectionNode.onclick=VDMPad.epilogRetractMenu;
        return selectionNode;
    };
    
    VDMPad.epilogRetractMenu = function () {
        var node = VDMPad.epilogSelectedNode;
        if (!node) return;
        node.firstChild.remove();
        VDMPad.epilogSelectedNode = null;
    };
    
    VDMPad.epilogRemovePhase = function (path) {
        VDMPad.EpiLog.splice(path[0], 1);
        VDMPad.epilogRender();
    };
    VDMPad.epilogMergePhase = function (path) {
        var phase1 = VDMPad.EpiLog[path[0]];
        var phase2 = VDMPad.EpiLog[path[0]+1];
        if (!phase1) return;
        if (!phase2) return;
        for (var scenario of phase1.scenarios)
            for (var run of scenario)
                run.isInvalid = true;
        for (var scenario of phase2.scenarios)
            phase1.scenarios.push(scenario);
        phase2.scenarios = phase1.scenarios;
        VDMPad.epilogRemovePhase(path);
    };
    
    VDMPad.epilogShowScenarioMenu = function (node) {
        VDMPad.epilogRetractMenu();
        var selectionNode = document.createElement("div");
        selectionNode.className = "selection-noborder";
        var deleteButton = document.createElement("span");
        deleteButton.className = "icon";
        deleteButton.innerText = "🗑";
        deleteButton.onclick=function (event) {VDMPad.epilogRemoveScenario(node.path); VDMPad.epilogSelectedNode = null; event.stopPropagation();};
        selectionNode.appendChild(deleteButton);
        if (node.path[0] < VDMPad.EpiLog.length - 1) {
            var mergeButton = document.createElement("span");
            mergeButton.className = "icon";
            mergeButton.innerText = "⬇️";
            mergeButton.onclick=function (event) {VDMPad.epilogMergeScenario(node.path); VDMPad.epilogSelectedNode = null; event.stopPropagation();};
            selectionNode.appendChild(mergeButton);
        }
        node.insertBefore(selectionNode, node.firstChild);
        VDMPad.epilogSelectedNode = node;
        selectionNode.onclick=VDMPad.epilogRetractMenu;
        return selectionNode;
    };
    
    VDMPad.epilogRemoveScenario = function (path) {
        VDMPad.EpiLog[path[0]].scenarios.splice(path[1], 1);
        VDMPad.epilogRender();
    };
    VDMPad.epilogMergeScenario = function (path) {
        var scenario = VDMPad.EpiLog[path[0]].scenarios[path[1]];
        var phase = VDMPad.EpiLog[path[0]+1];
        if (!scenario) return;
        if (!phase) return;
        for (var run of scenario)
            run.isInvalid = true;
        phase.scenarios.unshift(scenario);
        VDMPad.epilogRemoveScenario(path);
    };

    VDMPad.epilogShowRunMenu = function (node) {
        VDMPad.epilogRetractMenu();
        var selectionNode = document.createElement("div");
        selectionNode.className = "selection-noborder";
        var deleteButton = document.createElement("span");
        deleteButton.className = "icon";
        deleteButton.innerText = "🗑";
        deleteButton.onclick=function (event) {VDMPad.epilogRemoveRun(node.path); VDMPad.epilogSelectedNode = null; event.stopPropagation();};
        selectionNode.appendChild(deleteButton);
        if (node.path[2] > 0) {
            var splitButton = document.createElement("span");
            splitButton.className = "icon";
            splitButton.innerText = "➡️";
            splitButton.onclick=function (event) {VDMPad.epilogSplitRun(node.path); VDMPad.epilogSelectedNode = null; event.stopPropagation();};
            selectionNode.appendChild(splitButton);
        }
        if (VDMPad.EpiLog[node.path[0]].scenarios[node.path[1]][node.path[2]].isInvalid) {
            var reevalButton = document.createElement("span");
            reevalButton.className = "icon";
            reevalButton.innerText = "🔄";
            reevalButton.onclick=function (event) {VDMPad.epilogReevalRun(node.path); VDMPad.epilogSelectedNode = null; event.stopPropagation();};
            selectionNode.appendChild(reevalButton);
        }
        node.insertBefore(selectionNode, node.firstChild);
        VDMPad.epilogSelectedNode = node;
        selectionNode.onclick=VDMPad.epilogRetractMenu;
        return selectionNode;
    };
    
    VDMPad.epilogRemoveRun = function (path) {
        VDMPad.EpiLog[path[0]].scenarios[path[1]].splice(path[2], 1);
        if (VDMPad.EpiLog[path[0]].scenarios[path[1]].length == 0)
            VDMPad.EpiLog[path[0]].scenarios.splice(path[1], 1);
        VDMPad.epilogRender();
    };
    VDMPad.epilogSplitRun = function (path) {
        var scenario = VDMPad.EpiLog[path[0]].scenarios[path[1]];
        if (!scenario) return;
        var newScenario = scenario.splice(path[2]);
        if (!newScenario) return;
        var index = VDMPad.EpiLog[path[0]].scenarios.length;
        VDMPad.EpiLog[path[0]].scenarios.splice(path[1]+1, 0, newScenario);
        VDMPad.epilogRender();
    };
    VDMPad.epilogReevalRun = function (path) {
        VDMPad.epilogRetractMenu();
        var phase = VDMPad.EpiLog[path[0]];
        if (!phase) return;
        var run = phase.scenarios[path[1]][path[2]];
        if (!run) return;
        var json = {};
        json.needsPrestates = true;
        json.source = phase.source;
        for (var key in run.prestates)
            json[key] = run.prestates[key];
        json.expression = run.expression;
        var req = new XMLHttpRequest();
        req.open("POST", "/eval");
        req.setRequestHeader("Content-Type", "application/json");
        req.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                var resultJson = JSON.parse(this.responseText);
                run.value = resultJson.value;
                run.prestates = resultJson.prestates;
                run.poststates = {};
                for (var key in resultJson)
                    if (key.indexOf("`") >= 0)
                        run.poststates[key] = resultJson[key];
                run.isInvalid = undefined;
                VDMPad.epilogRender();
            }
        };
        req.send(JSON.stringify(json));
    };
' withUnixLineEndings
]

{ #category : 'request handling-javascript' }
VDMPad >> VDMPadForVip: aString [

	^ String streamContents: [ :stream |
			  stream
				  nextPutAll: '
    window.VDMPad = {}';
				  cr.
			  aString
				  ifNil: [
						  stream
							  nextPutAll: 'VDMPad.storage = localStorage;';
							  cr ]
				  ifNotNil: [
						  stream
							  nextPutAll: '
    VDMPad._storage = new Map();
    VDMPad.storage = {
        getItem: (k) => VDMPad._storage.get(k) ?? null,
        setItem: (k, v) => VDMPad._storage.set(k, v),
        removeItem: (k) => VDMPad._storage.delete(k),
        clear: () => VDMPad._storage.clear(),
    };
    VDMPad.vip = "';
							  nextPutAll: aString;
							  nextPutAll: '";
' ] ]
]

{ #category : 'request handling-javascript' }
VDMPad >> VDMPadIDE [

	^ '
import { EditorView, basicSetup } from "https://esm.sh/codemirror";
import { EditorState, StateField, StateEffect } from "https://esm.sh/@codemirror/state";
import { defaultKeymap, history, historyKeymap } from "https://esm.sh/@codemirror/commands";
import { keymap, drawSelection, highlightActiveLine, Decoration, lineNumbers, highlightActiveLineGutter } from "https://esm.sh/@codemirror/view";
import { StreamLanguage, HighlightStyle, syntaxHighlighting } from "https://esm.sh/@codemirror/language";
import { tags as t } from "https://esm.sh/@lezer/highlight";
import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs";

EditorView.prototype.getValue = function() {
  return this.state.doc.toString();
};
EditorView.prototype.setValue = function(text) {
  this.dispatch({
    changes: { from: 0, to: this.state.doc.length, insert: text }
  });
};
const vdmErrorEffect = StateEffect.define();
const vdmErrorField = StateField.define({
  create() { return Decoration.none; },
  update(underlines, tr) {
    underlines = underlines.map(tr.changes);
    
    for (let e of tr.effects) {
      if (e.is(vdmErrorEffect)) {
        underlines = Decoration.set([e.value]);
      }
    }
    return underlines;
  },
  provide: f => EditorView.decorations.from(f)
});
EditorView.prototype.markError = function(pos) {
  var from = pos;
  var to = this.state.doc.length;
  let word = this.state.wordAt(pos);
  if (word) {
    from = word.from;
    to = word.to;
  }
  const deco = Decoration.mark({ class: "cm-vdm-error-underline" }).range(from, to);
  this.dispatch({
    effects: vdmErrorEffect.of(deco),
  });
};
EditorView.prototype.clearErrors = function() {
  this.dispatch({
    effects: vdmErrorEffect.of(Decoration.none) 
  });
};

const vdmMode = {
    token: (stream) => {
        if (stream.eatSpace()) return null;
        if (stream.match(/--.*/) || stream.match(/\/\/.*/)) return "comment";
        if (stream.match(/^(bool|char|inmap|int|map|nat1|nat|rat|real|seq1|seq|set1|set|token)\b/)) return "modifier";
        if (stream.match(/^(\#act|\#active|\#fin|\#req|\#waiting|abs|all|always|and|as|async|atomic|keyword|be|by|card|cases|class|comp|compose|conc|cycles|dcl|def|definitions|dinter|div|dlmodule|do|dom|dunion|duration|elems|else|elseif|end|error|errs|exists1|exists|exit|exports|ext|floor|for|forall|from|functions|hd|if|in set|in setq|in|inds|instance|inter|imports|init|inv|inverse|iota|is|isofbaseclass|isofclass|lambda|len|let|measure|merge|mod|module|mu|munion|mutex|new|not|of|old|operations|or|others|per|periodic|post|power|pre|private|protected|psubset|public|rd|rem|renamed|responsibility|return|reverse|rng|samebaseclass|sameclass|self|skip|specified|st|start|startlist|state|struct|subclass|subset|sync|system|then|thread|threadid|time|tixe|tl|to|traces|trap|types|union|uselib|values|variables|while|with|wr|yet|RESULT)\b/)) return "keyword";
        if (stream.match(/\^|=>|<=>|<>|<=|>=|<-|:->|:>|-|\+|\*|\/|=|\||&|\./)) return "operator";
        if (stream.match(/^(\`|:=|==>|==|\|->|->|:)/)) return "keyword";
        if (stream.match(/^(mk_|is_|init_|pre_|post_|inv_)/)) return "keyword";
        if (stream.match(/^"(\\.|[^"])*"/)) return "atom";
        if (stream.match(/^\d+(\.\d+)?/)) return "atom";
        if (stream.match(/^(false|nil|true|undefined)\b/)) return "atom";
        if (stream.match(/^(\{\}|\[\]|\{\|->\})\b/)) return "atom";
        var c = stream.next();
        if (c && (c.codePointAt(0) < 0x100 ?
                /[\p{Ll}\p{Lm}\p{Lo}\p{Lt}\p{Lu}$]/u:
                /[^\p{Cc}\p{Zl}\p{Zp}\p{Zs}\p{Cs}\p{Cn}\p{Nd}\p{Pc}]/u).test(c)) {
            stream.eatWhile((nextChar) => ((nextChar.codePointAt(0) < 0x0100 
                ? /[\p{Ll}\p{Lm}\p{Lo}\p{Lt}\p{Lu}\p{Nd}$_'']/u 
                : /[^\p{Cc}\p{Zl}\p{Zp}\p{Zs}\p{Cs}\p{Cn}]/u).test(nextChar)));
            return "variableName"
        };
        return null;
    }
};
const vdmHighlightStyle = HighlightStyle.define([
    { tag: t.keyword, color: "#500", fontWeight: "bold" },
    { tag: t.operator, color: "#000"},
    { tag: t.modifier, color: "#0aa" },
    { tag: t.variableName, color: "#448"},
    { tag: t.atom, color: "#880" },
    { tag: t.comment, color: "#888", fontStyle: "italic" },
]);

mermaid.initialize({ 
  startOnLoad: false,
  useMaxWidth: false,
  theme: "default",
  securityLevel: "loose",
  fontFamily: "Helvetica",
  fontSize: "0.8rem",
  sequenceNumberColor: "#333"
});

VDMPad.visualEnabled = false;
VDMPad.unittestEnabled = false;
VDMPad.unittestRunning = false;
VDMPad.sequenceDiagramEnabled = false;
VDMPad.stateDiagramEnabled = false;
VDMPad.protoTestcase = null;
VDMPad.testcases = [];
VDMPad.currentSource = null;

VDMPad.enableUnittest = function () {
    if (VDMPad.storage) {
        VDMPad.storage.setItem("Config`unittestEnabled", "true");
    }
    VDMPad.unittestEnabled = true;
    VDMPad.unittestCheckbox.checked = true;
    if (VDMPad.protoTestcase != null) {
        VDMPad.enableMakeItATestcaseButton();
    }
    VDMPad.startTests();
};
VDMPad.disableUnittest = function () {
    if (VDMPad.storage) {
        VDMPad.storage.setItem("Config`unittestEnabled", "false");
    }
    VDMPad.unittestEnabled = false;
    VDMPad.unittestCheckbox.checked = false;
    VDMPad.disableMakeItATestcaseButton();
    while (VDMPad.unittestNode.firstChild)
        VDMPad.unittestNode.removeChild(VDMPad.unittestNode.firstChild);
};
VDMPad.toggleUnittest = function () {
    if (VDMPad.unittestEnabled)
        VDMPad.disableUnittest();
    else
        VDMPad.enableUnittest();
};

VDMPad.enableVisual = function () {
    if (VDMPad.storage) {
        VDMPad.storage.setItem("Config`visualEnabled", "true");
    }
    VDMPad.visualEnabled = true;
    VDMPad.visualCheckbox.checked = true;
    VDMPad.loadFromStorage();
};

VDMPad.disableVisual = function () {
    if (VDMPad.storage) {
        VDMPad.storage.setItem("Config`visualEnabled", "false");
    }
    VDMPad.visualEnabled = false;
    VDMPad.visualCheckbox.checked = false;
    VDMPad.loadFromStorage();
};

VDMPad.toggleVisual = function () {
    if (VDMPad.visualEnabled)
        VDMPad.disableVisual();
    else
        VDMPad.enableVisual();
};

VDMPad.enableSequenceDiagram = function () {
    if (VDMPad.storage) {
        VDMPad.storage.setItem("Config`sequenceDiagramEnabled", "true");
    }
    VDMPad.sequenceDiagramEnabled = true;
    VDMPad.sequenceDiagramCheckbox.checked = true;
    VDMPad.loadFromStorage();
};

VDMPad.disableSequenceDiagram = function () {
    if (VDMPad.storage) {
        VDMPad.storage.setItem("Config`sequenceDiagramEnabled", "false");
    }
    VDMPad.sequenceDiagramEnabled = false;
    VDMPad.sequenceDiagramCheckbox.checked = false;
    VDMPad.loadFromStorage();
};

VDMPad.toggleSequenceDiagram = function () {
    if (VDMPad.sequenceDiagramEnabled)
        VDMPad.disableSequenceDiagram();
    else
        VDMPad.enableSequenceDiagram();
};

VDMPad.enableStateDiagram = function () {
    if (VDMPad.storage) {
        VDMPad.storage.setItem("Config`stateDiagramEnabled", "true");
    }
    VDMPad.stateDiagramEnabled = true;
    VDMPad.stateDiagramCheckbox.checked = true;
    VDMPad.loadFromStorage();
};

VDMPad.disableStateDiagram = function () {
    if (VDMPad.storage) {
        VDMPad.storage.setItem("Config`stateDiagramEnabled", "false");
    }
    VDMPad.stateDiagramEnabled = false;
    VDMPad.stateDiagramCheckbox.checked = false;
    VDMPad.loadFromStorage();
};

VDMPad.toggleStateDiagram = function () {
    if (VDMPad.stateDiagramEnabled)
        VDMPad.disableStateDiagram();
    else
        VDMPad.enableStateDiagram();
};

VDMPad.enableMakeItATestcaseButton = function () {
    VDMPad.makeItATestcaseButtonNode.style.visibility = "visible";
}
VDMPad.disableMakeItATestcaseButton = function () {
    VDMPad.makeItATestcaseButtonNode.style.visibility = "hidden";
}

VDMPad.addTestcase = function() {
    if (VDMPad.protoTestcase != null) {
        VDMPad.testcases.push(VDMPad.protoTestcase);
    }
    if (VDMPad.storage) {
        var snapshot = JSON.parse(VDMPad.storage.getItem("`lastSnapshot"));
        snapshot.testcases = VDMPad.testcases;
        VDMPad.storage.setItem("`lastSnapshot", JSON.stringify(snapshot));
    }
    VDMPad.disableMakeItATestcaseButton();
    VDMPad.startTests();
}

VDMPad.testcase_index = -1;
VDMPad.startTests = function () {
    if (VDMPad.unittestEnabled && !VDMPad.unittestRunning) {
        VDMPad.unittestRunning = true;
        while (VDMPad.unittestNode.firstChild)
            VDMPad.unittestNode.removeChild(VDMPad.unittestNode.firstChild);
        VDMPad.testcase_index = 0;
        window.setTimeout(VDMPad.runOneTestcase,0);
    }
};

VDMPad.runOneTestcase = function() {
    var testcase = VDMPad.testcases[VDMPad.testcase_index];
    if (VDMPad.unittestEnabled && testcase && VDMPad.currentSource != null) {
        var id = {};
        testcase["id"] = id;
        testcase["source"] = VDMPad.currentSource;
        var req = new XMLHttpRequest();
        req.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200 && VDMPad.unittestEnabled) {
                var result = JSON.parse(this.responseText);
                var okNode = document.createElement("div");
                okNode.style.fontSize = "9pt";
                okNode.style.cursor = "pointer";
                if (result == true) {
                    var message = "OK: "+testcase["expression"];
                    okNode.style.color = "green";
                    okNode.textContent = message;
                    okNode.innerText = message;
                } else {
                    var message = "FAILED: "+testcase["expression"]+" => "+result;
                    okNode.style.color = "red";
                    okNode.textContent = message;
                    okNode.innerText = message;
                }
                var testcase_print = [];
                for (var key in testcase) {
                    if (key == "expression" || key == "value") {
                        testcase_print[key] = key+" : "+testcase[key];
                    }
                    if (key == "prestates" || key == "poststates") {
                        testcase_print[key] = key+" : "+JSON.stringify(testcase[key]);
                    }
                }
                okNode.title = testcase_print["prestates"]+"\n"+ testcase_print["expression"]+"\n"+ testcase_print["value"]+"\n"+ testcase_print["poststates"];
                VDMPad.unittestNode.appendChild(okNode);
                VDMPad.testcase_index = VDMPad.testcase_index + 1;
                okNode.onclick = function () {
                    var testcaseNode = document.createElement("pre");
                    testcaseNode.style.color = "black";
                    testcaseNode.style.marginLeft = "20px";
                    testcaseNode.innerText = okNode.title;
                    testcaseNode.textContent = okNode.title;
                    okNode.appendChild(testcaseNode);
                    okNode.onclick = undefined;
                    okNode.style.cursor = "default";
                    var delNode = document.createElement("div");
                    delNode.style.backgroundColor = "black";
                    delNode.style.color = "white";
                    delNode.style.width = "100px";
                    delNode.style.textAlign = "center";
                    delNode.style.border= "border: solid 2px black";
                    delNode.innerText = "delete";
                    delNode.textContent = "delete";
                    delNode.style.cursor = "pointer";
                    var deleteTestcase = function () {
                        VDMPad.testcases = VDMPad.testcases.filter(function(n) {return n["id"] != id;});
                        okNode.parentNode.removeChild(okNode);
                        if (VDMPad.storage) {
                            var snapshot = JSON.parse(VDMPad.storage.getItem("`lastSnapshot"));
                            snapshot.testcases = VDMPad.testcases;
                            VDMPad.storage.setItem("`lastSnapshot", JSON.stringify(snapshot));
                        }
                    };
                    delNode.onclick= deleteTestcase;
                    testcaseNode.appendChild(delNode);
                };
                window.setTimeout(VDMPad.runOneTestcase,0);
            }
        };
        var queryOptions = "?";
        req.open("POST", "/test"+queryOptions.substring(0,queryOptions.length-1));
        req.setRequestHeader("Content-Type", "application/json");
        req.send(JSON.stringify(testcase));
    } else {
        VDMPad.testcase_index = -1;
        VDMPad.unittestRunning = false;
    }
}

VDMPad.init = function () {
    VDMPad.messageNode.style.color = "white";
    var value = VDMPad.valueNode.value;
    var req = new XMLHttpRequest();
    req.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var resultJson = JSON.parse(this.responseText);
            resultJson.expression = VDMPad.expressionView.getValue();
            resultJson.value = value;
            resultJson.testcases = VDMPad.testcases;
            VDMPad.loadJson(JSON.stringify(resultJson));
            VDMPad.messageNode.style.color = "black";
            VDMPad.disableMakeItATestcaseButton();
        }
    };
    var queryOptions = "?";
    if (VDMPad.visualEnabled) {
        queryOptions += "visual=&";
    }
    if (VDMPad.unittestEnabled) {
        queryOptions += "unittest=&";
    }
    req.open("POST", "/eval"+queryOptions.substring(0,queryOptions.length-1));
    req.setRequestHeader("Content-Type", "application/json");
    var query = {};
    query.source=VDMPad.sourceView.getValue();
    query.expression="";
    query.value=value;
    query.message=VDMPad.messageNode.textElement || VDMPad.messageNode.textContent;
    req.send(JSON.stringify(query));
};

VDMPad.format = function () {
    VDMPad.messageNode.style.color = "white";
    var value = VDMPad.valueNode.value;
    var req = new XMLHttpRequest();
    req.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var resultJson = JSON.parse(this.responseText);
            resultJson.expression = VDMPad.expressionView.getValue();
            resultJson.value = value;
            resultJson.testcases = VDMPad.testcases;
            VDMPad.loadJson(JSON.stringify(resultJson));
            VDMPad.messageNode.style.color = "black";
            VDMPad.disableMakeItATestcaseButton();
        }
    };
    var queryOptions = "?";
    if (VDMPad.visualEnabled) {
        queryOptions += "visual=&";
    }
    if (VDMPad.unittestEnabled) {
        queryOptions += "unittest=&";
    }
    req.open("POST", "/format"+queryOptions.substring(0,queryOptions.length-1));
    req.setRequestHeader("Content-Type", "application/json");
    var query = {};
    query.source=VDMPad.sourceView.getValue();
    query.expression="";
    query.value=value;
    query.message=VDMPad.messageNode.textElement || VDMPad.messageNode.textContent;
    var inputs = document.getElementsByTagName("textarea");
    for (var inputIndex = 0; inputIndex < inputs.length; inputIndex++) {
        var input = inputs[inputIndex];
        if (input.id && input.id.indexOf("`") >= 0) {
            query[input.id]=input.value;
        }
    }
    req.send(JSON.stringify(query));
};

VDMPad.eval = function () {
    VDMPad.disableMakeItATestcaseButton();
    var protoTestcase = {};
    VDMPad.valueNode.style.color = "white";
    VDMPad.messageNode.style.color = "white";
    var req = new XMLHttpRequest();
    var selection = "";
    var view = VDMPad.expressionView;
    if (view.state.selection.main.empty) {
        const { state } = view;
        const pos = state.selection.main.head;
        const line = state.doc.lineAt(pos);
        view.dispatch({
            selection: { anchor: line.from, head: line.to },
            scrollIntoView: true
        });
    }
    var anchor = view.state.selection.main.from;
    var head = view.state.selection.main.to;
    req.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var resultJson = JSON.parse(this.responseText);
            resultJson.expression = view.getValue();
            resultJson.testcases = VDMPad.testcases;
            protoTestcase.value = resultJson.value;
            protoTestcase.poststates = {};
            for (var key in resultJson) {
                if (key.indexOf("`") >= 0) {
                    protoTestcase.poststates[key] = resultJson[key];
                }
            }
            VDMPad.epilogAppend(protoTestcase);
            resultJson.EpiLog = VDMPad.EpiLog;
            VDMPad.loadJson(JSON.stringify(resultJson));
            view.state.selection.main.from = anchor;
            view.state.selection.main.to = head;
            VDMPad.valueNode.style.color = "black";
            VDMPad.messageNode.style.color = "black";
            VDMPad.protoTestcase = protoTestcase;
            if (VDMPad.unittestEnabled) VDMPad.enableMakeItATestcaseButton();
            VDMPad.startTests();
        }
    };
    var queryOptions = "?";
    if (VDMPad.sequenceDiagramEnabled) {
        queryOptions += "sequenceDiagram=&";
    }
    if (VDMPad.stateDiagramEnabled) {
        queryOptions += "stateDiagram=&";
    }
    req.open("POST", "/eval"+queryOptions.substring(0,queryOptions.length-1));
    req.setRequestHeader("Content-Type", "application/json");
    var expression = view.state.sliceDoc(anchor, head);
    if (!expression)
        expression = VDMPad.expressionView.getValue();
    protoTestcase["source"] = VDMPad.sourceView.getValue();
    protoTestcase["expression"] = expression;
    protoTestcase["prestates"] = {};
    var query = {};
    query.source=VDMPad.sourceView.getValue();
    query.expression=expression;
    query.value=VDMPad.valueNode.value;
    query.message=VDMPad.messageNode.textElement || VDMPad.messageNode.textContent;
    var inputs = document.getElementsByTagName("textarea");
    for (var inputIndex = 0; inputIndex < inputs.length; inputIndex++) {
        var input = inputs[inputIndex];
        if (input.id && input.id.indexOf("`") >= 0) {
            query[input.id]=input.value;
            protoTestcase["prestates"][input.id] = input.value;
        }
    }
    req.send(JSON.stringify(query));
};

VDMPad.loadJson = function(snapshotString) {
    var result;
    try {
        result = JSON.parse(snapshotString);
    } catch (e) {
    }
    if (!result)
        result = {source: "", expression: "", value: "", message: ""};
    if (!result.testcases) {
        result.testcases = [];
    }
    if (VDMPad.storage)
        VDMPad.storage.setItem("`lastSnapshot", JSON.stringify(result));
    if ("EpiLog" in result) 
        VDMPad.EpiLog = result.EpiLog;
    VDMPad.testcases = result.testcases;
    VDMPad.sourceView.setValue(result.source);
    if (result.position) { 
        VDMPad.sourceView.markError(result.position);
    }
    VDMPad.currentSource = result.source;
    VDMPad.expressionView.setValue(result.expression);
    VDMPad.valueNode.value = result.value;
    while (VDMPad.valueVisualNode.firstChild)
        VDMPad.valueVisualNode.removeChild(VDMPad.valueVisualNode.firstChild);
    if (VDMPad.visualEnabled) {
        var visualNode = document.createElement("div");
        VDMPad.valueVisualNode.appendChild(visualNode);
        VDMPad.vdm2html(result.value, visualNode);
    }
    VDMPad.messageNode.innerText = result.message;
    var states = [];
    for (var key in result)
        if (key.indexOf("`") >= 0)
            states.push(key);
    states.sort();
    var lastModuleName = "";
    var moduleNode = null;
    while (VDMPad.stateNode.firstChild)
        VDMPad.stateNode.removeChild(VDMPad.stateNode.firstChild);
    for (var varIndex = 0; varIndex < states.length; varIndex++) {
        var fullname = states[varIndex];
        var backquoteIndex = fullname.indexOf("`");
        var moduleName = fullname.substring(0, backquoteIndex);
        var variableName = fullname.substring(backquoteIndex+1);
        if (moduleName != lastModuleName) {
            lastModuleName = moduleName;
            if (moduleNode != null) {
                VDMPad.stateNode.appendChild(moduleNode);
            }
            moduleNode = document.createElement("div");
            moduleNode.style.marginLeft = "0px";
            moduleNode.style.border =  "dotted 1px black";
            moduleNode.style.margin =  "10px 10px 0px 0px";
            moduleNode.innerText = moduleName;
            moduleNode.textContent = moduleName;
        }
        var variableNode = document.createElement("div");
        variableNode.style.marginLeft = "40px";
        variableNode.innerText = variableName;
        variableNode.textContent = variableName;
        moduleNode.appendChild(variableNode);
        var valueNode = document.createElement("textarea");
        valueNode.id = fullname;
        valueNode.setAttribute("name", fullname);
        valueNode.value = result[fullname];
        valueNode.style.cssText="resize: vertical; font-family: sans-serif";
        valueNode.setAttribute("cols", 40);
        valueNode.setAttribute("rows", result[fullname].length / 40 + 1);
        var valueDivNode = document.createElement("div");
        valueDivNode.style.cssText="float: right";
        valueDivNode.appendChild(valueNode);
        variableNode.appendChild(valueDivNode);
        valueDivNode = document.createElement("div");
        valueDivNode.style.cssText="clear: right";
        variableNode.appendChild(valueDivNode);
        if (VDMPad.visualEnabled) {
            var visualNode = document.createElement("div");
            variableNode.appendChild(visualNode);
            VDMPad.vdm2html(result[fullname], visualNode);
        }
    }
    if (moduleNode != null)
        VDMPad.stateNode.appendChild(moduleNode);
    if (VDMPad.sequenceDiagramEnabled && result.sequenceDiagram) {
        VDMPad.sequenceDiagramScript = result.sequenceDiagram;
        VDMPad.sequenceDiagramSectionNode.style.display = "block";
        VDMPad.renderMermaid(VDMPad.sequenceDiagramNode, result.sequenceDiagram);
    } else { 
        VDMPad.sequenceDiagramSectionNode.style.display = "none";
    }

    if (VDMPad.stateDiagramEnabled && result.stateDiagram) { 
        VDMPad.stateDiagramScript = result.stateDiagram;
        VDMPad.stateDiagramSectionNode.style.display = "block";
        VDMPad.renderMermaid(VDMPad.stateDiagramNode, result.stateDiagram);
    } else { 
        VDMPad.stateDiagramSectionNode.style.display = "none";
    }
    VDMPad.startTests();
};

VDMPad.vdm2html = function(vdm, node) {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function () {
         if (this.readyState == 4 && this.status == 200) {
             node.innerHTML = this.responseText;
             node.htmlContent = this.responseText;
         }
     };
    req.open("POST", "/vdm2html");
    req.send(vdm);
};

VDMPad.load = function (name) {
    VDMPad.unittestRunning = false;
    VDMPad.protoTestcase = null;
    VDMPad.testcases = [];
    VDMPad.loadJson(VDMPad.storage.getItem(name));
    if (name != "`lastSnapshot") {
        VDMPad.currentSpec = name;
        if (VDMPad.storage)
            VDMPad.storage.setItem("`currentSpec", name);
        VDMPad.updateFileItems();
    }
}

VDMPad.acceptDroppedFile = function (event) {
    if (event.dataTransfer && event.dataTransfer.files) {
        var reader = new FileReader();
        reader.onload = function(e) {
            VDMPad.loadJson(e.target.result);
        };
        reader.readAsText(event.dataTransfer.files[0], "utf-8");
    } else {
        alert("Your browser does not support file drag&drop.");
    }
    if (event.stopPropagation)
        event.stopPropagation();
    if (event.preventDefault)
        event.preventDefault();
    event.cancelBubble = true;
    return false;
}

if (VDMPad.vip) { 
  const base64 = VDMPad.vip.replace(/-/g, "+").replace(/_/g, "/");
  const binary = atob(base64);
  const buffer = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) {
    buffer[i] = binary.charCodeAt(i);
  }
  const stream = new Blob([buffer]).stream();
  const decompressedStream = stream.pipeThrough(new DecompressionStream("deflate"));
  const response = new Response(decompressedStream);
  const json = await response.text();
  VDMPad.storage.setItem("`lastSnapshot", json);
};

VDMPad.vipLink = async function() { 
  try {
    const snapshot = JSON.parse(VDMPad.storage.getItem("`lastSnapshot"));
    snapshot.EpiLog = [];
    const stream = new Blob([JSON.stringify(snapshot)]).stream().pipeThrough(new CompressionStream("deflate"));
    const compressedBuffer = await new Response(stream).arrayBuffer();
    const vip = await btoa(String.fromCharCode(...new Uint8Array(compressedBuffer)))
      .replace(/\+/g, "-")
      .replace(/\//g, "_")
      .replace(/=+$/, "");
    return window.location.origin+"/?vip="+vip;
  } catch (err) {
  }
};

VDMPad.copyVipLink = async function() { 
  try {
    const vip = await VDMPad.vipLink();
    await navigator.clipboard.writeText(vip);
    return vip;
  } catch (err) {
  }
};
VDMPad.showVipQR = async function () {
    const dialog = document.getElementById("vipQRDialog");
    while (dialog.firstChild)
            dialog.removeChild(dialog.firstChild);
    const qrcode = new QRCode(dialog, {
        width: 512,
        height: 512,
        colorDark : "#000000",
        colorLight : "#ffffff",
        correctLevel : QRCode.CorrectLevel.H // L, M, Q, H
    });
    qrcode.makeCode(await VDMPad.vipLink());
    dialog.addEventListener("click", (e) => {dialog.close();});
    dialog.showModal();
};

VDMPad.saveAs= function (name, export_flag) {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            if (VDMPad.storage) {
                VDMPad.storage.setItem(name, this.responseText);
                VDMPad.storage.setItem("`lastSnapshot", this.responseText);
                VDMPad.storage.setItem("`currentSpec", name);
                var files = JSON.parse(VDMPad.storage.getItem("`files"));
                if (files.indexOf(name) < 0) {
                    files.push(name);
                    files.sort();
                    VDMPad.storage.setItem("`files", JSON.stringify(files));
                }
            }
            if (export_flag) {
                var blob = new Blob([this.responseText], {type: "application/json;charset=utf-8"});
                saveAs(blob, name+".vdmpad");
            }
            VDMPad.currentSpec = name;
            VDMPad.updateFileItems();
        }
    };
    req.open("POST", "/id");
    req.setRequestHeader("Content-Type", "application/json");
    var query = {};
    query.source=VDMPad.sourceView.getValue();
    query.expression=VDMPad.expressionView.getValue();
    query.value=VDMPad.valueNode.value;
    query.message=VDMPad.messageNode.textElement || VDMPad.messageNode.textContent || "";
    var inputs = document.getElementsByTagName("textarea");
    for (var inputIndex = 0; inputIndex < inputs.length; inputIndex++) {
        var input = inputs[inputIndex];
        if (input.id && input.id.indexOf("`") >= 0) {
            query[input.id]=input.value;
        }
    }
    req.send(JSON.stringify(query));
};

VDMPad.remove = function (name) {
    var files = VDMPad.files();
    var index = files.indexOf(name);
    if (index >= 0) {
        files.splice(index, 1);
        if (VDMPad.storage)
            VDMPad.storage.setItem("`files", JSON.stringify(files));
    }
    if (VDMPad.storage)
        VDMPad.storage.removeItem(name);
    VDMPad.updateFileItems();
};

VDMPad.loadFromStorage = function () {
    if (VDMPad.storage) {
        VDMPad.unittestCheckbox.checked = VDMPad.unittestEnabled = VDMPad.storage.getItem("Config`unittestEnabled") == "true";
        VDMPad.visualCheckbox.checked = VDMPad.visualEnabled = VDMPad.storage.getItem("Config`visualEnabled") == "true";
        VDMPad.sequenceDiagramCheckbox.checked = VDMPad.sequenceDiagramEnabled = VDMPad.storage.getItem("Config`sequenceDiagramEnabled") == "true";
        VDMPad.stateDiagramCheckbox.checked = VDMPad.stateDiagramEnabled = VDMPad.storage.getItem("Config`stateDiagramEnabled") == "true";
        if (!VDMPad.storage.getItem("`lastSnapshot")) {
            var counter = {};
            counter["source"] = "module Counter\nexports all\ndefinitions\nstate counter of\n\tcount : nat\n\tinit s == s = mk_counter(0)\nend\noperations\n\tstep : () ==> nat\n\tstep() == (count := count + 1; return count);\nend Counter\n";
            counter["Counter`count"] = "1002";
            counter["expression"] = "Counter`step()";
            counter["value"] = "";
            counter["message"] = "";
            counter["testcases"] = [];
            VDMPad.storage.setItem("example:Counter", JSON.stringify(counter));
            VDMPad.storage.setItem("`files", JSON.stringify(["example:Counter"]));
            VDMPad.storage.setItem("`lastSnapshot", VDMPad.storage.getItem("lastSnapshot"));
            VDMPad.storage.removeItem("lastSnapshot");
        }
        VDMPad.load("`lastSnapshot");
        if (VDMPad.storage.getItem("`currentSpec") == undefined) {
            VDMPad.storage.setItem("`currentSpec", "");
        }          
        VDMPad.currentSpec = VDMPad.storage.getItem("`currentSpec");
    }
};

VDMPad.renderMermaid = async function(node, script) { 
  node.removeAttribute("data-processed");
  node.innerHTML = script;
  try {
    await mermaid.run({
      nodes: [node]
    });
  } catch (error) {
    console.error("Mermaid rendering failed:", error);
    node.innerText = "Diagram Error";
  }
};

VDMPad.copySequenceDiagram = async function () {
  const icon = event.target;
  try {
    await navigator.clipboard.writeText(VDMPad.sequenceDiagramScript);
    icon.style.backgroundColor = "#ccc";
    setTimeout(() => {icon.style.background = ""}, 200);
  } catch (err) {
  }
};

VDMPad.copyStateDiagram = async function () {
  try {
    await navigator.clipboard.writeText(VDMPad.stateDiagramScript);
    event.target.style.backgroundColor = "#ccc";
    setTimeout(() => {event.target.style.background = ""}, 200);
  } catch (err) {
  }
};
VDMPad.setupIdeNodes = function () {
    VDMPad.node = document.getElementById("all");
    VDMPad.unittestCheckbox = document.getElementById("unittestCheckbox");
    VDMPad.unittestCheckbox.addEventListener("click", ()=>VDMPad.toggleUnittest());
    VDMPad.visualCheckbox = document.getElementById("visualCheckbox");
    VDMPad.visualCheckbox.addEventListener("click", ()=>VDMPad.toggleVisual());
    VDMPad.sequenceDiagramCheckbox = document.getElementById("sequenceDiagramCheckbox");
    VDMPad.sequenceDiagramCheckbox.addEventListener("click", ()=>VDMPad.toggleSequenceDiagram());
    VDMPad.stateDiagramCheckbox = document.getElementById("stateDiagramCheckbox");
    VDMPad.stateDiagramCheckbox.addEventListener("click", ()=>VDMPad.toggleStateDiagram());
    VDMPad.epilogButton = document.getElementById("epilogButton");
    VDMPad.epilogButton.turnOn = function () {
        VDMPad.epilogButton.style.color = "white";
        VDMPad.epilogButton.style.backgroundColor = "black";
        VDMPad.epilogButton.style.borderColor = "white";
    };
    VDMPad.epilogButton.turnOff = function () {
        VDMPad.epilogButton.style.color = "black";
        VDMPad.epilogButton.style.backgroundColor = "white";
        VDMPad.epilogButton.style.borderColor = "black";
    };
    VDMPad.epilogButton.addEventListener("click", ()=>VDMPad.toggleEpilog());
    VDMPad.mainNode = document.getElementById("main");
    VDMPad.sourceView = new EditorView({
        state: EditorState.create({
            doc: "",
            extensions: [
                basicSetup,
                StreamLanguage.define(vdmMode),
                syntaxHighlighting(vdmHighlightStyle),
                vdmErrorField,
                EditorView.theme({"&": { height: "400px", backgroundColor: "#ffffff"}, ".cm-scroller": { overflow: "auto" }})]}),
        parent: document.getElementById("source")});
    VDMPad.expressionView = new EditorView({
        state: EditorState.create({
            doc: "",
            extensions: [
              StreamLanguage.define(vdmMode),
              syntaxHighlighting(vdmHighlightStyle),
              vdmErrorField,
              highlightActiveLine(),
              drawSelection(),
              history(),
              keymap.of([...defaultKeymap, ...historyKeymap]),
              EditorView.lineWrapping,
              EditorView.theme({"&": { height: "150px", backgroundColor: "#ffffff"}, ".cm-scroller": { overflow: "auto" }})]}),
        parent: document.getElementById("expression")});
    VDMPad.stateNode = document.getElementById("states");
    VDMPad.valueNode = document.getElementById("value");
    VDMPad.valueVisualNode = document.getElementById("valueVisual");
    VDMPad.messageNode = document.getElementById("message");
    VDMPad.sequenceDiagramSectionNode = document.getElementById("sequenceDiagramSection");
    VDMPad.sequenceDiagramNode = document.getElementById("sequenceDiagram");
    VDMPad.stateDiagramNode = document.getElementById("stateDiagram");
    VDMPad.stateDiagramSectionNode = document.getElementById("stateDiagramSection");
    VDMPad.unittestNode = document.getElementById("unittest");
    VDMPad.makeItATestcaseButtonNode = document.getElementById("addTestcaseButton");
    document.documentElement.addEventListener("drop", (event) => {
        event.preventDefault();
        VDMPad.acceptDroppedFile(event);
    });
    document.documentElement.addEventListener("dragenter", (event) => {
        event.preventDefault();
    });
    document.documentElement.addEventListener("dragover", (event) => {
        event.preventDefault();
        event.dataTransfer.dropEffect = ''copy'';
    });
    document.getElementById("copyVipButton").addEventListener("click", ()=>VDMPad.copyVipLink());
    document.getElementById("showVipQRButton").addEventListener("click", ()=>VDMPad.showVipQR());
    document.getElementById("formatButton").addEventListener("click", () => {VDMPad.format();});
    document.getElementById("initButton").addEventListener("click", () => {VDMPad.init();});
    document.getElementById("evalButton").addEventListener("click", () => {VDMPad.eval();});
    document.getElementById("addTestcaseButton").addEventListener("click", () => {VDMPad.addTestcase();});
    document.getElementById("copySequenceDiagramButton").addEventListener("click", () => {VDMPad.copySequenceDiagram()});
    document.getElementById("copyStateDiagramButton").addEventListener("click", () => {VDMPad.copyStateDiagram()});
    
};
' withUnixLineEndings
]

{ #category : 'request handling-javascript' }
VDMPad >> VDMPadMenu [

	^ '
VDMPad.fileItemsExpanded = false;
VDMPad.currentFileItemNode = null;

VDMPad.files = function () {
    if (VDMPad.storage) {
       var files = VDMPad.storage.getItem("`files");
       if (files) {
          try {
              return JSON.parse(files);
          } catch (e) { };
      }
      files = [];
      for (var i = 0; i < VDMPad.storage.length; i++) {
        var file = VDMPad.storage.key(i);
        if (file[0] != ''`'' && file.substr(0, 7) != "Config`") files.push(file);
      }
      VDMPad.storage.setItem("`files", JSON.stringify(files));
      return files;
   }
    return [];
};

VDMPad.setupMenuNodes = function () {
    VDMPad.menuNode = document.getElementById("menu");
    VDMPad.rootMenuNode = document.getElementById("root_menu");
    VDMPad.rootMenuIconNode = document.getElementById("rootMenuIcon");
    VDMPad.fileItemsNode = document.getElementById("file_items");
    VDMPad.rootMenuIconNode.onmouseover = function () {
        VDMPad.expandFileItems();
    };
    VDMPad.mainNode.onmouseover = function () {
        VDMPad.currentFileItemNode = null;
        if (!VDMPad.fileItemsExpanded)
            VDMPad.shrinkFileItems();
    };
    VDMPad.rootMenuIconNode.onclick = function () {
        if (VDMPad.fileItemsExpanded) {
            VDMPad.rootMenuIconNode.src = "/rootMenuOff.png";
            VDMPad.fileItemsExpanded = false;
        } else {
            VDMPad.rootMenuIconNode.src = "/rootMenuOn.png";
            VDMPad.fileItemsExpanded = true;
        }
    };
};

VDMPad.updateFileItems = function () {
    if (VDMPad.fileItemsNode.firstChild) {
        while (VDMPad.fileItemsNode.firstChild)
            VDMPad.fileItemsNode.removeChild(VDMPad.fileItemsNode.firstChild);
        VDMPad.node.style.width = "1200px";
        VDMPad.menuNode.style.width = "300px";
        var files = VDMPad.files();
        for (var i = 0; i < files.length; i++)
            VDMPad.fileItemsNode.appendChild(VDMPad.createFileNode(files[i]));
        VDMPad.fileItemsNode.appendChild(VDMPad.createSaveAsInputNode());
    }
};

VDMPad.expandFileItems = function () {
    if (!VDMPad.fileItemsNode.firstChild) {
        VDMPad.rootMenuNode.style.display = "block";
        VDMPad.node.style.width = "1100px";
        VDMPad.menuNode.style.width = "300px";
        var files = VDMPad.files();
        for (var i = 0; i < files.length; i++)
            VDMPad.fileItemsNode.appendChild(VDMPad.createFileNode(files[i]));
        VDMPad.fileItemsNode.appendChild(VDMPad.createSaveAsInputNode());
    }
};

VDMPad.shrinkFileItems = function () {
    VDMPad.rootMenuNode.style.display = "none";
    if (VDMPad.fileItemsNode.firstChild) {
        while (VDMPad.fileItemsNode.firstChild)
            VDMPad.fileItemsNode.removeChild(VDMPad.fileItemsNode.firstChild);
        VDMPad.menuNode.style.width = "50px";
        VDMPad.node.style.width = "850px";
    }
};

VDMPad.createFileNode = function (name) {
    var node = document.createElement("div");
    var labelNode = document.createElement("div");
    var buttonsNode = document.createElement("div");
    var loadNode = document.createElement("img");
    var saveNode = document.createElement("img");
    var exportNode = document.createElement("img");
    var deleteNode = document.createElement("img");
    var defaultBackgroundColor = "#ffffff";
    if (VDMPad.currentSpec == name)
        defaultBackgroundColor = "#e0e0e0";
    node.id = name;
    node.marginTop = "2px";
    node.marginBottom = "2px";
    node.marginLeft = "10px";
    node.style.color = "0x404040";
    labelNode.style.backgroundColor = defaultBackgroundColor;
    labelNode.style.width = "100%";
    labelNode.style.paddingTop = "4px";
    labelNode.style.paddingBottom = "4px";
    labelNode.style.cursor = "pointer";
    labelNode.innerText = name;
    labelNode.textContent = name;
    node.appendChild(labelNode);

    buttonsNode.style.marginLeft = "20px";
    loadNode.src = "/load.png";
    loadNode.style.borderStyle = "solid";
    loadNode.style.borderColor = "#c0c0c0";
    loadNode.style.borderWidth = "1px";
    loadNode.style.borderRadius = "6px";
    loadNode.style.paddingTop = "1px";
    loadNode.style.paddingBottom = "1px";
    loadNode.style.paddingLeft = "4px";
    loadNode.style.paddingRight = "4px";
    loadNode.style.backgroundColor = "#ffffff";
    loadNode.style.display = "inline";
    loadNode.style.cursor = "pointer";
    buttonsNode.appendChild(loadNode);
    saveNode.src = "/save.png";
    saveNode.style.borderStyle = "solid";
    saveNode.style.borderColor = "#c0c0c0";
    saveNode.style.borderWidth = "1px";
    saveNode.style.borderRadius = "6px";
    saveNode.style.paddingTop = "1px";
    saveNode.style.paddingBottom = "1px";
    saveNode.style.paddingLeft = "4px";
    saveNode.style.paddingRight = "4px";
    saveNode.style.backgroundColor = "#ffffff";
    saveNode.style.display = "inline";
    saveNode.style.cursor = "pointer";
    buttonsNode.appendChild(saveNode);
    exportNode.src = "/export.png";
    exportNode.style.borderStyle = "solid";
    exportNode.style.borderColor = "#c0c0c0";
    exportNode.style.borderWidth = "1px";
    exportNode.style.borderRadius = "6px";
    exportNode.style.paddingTop = "1px";
    exportNode.style.paddingBottom = "1px";
    exportNode.style.paddingLeft = "4px";
    exportNode.style.paddingRight = "4px";
    exportNode.style.backgroundColor = "#ffffff";
    exportNode.style.display = "inline";
    exportNode.style.cursor = "pointer";
    buttonsNode.appendChild(exportNode);
    deleteNode.src = "/delete.png";
    deleteNode.style.borderStyle = "solid";
    deleteNode.style.borderColor = "#c0c0c0";
    deleteNode.style.borderWidth = "1px";
    deleteNode.style.borderRadius = "6px";
    deleteNode.style.paddingTop = "1px";
    deleteNode.style.paddingBottom = "1px";
    deleteNode.style.paddingLeft = "4px";
    deleteNode.style.paddingRight = "4px";
    deleteNode.style.backgroundColor = "#ffffff";
    deleteNode.style.display = "inline";
    deleteNode.style.cursor = "pointer";
    buttonsNode.appendChild(deleteNode);
    node.isOpen = false;
    node.onclick = function () {
        VDMPad.menuButtonsNode = buttonsNode;
        if (!node.isOpen) {
            node.appendChild(buttonsNode);
            node.isOpen = true;
        } else {
            node.removeChild(buttonsNode);
            node.isOpen = false;
        }
    };
    loadNode.onclick = function () {
        VDMPad.load(name);
    };
    saveNode.onclick = function () {
        VDMPad.saveAs(name, false);
    };
    exportNode.onclick = function () {
        VDMPad.saveAs(name, true);
    };
    deleteNode.onclick = function () {
        VDMPad.remove(name);
    };
    return node;

};

VDMPad.createSaveAsInputNode = function () {
    var node = document.createElement("div");
    var inputNode = document.createElement("input");
    var saveNode = document.createElement("img");
    
    node.style.width = "280px";
    node.style.height = "30px";
    inputNode.style.width = "100%";
    node.appendChild(inputNode);
    saveNode.style.visibility = "collapse";
    saveNode.src = "/save.png";
    node.appendChild(saveNode);
    inputNode.onkeyup = function () {
        if (inputNode.value)
            saveNode.style.visibility = "visible";
        else
            saveNode.style.visibility = "hidden";
    };
    saveNode.onmouseover = function () {
        saveNode.src = "/saveS.png";
    };
    saveNode.onmouseout = function () {
        saveNode.src = "/save.png";
    };
    saveNode.onclick = function () {
        VDMPad.saveAs(inputNode.value, false);
    };
    return node;
};
' withUnixLineEndings
]

{ #category : 'request handling-html' }
VDMPad >> aboutPage [

	^ self responseHtml: '<!DOCTYPE html><html>
<head>
<title>about VDMPad</title>
</head>
<body>
<div id="all" style="padding-left:30px">
<div style="padding-bottom: 20px; font-family: Helvetica, sans-serif; font-size:36px; font-weight: 400; color: #808080">VDMPad</div> 
<table style="font-family: Helvetica, sans-serif; font-size:14px; font-weight: 100; color: 202020">
<tr><td style="font-weight: bold">Author</td><td>Tomohiro Oda</td></tr>
<tr><td style="font-weight: bold">Copyright</td><td>Tomohiro Oda, Software Research Associates, Inc. and Kyushu University</td></tr>
<tr><td style="font-weight: bold">License</td><td>the MIT license</td></tr>
</table>
<pre>
Copyright (c) 2013-2026 Tomohiro Oda, Software Research Associates, Inc., and Kyushu University.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.</pre>
<br />
<div style="font-family: Helvetica, sans-serif; font-size:14px; font-weight: 100; color: 202020">
  <div style="font-weight: bold">Acknowledgement</div>
  Part of the VDMPad project is supported by Grant-in-Aid for Scientific Research (S) 24220001 from the Japan Society for the Promotion of Science.
</div>
</div>
</body>
</html>' withUnixLineEndings
]

{ #category : 'request handling-file' }
VDMPad >> binaryFileService: aZnRequest [
	| ref |
	ref := aZnRequest uri pathSegments
		inject: FileLocator viennaTalkDirectory / 'jars'
		into: [ :dir :seg | dir / seg ].
	^ ref exists
		ifTrue: [ ref
				binaryReadStreamDo: [ :stream | 
					self
						responseBinary: stream contents
						mimeType: ZnMimeType applicationOctetStream ] ]
		ifFalse: [ self responseNotFound: aZnRequest uri ]
]

{ #category : 'request handling-javascript' }
VDMPad >> blob [
	^ self
		responseJS:
			'/* Blob.js
 * A Blob implementation.
 * 2013-06-20
 * 
 * By Eli Grey, http://eligrey.com
 * By Devin Samarin, https://github.com/eboyjr
 * License: X11/MIT
 *   See LICENSE.md
 */
/* LICENSE.mb

This software is licensed under the MIT/X11 license.

MIT/X11 license

Copyright (C) 2011 Eli Grey.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */

/*global self, unescape */
/*jslint bitwise: true, regexp: true, confusion: true, es5: true, vars: true, white: true,
  plusplus: true */

/*! @source http://purl.eligrey.com/github/Blob.js/blob/master/Blob.js */

if (typeof Blob !== "function" || typeof URL === "undefined")
if (typeof Blob === "function" && typeof webkitURL !== "undefined") var URL = webkitURL;
else var Blob = (function (view) {
	"use strict";

	var BlobBuilder = view.BlobBuilder || view.WebKitBlobBuilder || view.MozBlobBuilder || view.MSBlobBuilder || (function(view) {
		var
			  get_class = function(object) {
				return Object.prototype.toString.call(object).match(/^\[object\s(.*)\]$/)[1];
			}
			, FakeBlobBuilder = function BlobBuilder() {
				this.data = [];
			}
			, FakeBlob = function Blob(data, type, encoding) {
				this.data = data;
				this.size = data.length;
				this.type = type;
				this.encoding = encoding;
			}
			, FBB_proto = FakeBlobBuilder.prototype
			, FB_proto = FakeBlob.prototype
			, FileReaderSync = view.FileReaderSync
			, FileException = function(type) {
				this.code = this[this.name = type];
			}
			, file_ex_codes = (
				  "NOT_FOUND_ERR SECURITY_ERR ABORT_ERR NOT_READABLE_ERR ENCODING_ERR "
				+ "NO_MODIFICATION_ALLOWED_ERR INVALID_STATE_ERR SYNTAX_ERR"
			).split(" ")
			, file_ex_code = file_ex_codes.length
			, real_URL = view.URL || view.webkitURL || view
			, real_create_object_URL = real_URL.createObjectURL
			, real_revoke_object_URL = real_URL.revokeObjectURL
			, URL = real_URL
			, btoa = view.btoa
			, atob = view.atob
			, can_apply_typed_arrays = false
			, can_apply_typed_arrays_test = function(pass) {
				can_apply_typed_arrays = !pass;
			}
			
			, ArrayBuffer = view.ArrayBuffer
			, Uint8Array = view.Uint8Array
		;
		FakeBlob.fake = FB_proto.fake = true;
		while (file_ex_code--) {
			FileException.prototype[file_ex_codes[file_ex_code]] = file_ex_code + 1;
		}
		try {
			if (Uint8Array) {
				can_apply_typed_arrays_test.apply(0, new Uint8Array(1));
			}
		} catch (ex) {}
		if (!real_URL.createObjectURL) {
			URL = view.URL = {};
		}
		URL.createObjectURL = function(blob) {
			var
				  type = blob.type
				, data_URI_header
			;
			if (type === null) {
				type = "application/octet-stream";
			}
			if (blob instanceof FakeBlob) {
				data_URI_header = "data:" + type;
				if (blob.encoding === "base64") {
					return data_URI_header + ";base64," + blob.data;
				} else if (blob.encoding === "URI") {
					return data_URI_header + "," + decodeURIComponent(blob.data);
				} if (btoa) {
					return data_URI_header + ";base64," + btoa(blob.data);
				} else {
					return data_URI_header + "," + encodeURIComponent(blob.data);
				}
			} else if (real_create_object_URL) {
				return real_create_object_URL.call(real_URL, blob);
			}
		};
		URL.revokeObjectURL = function(object_URL) {
			if (object_URL.substring(0, 5) !== "data:" && real_revoke_object_URL) {
				real_revoke_object_URL.call(real_URL, object_URL);
			}
		};
		FBB_proto.append = function(data/*, endings*/) {
			var bb = this.data;
			// decode data to a binary string
			if (Uint8Array && (data instanceof ArrayBuffer || data instanceof Uint8Array)) {
				if (can_apply_typed_arrays) {
					bb.push(String.fromCharCode.apply(String, new Uint8Array(data)));
				} else {
					var
						  str = ""
						, buf = new Uint8Array(data)
						, i = 0
						, buf_len = buf.length
					;
					for (; i < buf_len; i++) {
						str += String.fromCharCode(buf[i]);
					}
				}
			} else if (get_class(data) === "Blob" || get_class(data) === "File") {
				if (FileReaderSync) {
					var fr = new FileReaderSync;
					bb.push(fr.readAsBinaryString(data));
				} else {
					// async FileReader won"t work as BlobBuilder is sync
					throw new FileException("NOT_READABLE_ERR");
				}
			} else if (data instanceof FakeBlob) {
				if (data.encoding === "base64" && atob) {
					bb.push(atob(data.data));
				} else if (data.encoding === "URI") {
					bb.push(decodeURIComponent(data.data));
				} else if (data.encoding === "raw") {
					bb.push(data.data);
				}
			} else {
				if (typeof data !== "string") {
					data += ""; // convert unsupported types to strings
				}
				// decode UTF-16 to binary string
				bb.push(unescape(encodeURIComponent(data)));
			}
		};
		FBB_proto.getBlob = function(type) {
			if (!arguments.length) {
				type = null;
			}
			return new FakeBlob(this.data.join(""), type, "raw");
		};
		FBB_proto.toString = function() {
			return "[object BlobBuilder]";
		};
		FB_proto.slice = function(start, end, type) {
			var args = arguments.length;
			if (args < 3) {
				type = null;
			}
			return new FakeBlob(
				  this.data.slice(start, args > 1 ? end : this.data.length)
				, type
				, this.encoding
			);
		};
		FB_proto.toString = function() {
			return "[object Blob]";
		};
		return FakeBlobBuilder;
	}(view));

	return function Blob(blobParts, options) {
		var type = options ? (options.type || "") : "";
		var builder = new BlobBuilder();
		if (blobParts) {
			for (var i = 0, len = blobParts.length; i < len; i++) {
				builder.append(blobParts[i]);
			}
		}
		return builder.getBlob(type);
	};
}(self));'
]

{ #category : 'private' }
VDMPad >> charPositionToPoint: anInteger in: aString [
	| toGo numLines |
	toGo := anInteger + 1.
	numLines := 1.
	aString
		linesDo: [ :line | 
			| numChars |
			numChars := line size + 1.
			toGo <= numChars
				ifTrue: [ ^ toGo @ numLines ].
			toGo := toGo - numChars.
			numLines := numLines + 1 ].
	^ toGo @ numLines
]

{ #category : 'private' }
VDMPad >> contentTypeFor: url [
	(url endsWith: '.aiff')
		ifTrue: [ ^ ZnMimeType fromString: 'audio/aiff' ].
	(url endsWith: '.js')
		ifTrue: [ ^ ZnMimeType applicationJavascript ].
	(url endsWith: '.css')
		ifTrue: [ ^ ZnMimeType textCss ].
	(url endsWith: '.png')
		ifTrue: [ ^ ZnMimeType imagePng ].
	^ 'text/html'
]

{ #category : 'request handling-image' }
VDMPad >> copyIcon [
	"| form |
form := Form extent: 24@24 depth: 32.
form getCanvas
    fillColor: Color transparent;
    frameAndFillRectangle: (6@6 corner: 19@19) fillColor: Color transparent borderWidth: 2 topLeftColor: Color gray bottomRightColor: Color gray;
    line: 3@10 to: 3@22 width: 2 color: Color gray;
    line: 3@22 to: 15@22 width: 2 color: Color gray.
form"

	^ self responsePNG:
		  #[ 137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 24 0 0 0 24
		     8 6 0 0 0 224 119 61 248 0 0 0 57 73 68 65 84 120 94 99 24 249
		     96 228 3 218 129 134 134 134 255 164 226 193 105 1 213 212 162
		     43 26 249 22 140 124 11 70 190 5 52 200 201 116 183 128 102 165
		     231 160 42 158 73 114 16 205 45 160 21 0 0 72 30 93 132 56 171
		     44 233 0 0 0 0 73 69 78 68 174 66 96 130 ]
]

{ #category : 'request handling-image' }
VDMPad >> copyLinkIcon [

	^ self responsePNG:
		  #[ 137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 32 0 0 0 32
		     8 6 0 0 0 115 122 122 244 0 0 0 88 73 68 65 84 120 94 229 149
		     65 10 0 32 8 4 123 188 255 174 123 152 132 25 46 204 128 167
		     216 117 145 202 193 135 15 31 62 59 102 54 189 122 209 94 233
		     35 113 69 128 208 39 45 76 248 184 94 173 1 50 141 42 238 150
		     123 240 101 188 7 15 126 0 126 0 157 87 192 255 136 36 118 129
		     196 54 228 195 135 15 159 46 22 150 247 78 23 146 15 89 0 0 0 0
		     0 73 69 78 68 174 66 96 130 ]
]

{ #category : 'request handling-image' }
VDMPad >> copyQRIcon [

	^ self responsePNG:
		  #[ 137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 32 0 0 0 32
		     8 6 0 0 0 115 122 122 244 0 0 0 140 73 68 65 84 120 94 229 150
		     193 14 192 32 8 67 57 242 255 63 236 142 91 182 37 182 153 93
		     33 146 120 144 3 121 64 65 35 34 7 126 80 163 98 230 64 140 5 32
		     98 22 2 120 43 209 29 224 188 95 75 253 244 19 49 155 1 176 45
		     16 0 228 180 26 125 1 90 140 33 43 66 8 128 217 132 40 192 250
		     237 250 135 113 217 125 245 87 4 40 96 234 172 167 194 179 3 236
		     63 5 123 78 129 114 21 67 34 212 60 70 50 0 73 11 86 127 72 72
		     17 182 3 48 183 64 42 66 59 128 125 10 108 0 206 15 228 1 208
		     133 143 25 60 15 28 73 0 0 0 0 73 69 78 68 174 66 96 130 ]
]

{ #category : 'request handling-image' }
VDMPad >> deleteIcon [
	^ self
		responsePNG:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 45 0 0 0 18 8 6 0 0 0 207 54 87 226 0 0 1 108 73 68 65 84 120 94 229 149 45 112 194 64 16 133 83 215 184 196 5 137 60 92 112 137 44 142 186 226 168 12 46 56 36 149 169 43 174 117 181 212 5 71 29 145 145 212 5 7 50 117 169 59 220 107 254 166 144 114 201 29 211 210 41 147 155 137 185 121 111 247 187 187 221 141 4 156 223 146 80 127 232 51 132 166 193 19 174 200 0 139 232 143 160 211 132 202 5 46 21 21 138 210 128 70 76 220 216 19 204 215 219 211 65 135 51 140 172 9 150 244 39 208 251 9 163 13 22 207 3 232 164 135 199 96 123 18 232 84 175 15 225 255 26 116 182 139 165 99 130 88 30 190 182 233 10 238 184 7 93 139 95 68 107 161 59 154 33 160 37 49 42 180 136 60 88 68 134 36 201 217 235 146 33 223 35 6 29 239 47 239 96 24 247 249 19 126 96 97 183 161 219 121 160 56 193 212 106 195 112 222 64 15 98 84 107 217 55 205 247 136 65 7 147 93 224 232 21 253 184 92 166 33 251 80 133 24 28 45 19 90 192 115 252 77 175 147 102 149 227 70 85 139 31 201 18 23 98 112 180 76 104 1 207 241 53 29 119 123 95 239 193 13 5 26 145 163 101 66 11 120 184 211 195 79 167 199 245 222 244 72 106 206 132 145 52 71 174 163 137 206 95 165 135 58 172 233 114 109 6 249 130 110 161 28 4 60 229 115 90 221 205 233 239 227 142 110 224 58 183 48 154 141 92 215 129 245 224 49 160 171 181 217 122 199 124 220 65 179 48 61 120 158 250 255 198 235 15 93 127 232 127 177 62 1 23 196 99 211 59 35 53 5 0 0 0 0 73 69 78 68 174 66 96 130]
]

{ #category : 'request handling-image' }
VDMPad >> deleteSelectedIcon [
	^ self
		responsePNG:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 45 0 0 0 18 8 6 0 0 0 207 54 87 226 0 0 1 86 73 68 65 84 120 94 229 149 45 147 131 48 16 134 251 195 35 48 8 76 4 6 129 64 196 84 96 42 206 32 16 21 152 8 4 2 131 192 68 196 84 68 32 48 239 133 143 155 194 53 144 116 238 122 115 29 102 88 147 121 119 247 73 246 131 147 231 121 120 55 59 29 31 250 29 161 9 189 160 81 28 44 248 35 232 49 97 7 160 235 244 215 163 87 18 85 153 35 9 201 235 160 253 20 87 158 35 38 63 129 94 38 12 66 176 15 14 161 42 92 40 121 9 244 168 23 37 162 95 131 30 141 32 206 36 20 103 8 190 206 8 69 90 84 16 189 174 72 175 208 94 83 80 178 17 99 71 235 5 12 92 233 202 66 77 213 85 165 221 199 13 90 159 199 5 164 204 230 18 6 96 165 128 40 231 64 58 193 153 11 200 44 6 121 136 177 175 53 191 180 221 199 13 154 230 247 192 65 130 90 183 203 217 55 95 106 21 195 162 53 66 59 248 60 255 210 225 52 172 221 56 172 11 83 83 226 85 12 139 214 8 237 224 243 124 79 235 105 175 69 133 212 119 24 68 139 214 8 237 224 99 221 30 209 184 61 218 197 246 24 122 78 66 14 195 49 235 200 160 139 232 120 169 199 158 222 214 78 144 103 180 171 118 112 240 217 222 211 221 125 79 127 95 119 36 68 154 213 144 183 126 214 53 224 57 51 64 239 107 167 120 62 146 162 193 109 181 61 108 62 199 255 141 31 31 250 248 208 255 194 62 1 14 231 128 21 29 21 99 104 0 0 0 0 73 69 78 68 174 66 96 130]
]

{ #category : 'accessing' }
VDMPad >> engine [
	^ engine
]

{ #category : 'accessing' }
VDMPad >> engine: aViennaEngine [
	engine := aViennaEngine
]

{ #category : 'request handling-html' }
VDMPad >> epiLogPage [
	^ self
		responseHtml:
			('<!DOCTYPE html> 
<html ondragenter="return false;" ondragover="return false;" >
<head>
    <title>VDMPad</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="foundation.css">
    <link rel="stylesheet" href="epilog.css">
    <script src="/highlight.js"></script>
    <script src="/VDMPad-EpiLog.js"></script>
    </meta>
</head>
<body>
    <div id="here"></div>
    <script>
    VDMPad.epilogRender();
    </script>
</body>' copyReplaceAll: String cr with: String crlf)
]

{ #category : 'request handling-css' }
VDMPad >> epilogCss [
	^ self responseCss: ('
      .state-table {
          border-style: hidden;
          border-collapse: collapse;
          display: block;
      }
      .state-vars {
          vertical-align: bottom;
          text-align: center;
          border-bottom: solid 1px black;
      }
      .state-var {
          padding-left: 10px;
          padding-right: 10px;
      }
      .state-values {
          vertical-align: top;
      }
      .state-value {
          padding-left: 10px;
          padding-right: 10px;
      }
      .phase {
          clear: both;
      }
      .scenario {
          border-left:solid 30px #e0e0e0;
          border-right:solid 1px #e0e0e0;
          margin-left:10px;
          margin-bottom:50px;
          float:left;
      }
      .run {
          background-color: #f0f0f0;
          border-top:dashed 1px #e0e0e0;
          border-bottom:dashed 1px #e0e0e0;
          padding-left:50px;
          padding-right:50px;
      }
      .run-invalid {
          background-color: #ffffd0;
          border-top:dashed 1px #e0e0e0;
          border-bottom:dashed 1px #e0e0e0;
          padding-left:50px;
          padding-right:50px;
      }
      .selection {
          border: solid 5px #e0e0e0;
          border-radius: 10px;
      }
      .selection-noborder {
          border: hidden 0px #ffffff;
      }
      .icon {
          padding: 5px;
          cursor: pointer;
      }
' copyReplaceAll: String cr with: String crlf)
]

{ #category : 'request handling-api' }
VDMPad >> eval: aZnRequest [

	| params valueReader parser documentSource documentNode module expressionSource expressionNode transpiledSpec prestates result json |
	params := self getParamsFrom: aZnRequest.
	json := params copy
		        at: 'value' put: nil;
		        at: 'message' put: '';
		        removeKey: 'needsPrestates' ifAbsent: [ ];
		        yourself.
	valueReader := ViennaReader new.
	parser := ViennaVDMParser new.
	documentSource := (params at: 'source' ifAbsent: [ String new ])
		                  trimmed.
	documentNode := parser document end
		                parse: documentSource
		                withContext: ViennaPP2HighlightingContext new.
	documentNode isPetit2Failure ifTrue: [
			| position point |
			position := documentNode furthestPosition.
			point := self charPositionToPoint: position in: documentSource.
			^ self responseJSON: (json
					   at: 'message'
					   put:
						   'Syntax error in the specification at ' , point y printString
						   , ':' , point x printString , '.';
					   at: 'position' put: position;
					   yourself) ].
	documentNode := documentNode returnValue.
	documentNode isViennaFlatDocumentNode ifTrue: [
		documentNode := documentNode asModularDocument ].
	[ documentNode typecheck ]
		on: ViennaTypeError
		do: [ :typeError |
				^ self responseJSON: (json
						   at: 'message' put: typeError messageText;
						   yourself) ].
	module := params
		          at: 'module'
		          ifPresent: [ :m |
				          m = 'DEFAULT'
					          ifTrue: [ nil ]
					          ifFalse: [
							          (documentNode moduleNamed: m) ifNil: [
									          ^ self responseJSON: (json
											             at: 'message' put: 'Unknown module: ' , m;
											             yourself) ].
							          m ] ]
		          ifAbsent: [ nil ].
	transpiledSpec := ViennaTranspilerForVDMPad new generate:
		                  documentNode.
	expressionSource := ((params
		                      at: 'expression'
		                      ifAbsent: [ String new ])
		                     withInternalLineEndings
		                     copyReplaceAll: String cr
		                     with: ' ') trim.
	expressionNode := expressionSource
		                  ifNotEmpty: [ :string |
				                  parser statement / parser expression end
					                  parse: string
					                  withContext: ViennaPP2HighlightingContext new ]
		                  ifEmpty: [ nil ].
	expressionNode isPetit2Failure ifTrue: [
			| position point |
			position := expressionNode furthestPosition.
			point := self charPositionToPoint: position in: expressionSource.
			^ self responseJSON: (json
					   at: 'message'
					   put:
						   'Syntax error in the expression/statement at '
						   , point y printString , ':' , point x printString , '.';
					   yourself) ].
	expressionNode := expressionNode ifNotNil: #returnValue.
	prestates := params
		             at: 'needsPrestates'
		             ifPresent: [ Dictionary new ]
		             ifAbsent: [ nil ].
	params keysAndValuesDo: [ :key :value |
			((key includes: $`) and: [ value trimmed notEmpty ]) ifTrue: [
					| moduleName variableName valueString |
					json removeKey: key.
					moduleName := key copyFrom: 1 to: (key indexOf: $`) - 1.
					variableName := key copyFrom: (key indexOf: $`) + 1 to: key size.
					valueString := (value withInternalLineEndings
						                copyReplaceAll: String cr
						                with: ' ') trim.
					transpiledSpec at: moduleName ifPresent: [ :transpiledModule |
							transpiledModule
								basicInstVarNamed: variableName
								put: (valueReader parse: valueString) ].
					prestates ifNotNil: [
							(prestates at: moduleName ifAbsentPut: [ Dictionary new ])
								at: variableName
								put: valueString ] ] ].
	prestates ifNotNil: [ json at: 'prestates' put: prestates ].
	expressionNode ifNotNil: [
			| needsSequenceDiagram needsStateDiagram needsExecutionTrace |
			needsSequenceDiagram := params includesKey: 'sequenceDiagram'.
			needsStateDiagram := params includesKey: 'stateDiagram'.
			needsExecutionTrace := needsSequenceDiagram or: [
				                       needsStateDiagram ].
			needsExecutionTrace ifTrue: [
					transpiledSpec useEventRecorder:
						(transpiledSpec state associations collect: [ :assoc |
							 assoc key -> assoc value asOrderedDictionary ])
							asOrderedDictionary ].
			result := [
				          (transpiledSpec at: module ifAbsent: [ transpiledSpec ])
					          evaluateNode: expressionNode
					          ifError: [ :msg |
							          json at: 'message' put: 'Runtime error: ' , msg.
							          self ] ]
				          on: Exception
				          do: [ :ex |
						          json
							          at: 'message'
							          put: 'Runtime error: ' , ex class name
								          ,
									          ((ex signalContext specificationContext ifNotNil:
										            #vdmPcNodes)
										           ifNotNil: [ :nodes |
												           String lf , (String lf , '↖' , String lf join:
													            (nodes select: #notNil thenCollect: #source)) ]
										           ifNil: [ '' ]).
						          ^ self responseJSON: json ].
			needsExecutionTrace ifTrue: [
					transpiledSpec _recorder output ifNotNil: [ :root |
							needsSequenceDiagram ifTrue: [
									| sequenceDiagram |
									sequenceDiagram := String streamContents: [ :stream |
											                   | format |
											                   format := ViennaExecutionTraceSequenceDiagramFormat
												                             new
												                             root: expressionSource;
												                             yourself.
											                   format writeHeaderOn: stream.
											                   root applyToFormat: format on: stream.
											                   format writeFooterOn: stream ].
									json at: 'sequenceDiagram' put: sequenceDiagram ].
							needsStateDiagram ifTrue: [
									| stateDiagram |
									stateDiagram := String streamContents: [ :stream |
											                | format |
											                format := ViennaExecutionTraceStateDiagramFormat
												                          new
												                          probes:
													                          transpiledSpec _defaultProbes;
												                          showsProbeNames: true;
												                          showsOperationNames: true;
												                          yourself.
											                root initial do: [ :event |
												                event applyAssignmentTo: transpiledSpec ].
											                format writeHeaderOn: stream.
											                root
												                applyToFormat: format
												                on: stream
												                before: [ :event |
												                event applyAssignmentTo: transpiledSpec ]
												                after: [ :event |  ].
											                format writeFooterOn: stream ].
									json at: 'stateDiagram' put: stateDiagram ] ] ] ].
	transpiledSpec statevariablesAndValuesDo: [ :var :val |
		json at: var put: val viennaString ].
	result == self ifFalse: [ json at: 'value' put: result viennaString ].
	^ self responseJSON: json
]

{ #category : 'request handling-image' }
VDMPad >> exportIcon [
	^ self
		responsePNG:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 84 0 0 0 18 8 6 0 0 0 197 106 249 176 0 0 3 207 73 68 65 84 120 94 229 88 33 112 234 90 16 229 185 214 81 7 50 117 193 37 46 200 212 165 46 117 65 166 46 184 224 82 9 46 117 60 199 147 169 3 7 46 200 224 192 165 46 200 212 5 151 186 243 246 38 55 36 80 120 125 116 254 244 255 249 185 51 153 1 110 246 238 238 217 179 103 239 208 0 234 191 254 201 213 168 63 4 245 7 180 254 128 214 22 208 100 253 2 91 147 209 106 222 160 217 188 133 168 246 224 6 187 111 8 35 69 232 13 160 10 204 111 27 162 54 192 60 62 122 35 252 9 181 249 3 87 89 108 197 211 129 229 239 254 29 228 226 25 108 243 25 235 244 28 160 201 10 182 212 129 233 189 34 225 73 198 225 10 126 248 254 45 193 233 66 23 195 172 120 41 146 112 131 40 57 1 168 248 8 63 249 111 48 49 139 71 234 35 56 11 104 196 2 238 97 126 46 224 100 137 161 209 133 208 202 217 43 25 35 248 156 69 209 228 30 146 185 64 82 97 220 218 233 66 113 54 252 235 43 166 206 3 36 102 219 234 64 179 103 8 171 129 196 47 208 197 123 76 162 79 18 56 3 104 26 253 202 236 221 245 251 190 64 166 212 133 67 5 202 237 30 224 186 253 188 3 152 127 103 134 168 234 63 217 96 98 221 65 100 241 9 50 244 225 98 191 95 218 63 66 33 123 65 159 101 88 152 226 53 26 141 235 188 99 196 254 9 64 211 21 28 169 77 192 60 195 155 111 16 198 71 204 36 6 79 167 43 206 156 55 204 109 25 34 129 152 97 74 9 105 210 99 89 12 118 150 66 140 203 18 220 193 183 100 72 22 7 145 192 245 76 25 202 112 131 180 82 44 91 162 192 212 17 130 228 114 64 179 16 188 30 73 212 8 235 100 11 207 232 64 229 231 231 82 113 147 249 207 64 162 60 92 141 246 221 87 238 255 13 83 122 255 112 255 118 191 95 216 43 206 18 113 122 9 67 179 74 47 49 182 123 20 120 27 87 132 190 160 14 224 157 105 249 52 28 65 145 6 252 64 74 66 151 97 76 223 242 189 96 0 133 146 203 0 76 22 48 168 194 94 69 19 211 245 19 20 101 196 245 231 141 0 144 161 185 75 248 238 61 129 242 180 103 126 186 30 65 85 243 247 242 196 174 43 250 201 216 38 195 218 107 60 1 67 133 18 21 122 212 82 219 50 59 225 144 253 73 208 135 164 240 248 152 220 28 117 71 226 151 251 133 189 23 95 218 242 199 128 81 27 120 196 44 65 251 133 136 183 113 52 31 193 80 58 124 104 17 221 133 242 192 216 163 150 54 102 196 216 29 2 98 239 158 1 209 9 32 120 155 100 182 172 221 149 162 48 100 59 188 131 160 176 161 244 142 112 124 15 197 94 149 76 249 68 67 25 16 226 85 27 58 47 236 57 102 167 225 115 9 70 244 231 253 115 126 47 6 244 131 99 170 164 33 222 241 193 193 25 42 86 14 100 149 150 136 137 225 18 150 116 135 113 88 234 153 65 191 79 227 51 78 162 42 160 57 211 124 210 223 150 216 133 68 204 46 152 243 41 160 9 147 153 14 116 171 7 137 58 167 120 239 75 12 13 142 24 250 37 64 227 37 38 222 178 212 206 116 139 57 37 38 234 47 57 67 41 113 77 224 64 165 185 134 54 133 254 1 16 76 139 20 131 196 93 251 137 50 62 166 161 52 160 216 32 42 146 36 157 11 130 226 54 177 197 68 39 77 115 22 92 159 119 212 9 36 9 236 138 68 137 76 255 10 80 242 97 83 1 172 69 214 33 172 32 249 231 138 134 218 151 104 104 231 80 67 79 249 165 206 210 142 164 236 195 181 105 108 81 139 9 109 174 79 116 40 13 40 63 46 131 14 220 7 136 180 215 34 166 90 67 210 201 163 10 197 243 30 132 198 13 180 201 246 168 156 91 76 135 189 253 217 204 222 36 205 76 42 190 247 83 150 238 161 18 221 67 39 4 56 43 168 160 60 101 201 252 233 30 154 248 131 3 86 230 108 149 97 82 235 23 83 122 60 30 100 179 129 217 124 156 242 148 187 73 82 195 117 249 227 148 63 85 72 34 149 195 109 78 78 249 255 233 250 238 251 107 253 1 173 63 160 245 7 180 254 255 54 213 127 125 125 253 6 157 226 67 139 5 249 49 56 0 0 0 0 73 69 78 68 174 66 96 130]
]

{ #category : 'request handling-image' }
VDMPad >> exportSelectedIcon [
	^ self
		responsePNG:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 84 0 0 0 18 8 6 0 0 0 197 106 249 176 0 0 3 147 73 68 65 84 120 94 229 88 161 146 164 48 16 221 15 143 88 131 136 65 96 16 8 4 6 129 25 129 65 32 16 24 4 2 17 131 192 68 196 68 68 32 48 239 58 33 12 204 236 204 238 205 214 213 222 213 33 82 181 187 161 211 157 247 94 191 78 237 219 251 251 59 206 191 254 220 122 59 63 8 231 7 244 252 128 158 22 80 158 228 104 38 137 101 158 49 207 26 102 20 168 99 254 3 133 48 132 121 131 81 219 188 11 204 212 32 13 110 191 97 225 5 227 12 192 213 182 45 131 62 227 127 7 188 160 64 211 213 72 216 51 64 121 140 70 26 116 121 8 238 47 25 132 49 178 144 253 72 113 131 86 168 28 121 12 60 76 16 241 7 128 154 14 25 255 55 148 232 234 145 61 226 167 128 70 182 96 129 244 89 193 60 67 37 20 244 178 170 87 138 10 153 87 81 84 78 144 93 234 137 88 201 72 90 5 213 38 235 239 44 68 209 14 144 54 118 49 152 154 2 225 177 144 32 199 96 38 148 209 23 23 120 2 40 139 74 23 95 39 236 74 80 39 21 90 34 104 141 27 80 215 253 218 1 54 127 91 32 58 230 231 9 202 126 132 177 245 105 137 161 74 175 251 123 124 7 69 241 122 40 28 22 157 161 110 129 89 59 198 244 15 0 101 49 90 185 16 48 53 242 52 65 24 220 41 147 20 92 20 177 87 78 128 180 145 48 4 98 224 200 40 49 201 110 39 195 158 165 72 113 238 130 28 89 47 33 123 15 34 129 155 119 18 170 74 192 14 100 53 146 10 27 43 196 252 117 64 29 169 185 32 139 170 144 240 8 185 48 24 253 249 171 85 204 46 191 3 137 238 81 79 180 95 135 62 127 128 130 190 191 221 215 215 253 45 94 181 25 2 246 138 66 29 211 25 46 141 160 194 23 135 190 30 27 228 79 90 158 133 21 148 108 252 129 116 137 65 66 20 193 186 23 55 80 116 57 7 32 79 33 136 225 252 224 137 44 105 161 84 229 253 39 32 0 36 166 58 67 86 79 4 74 123 85 62 75 42 140 227 250 221 230 161 243 209 67 23 137 254 234 241 4 12 17 101 20 173 113 247 54 23 167 111 213 207 227 30 82 249 250 172 221 220 117 7 207 246 253 45 62 15 94 109 249 123 192 168 13 114 82 150 158 74 68 190 141 163 180 130 80 198 15 45 194 92 239 7 6 57 181 180 40 72 177 28 49 169 247 170 128 232 1 16 190 77 92 172 109 119 181 17 67 177 213 8 173 236 80 162 65 117 153 160 154 120 87 202 23 30 106 129 160 234 48 120 98 159 41 155 133 245 14 70 244 249 254 179 188 47 3 250 33 49 49 41 204 232 7 135 87 168 57 28 104 153 150 164 196 48 67 47 71 92 194 221 207 4 253 189 8 158 228 137 142 128 174 74 203 200 127 23 163 32 73 217 155 114 190 4 148 91 155 49 24 122 1 73 157 179 125 247 45 133 198 119 10 253 22 160 65 134 50 207 118 239 100 17 82 186 152 25 242 85 161 116 241 73 123 160 216 234 161 179 238 111 128 176 94 164 4 153 251 116 241 170 126 247 30 74 3 202 14 162 237 146 228 115 113 188 189 38 34 148 3 121 90 155 122 127 230 212 9 100 9 182 3 232 34 197 111 1 74 57 26 34 160 79 93 135 88 66 214 159 15 30 218 188 226 161 230 214 67 31 229 165 206 154 238 172 236 195 179 233 210 83 139 233 197 251 19 29 74 3 42 11 246 162 227 122 128 161 189 133 148 218 87 228 147 119 12 5 169 128 198 140 169 140 110 147 19 57 69 37 174 103 219 248 142 60 147 31 114 95 167 44 189 67 37 189 67 75 2 220 18 170 85 235 46 243 217 59 148 103 205 141 42 87 181 74 116 212 250 219 148 190 92 26 55 27 108 204 199 41 79 119 239 200 106 188 47 127 156 242 143 136 36 81 181 62 230 225 148 255 79 215 79 191 95 207 15 232 249 1 61 63 160 231 255 111 211 249 215 247 215 47 244 135 222 23 150 156 223 236 0 0 0 0 73 69 78 68 174 66 96 130]
]

{ #category : 'request handling-javascript' }
VDMPad >> fileSaver [
	^ self
		responseJS:
			'/* FileSaver.js
 * A saveAs() FileSaver implementation.
 * 2013-01-23
 *
 * By Eli Grey, http://eligrey.com
 * License: X11/MIT
 *   See LICENSE.md
 */
/* LICENSE.md
This software is licensed under the MIT/X11 license.

MIT/X11 license

Copyright (C) 2011 Eli Grey.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */
/*global self */
/*jslint bitwise: true, regexp: true, confusion: true, es5: true, vars: true, white: true,
  plusplus: true */

/*! @source http://purl.eligrey.com/github/FileSaver.js/blob/master/FileSaver.js */

var saveAs = saveAs
  || (navigator.msSaveOrOpenBlob && navigator.msSaveOrOpenBlob.bind(navigator))
  || (function(view) {
	"use strict";
	var
		  doc = view.document
		  // only get URL when necessary in case BlobBuilder.js hasn"t overridden it yet
		, get_URL = function() {
			return view.URL || view.webkitURL || view;
		}
		, URL = view.URL || view.webkitURL || view
		, save_link = doc.createElementNS("http://www.w3.org/1999/xhtml", "a")
		, can_use_save_link =  !view.externalHost && "download" in save_link
		, click = function(node) {
			var event = doc.createEvent("MouseEvents");
			event.initMouseEvent(
				"click", true, false, view, 0, 0, 0, 0, 0
				, false, false, false, false, 0, null
			);
			node.dispatchEvent(event);
		}
		, webkit_req_fs = view.webkitRequestFileSystem
		, req_fs = view.requestFileSystem || webkit_req_fs || view.mozRequestFileSystem
		, throw_outside = function (ex) {
			(view.setImmediate || view.setTimeout)(function() {
				throw ex;
			}, 0);
		}
		, force_saveable_type = "application/octet-stream"
		, fs_min_size = 0
		, deletion_queue = []
		, process_deletion_queue = function() {
			var i = deletion_queue.length;
			while (i--) {
				var file = deletion_queue[i];
				if (typeof file === "string") { // file is an object URL
					URL.revokeObjectURL(file);
				} else { // file is a File
					file.remove();
				}
			}
			deletion_queue.length = 0; // clear queue
		}
		, dispatch = function(filesaver, event_types, event) {
			event_types = [].concat(event_types);
			var i = event_types.length;
			while (i--) {
				var listener = filesaver["on" + event_types[i]];
				if (typeof listener === "function") {
					try {
						listener.call(filesaver, event || filesaver);
					} catch (ex) {
						throw_outside(ex);
					}
				}
			}
		}
		, FileSaver = function(blob, name) {
			// First try a.download, then web filesystem, then object URLs
			var
				  filesaver = this
				, type = blob.type
				, blob_changed = false
				, object_url
				, target_view
				, get_object_url = function() {
					var object_url = get_URL().createObjectURL(blob);
					deletion_queue.push(object_url);
					return object_url;
				}
				, dispatch_all = function() {
					dispatch(filesaver, "writestart progress write writeend".split(" "));
				}
				// on any filesys errors revert to saving with object URLs
				, fs_error = function() {
					// don"t create more object URLs than needed
					if (blob_changed || !object_url) {
						object_url = get_object_url(blob);
					}
					if (target_view) {
						target_view.location.href = object_url;
					} else {
                        window.open(object_url, "_blank");
                    }
					filesaver.readyState = filesaver.DONE;
					dispatch_all();
				}
				, abortable = function(func) {
					return function() {
						if (filesaver.readyState !== filesaver.DONE) {
							return func.apply(this, arguments);
						}
					};
				}
				, create_if_not_found = {create: true, exclusive: false}
				, slice
			;
			filesaver.readyState = filesaver.INIT;
			if (!name) {
				name = "download";
			}
			if (can_use_save_link) {
				object_url = get_object_url(blob);
				save_link.href = object_url;
				save_link.download = name;
				click(save_link);
				filesaver.readyState = filesaver.DONE;
				dispatch_all();
				return;
			}
			// Object and web filesystem URLs have a problem saving in Google Chrome when
			// viewed in a tab, so I force save with application/octet-stream
			// http://code.google.com/p/chromium/issues/detail?id=91158
			if (view.chrome && type && type !== force_saveable_type) {
				slice = blob.slice || blob.webkitSlice;
				blob = slice.call(blob, 0, blob.size, force_saveable_type);
				blob_changed = true;
			}
			// Since I can"t be sure that the guessed media type will trigger a download
			// in WebKit, I append .download to the filename.
			// https://bugs.webkit.org/show_bug.cgi?id=65440
			if (webkit_req_fs && name !== "download") {
				name += ".download";
			}
			if (type === force_saveable_type || webkit_req_fs) {
				target_view = view;
			}
			if (!req_fs) {
				fs_error();
				return;
			}
			fs_min_size += blob.size;
			req_fs(view.TEMPORARY, fs_min_size, abortable(function(fs) {
				fs.root.getDirectory("saved", create_if_not_found, abortable(function(dir) {
					var save = function() {
						dir.getFile(name, create_if_not_found, abortable(function(file) {
							file.createWriter(abortable(function(writer) {
								writer.onwriteend = function(event) {
									target_view.location.href = file.toURL();
									deletion_queue.push(file);
									filesaver.readyState = filesaver.DONE;
									dispatch(filesaver, "writeend", event);
								};
								writer.onerror = function() {
									var error = writer.error;
									if (error.code !== error.ABORT_ERR) {
										fs_error();
									}
								};
								"writestart progress write abort".split(" ").forEach(function(event) {
									writer["on" + event] = filesaver["on" + event];
								});
								writer.write(blob);
								filesaver.abort = function() {
									writer.abort();
									filesaver.readyState = filesaver.DONE;
								};
								filesaver.readyState = filesaver.WRITING;
							}), fs_error);
						}), fs_error);
					};
					dir.getFile(name, {create: false}, abortable(function(file) {
						// delete file if it already exists
						file.remove();
						save();
					}), abortable(function(ex) {
						if (ex.code === ex.NOT_FOUND_ERR) {
							save();
						} else {
							fs_error();
						}
					}));
				}), fs_error);
			}), fs_error);
		}
		, FS_proto = FileSaver.prototype
		, saveAs = function(blob, name) {
			return new FileSaver(blob, name);
		}
	;
	FS_proto.abort = function() {
		var filesaver = this;
		filesaver.readyState = filesaver.DONE;
		dispatch(filesaver, "abort");
	};
	FS_proto.readyState = FS_proto.INIT = 0;
	FS_proto.WRITING = 1;
	FS_proto.DONE = 2;

	FS_proto.error =
	FS_proto.onwritestart =
	FS_proto.onprogress =
	FS_proto.onwrite =
	FS_proto.onabort =
	FS_proto.onerror =
	FS_proto.onwriteend =
		null;

	view.addEventListener("unload", process_deletion_queue, false);
	return saveAs;
}(self));

if (typeof module !== "undefined") module.exports = saveAs;
'
]

{ #category : 'request handling-file' }
VDMPad >> fileService: aZnRequest [
	| ref |
	ref := aZnRequest uri pathSegments
		inject: FileLocator viennaTalkDirectory
		into: [ :dir :seg | dir / seg ].
	^ ref exists
		ifTrue: [ ref
				binaryReadStreamDo: [ :stream | 
					self
						responseBinary: stream contents
						mimeType: (self contentTypeFor: ref basename) ] ]
		ifFalse: [ self responseNotFound: aZnRequest uri ]
]

{ #category : 'request handling-api' }
VDMPad >> format: aZnRequest [

	| parser params json source ast |
	parser := ViennaVDMParser new.
	params := self getParamsFrom: aZnRequest.
	json := params copy
		        at: 'message' put: '';
		        at: 'value' ifAbsentPut: [ String new ];
		        yourself.
	source := (params at: 'source' ifAbsent: [ String new ]) trim
		          withInternalLineEndings.
	ast := parser parse: source.
	ast isPetit2Failure ifTrue: [
			| context position point |
			context := parser debug: source.
			position := context furthestPosition.
			point := self charPositionToPoint: position in: source.
			json
				at: 'message' put: (String streamContents: [ :stream |
								 stream nextPutAll: 'Syntax Error at '.
								 stream
									 nextPutAll: point y printString;
									 nextPut: $:;
									 nextPutAll: point x printString ]);
				at: 'position' put: position.
			^ self responseJSON: json ].
	json at: 'source' put: (ViennaVDMFormatter new
			 maxSizePerLine: 70;
			 format: ast) withUnixLineEndings.
	^ self responseJSON: json
]

{ #category : 'request handling-css' }
VDMPad >> foundationCss [
	^ self responseCss: ('/*
Description: Foundation 4 docs style for highlight.js
Author: Dan Allen <dan.j.allen@gmail.com>
Website: http://foundation.zurb.com/docs/
Version: 1.0
Date: 2013-04-02
*/

.hljs {
  display: block;
  overflow-x: auto;
  padding: 0.5em;
}

.hljs-link,
.hljs-emphasis,
.hljs-attribute,
.hljs-addition {
  color: #070;
}

.hljs-emphasis {
  font-style: italic;
}

.hljs-strong,
.hljs-string,
.hljs-deletion {
  color: #d14;
}

.hljs-strong {
  font-weight: bold;
}

.hljs-quote,
.hljs-comment {
  color: #998;
  font-style: italic;
}

.hljs-section,
.hljs-title {
  color: #900;
}

.hljs-class .hljs-title,
.hljs-type {
  color: #458;
}

.hljs-variable,
.hljs-template-variable {
  color: #336699;
}

.hljs-bullet {
  color: #997700;
}

.hljs-meta {
  color: #3344bb;
}

.hljs-code {
  color: #888;
}

.hljs-keyword,
.hljs-keyword1,
.hljs-keyword2,
.hljs-keyword3,
.hljs-keyword4,
.hljs-keyword5,
.hljs-selector-tag {
  color: #800000;
  font-weight: bold; 
}

.hljs-builtin { 
  color: blue;
}

.hljs-number,
.hljs-literal {
  color: #808000;
}

.hljs-regexp {
  background-color: #fff0ff;
  color: #880088;
}

.hljs-symbol {
  color: #800000;
}

.hljs-tag,
.hljs-name,
.hljs-selector-id,
.hljs-selector-class {
  color: #007700;
}
' copyReplaceAll: String cr with: String crlf)
]

{ #category : 'private' }
VDMPad >> getParamsFrom: aZnRequest [

	^ (aZnRequest contentType notNil and: [
			   aZnRequest contentType main = 'application' and: [
				   aZnRequest contentType sub asLowercase = 'json' ] ])
		  ifTrue: [
				  (NeoJSONReader fromString: aZnRequest entity)
					  addAll: (aZnRequest url query ifNil: [ Dictionary new ]);
					  yourself ]
		  ifFalse: [ aZnRequest mergedFields ]
]

{ #category : 'request handling' }
VDMPad >> handleRequest: aZnRequest [
	| path map |
	path := aZnRequest uri isSlash
		ifTrue: [ #('/') ]
		ifFalse: [ aZnRequest uri segments ].
	map := handlerMap.
	path
		do: [ :name | 
			map := map at: name ifAbsent: [ ^ self responseNotFound: aZnRequest uri ].
			map isSymbol
				ifTrue: [ 
					^ map numArgs = 0
						ifTrue: [ self perform: map ]
						ifFalse: [ self perform: map with: aZnRequest ] ].
			map isClosure
				ifTrue: [ ^ map cull: aZnRequest ] ].
	^ self responseNotFound: aZnRequest uri
]

{ #category : 'request handling-api' }
VDMPad >> id: aZnRequest [
	| params source states expression result message json |
	params := self getParamsFrom: aZnRequest.
	source := (params at: 'source' ifAbsent: [ String new ]) trimmed.
	states := Dictionary new.
	params
		keysAndValuesDo: [ :k :v | 
			| key value |
			key := k.
			value := v.
			((key includes: $`) and: [ value trimmed notEmpty ])
				ifTrue: [ 
					(states at: (key copyFrom: 1 to: (key indexOf: $`) - 1) ifAbsentPut: [ OrderedCollection new ])
						add:
							(key copyFrom: (key indexOf: $`) + 1 to: key size)
								-> ((value copyReplaceAll: String cr with: ' ') copyReplaceAll: String lf with: ' ') ] ].
	expression := params at: 'expression' ifAbsent: [ String new ].
	result := ((params at: 'value' ifAbsent: [ String new ]) copyReplaceAll: String cr with: ' ')
		copyReplaceAll: String lf
		with: ' '.
	message := params at: 'message' ifAbsent: [ String new ].
	json := Dictionary new.
	json
		at: 'source' put: source;
		at: 'expression' put: expression;
		at: 'value' put: result;
		at: 'message' put: message.
	states
		keysAndValuesDo: [ :moduleName :bindings | bindings do: [ :variableAndValue | json at: moduleName , '`' , variableAndValue key put: variableAndValue value ] ].
	^ self responseJSON: json
]

{ #category : 'initialize-release' }
VDMPad >> initialize [

	super initialize.
	engine := ViennaEngineForVDMPad new.
	handlerMap := Dictionary new
		              at: '/' put: #mainPage:;
		              at: 'EpiLog' put: #epiLogPage;
		              at: 'epilog.css' put: #epilogCss;
		              at: 'foundation.css' put: #foundationCss;
		              at: 'favicon.ico' put: #vdmpadIcon;
		              at: 'about.html' put: #aboutPage;
		              at: 'VDMPad.js' put: #VDMPad;
		              at: 'VDMInstantPad.js' put: #VDMInstantPad;
		              at: 'VDMPad-EpiLog.js' put: #VDMPadEpiLog;
		              at: 'fileSaver.js' put: #fileSaver;
		              at: 'blob.js' put: #blob;
		              at: 'eval' put: #eval:;
		              at: 'id' put: #id:;
		              at: 'test' put: #test:;
		              at: 'format' put: #format:;
		              at: 'vdm2html' put: #vdm2html:;
		              at: 'rootMenuOn.png' put: #rootMenuOn;
		              at: 'rootMenuOff.png' put: #rootMenuOff;
		              at: 'load.png' put: #loadIcon;
		              at: 'save.png' put: #saveIcon;
		              at: 'export.png' put: #exportIcon;
		              at: 'delete.png' put: #deleteIcon;
		              at: 'load.Spng' put: #loadSelectedIcon;
		              at: 'saveS.png' put: #saveSelectedIcon;
		              at: 'exportS.png' put: #exportSelectedIcon;
		              at: 'deleteS.png' put: #deleteSelectedIcon;
		              at: 'saveT.png' put: #saveTransparentIcon;
		              at: 'copy.png' put: #copyIcon;
		              at: 'copyLink.png' put: #copyLinkIcon;
		              at: 'copyQR.png' put: #copyQRIcon;
		              at: 'vdmj-3.0.1.jar' put: #binaryFileService:;
		              at: 'vdmj-3.1.1.jar' put: #binaryFileService:;
		              at: 'vdmj-3.2.0.jar' put: #binaryFileService:;
		              at: 'Json4VDMJ.jar' put: #binaryFileService:;
		              yourself
]

{ #category : 'request handling-image' }
VDMPad >> linkIcon [

	^ self responsePNG:
		  #[ 137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 32 0 0 0 32
		     8 6 0 0 0 115 122 122 244 0 0 0 88 73 68 65 84 120 94 229 149
		     65 10 0 32 8 4 123 188 255 174 123 152 132 25 46 204 128 167
		     216 117 145 202 193 135 15 31 62 59 102 54 189 122 209 94 233
		     35 113 69 128 208 39 45 76 248 184 94 173 1 50 141 42 238 150
		     123 240 101 188 7 15 126 0 126 0 157 87 192 255 136 36 118 129
		     196 54 228 195 135 15 159 46 22 150 247 78 23 146 15 89 0 0 0 0
		     0 73 69 78 68 174 66 96 130 ]
]

{ #category : 'request handling-image' }
VDMPad >> loadIcon [
	^ self
		responsePNG:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 34 0 0 0 18 8 6 0 0 0 62 61 12 111 0 0 1 87 73 68 65 84 120 94 229 85 43 112 194 64 20 76 29 184 195 165 242 112 135 75 28 149 196 81 7 238 42 83 7 14 28 149 137 75 93 234 208 117 224 136 75 101 112 173 75 93 44 117 193 29 110 123 36 164 9 52 253 12 173 200 76 50 19 181 183 239 237 219 219 55 167 0 213 248 20 212 95 72 5 132 136 240 1 61 109 140 64 148 8 73 64 118 11 63 174 191 144 95 10 137 95 48 31 25 96 106 11 132 234 24 88 30 162 172 80 252 4 139 95 129 238 49 210 134 198 109 248 155 34 119 13 87 226 42 105 129 106 55 176 220 59 116 207 19 242 134 5 239 64 27 45 211 230 178 176 211 111 163 231 188 66 28 26 45 22 107 68 113 122 118 53 209 193 76 15 155 140 107 158 114 47 209 160 231 8 217 44 49 96 215 152 71 133 33 253 49 180 174 141 80 148 89 111 203 137 167 105 163 50 110 48 6 99 231 8 137 62 99 34 188 47 220 179 64 180 178 193 187 157 196 126 66 154 249 196 63 114 255 234 72 80 112 68 226 156 25 176 130 109 238 72 54 241 191 58 82 154 145 78 158 145 232 17 125 106 192 13 119 178 80 154 17 242 145 129 3 119 226 29 229 235 251 140 144 11 40 74 51 255 27 58 102 207 187 60 249 166 1 186 183 94 61 217 26 108 17 56 67 48 137 169 210 153 145 53 61 222 138 125 115 174 39 215 166 178 33 102 206 244 235 173 169 255 91 83 127 33 85 23 242 14 140 149 177 125 63 155 103 250 0 0 0 0 73 69 78 68 174 66 96 130]
]

{ #category : 'request handling-image' }
VDMPad >> loadSelectedIcon [
	^ self
		responsePNG:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 34 0 0 0 18 8 6 0 0 0 62 61 12 111 0 0 1 60 73 68 65 84 120 94 229 85 45 147 131 48 20 236 15 143 192 32 98 16 49 17 21 8 204 9 12 162 38 2 129 192 32 16 136 24 4 38 2 19 241 68 4 102 47 64 57 104 143 251 152 222 9 102 152 73 76 150 205 219 183 217 55 92 130 32 192 17 246 229 252 66 142 32 132 69 25 90 83 67 178 29 33 19 72 21 18 126 126 33 191 20 194 175 184 213 45 104 112 112 214 160 81 49 196 114 17 79 160 116 15 59 98 206 194 104 133 36 220 114 37 50 143 15 206 193 26 13 149 149 232 95 19 18 34 213 4 83 167 115 113 127 113 222 89 180 121 4 118 47 148 166 18 130 207 223 198 133 1 85 49 194 133 91 61 115 7 192 190 34 36 76 209 80 135 155 88 207 120 82 195 244 10 17 219 179 94 249 142 139 185 208 30 87 214 32 122 69 136 248 140 177 40 223 188 51 131 136 21 116 79 147 253 126 173 29 255 200 253 171 35 114 227 136 199 53 181 80 146 175 142 44 29 255 171 35 187 25 161 53 35 226 13 157 109 145 69 12 1 155 51 226 62 50 112 231 22 241 67 190 190 207 200 104 41 104 179 13 202 43 91 147 95 181 176 163 245 195 211 212 4 28 50 111 64 30 27 188 51 181 42 30 167 98 44 174 205 244 108 3 53 40 243 226 235 169 57 255 191 230 252 66 142 46 228 29 27 193 97 65 96 175 15 82 0 0 0 0 73 69 78 68 174 66 96 130]
]

{ #category : 'request handling-html' }
VDMPad >> mainPage: aZnRequest [

	^ self responseHtml: ('<!DOCTYPE html><html>
<head>
    <title>VDMPad</title>
    <meta charset="utf-8">
        <link rel="stylesheet" href="epilog.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
        <script src="/fileSaver.js"></script>
        <style>
            body { padding: 1.5rem; background-color: #fbfbfb; font-family: Helvetica, sans-serif}
            div { font-family: Helvetica, sans-serif}
            .editor-container { 
                max-width: 56rem; margin: 0 auto; 
                background: white; border-radius: 0.25rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1); 
            }
            .cm-editor {
                font-family: Helvetica, sans-serif;
            }
            .label { font-size: 0.875rem; font-weight: bold; color: #64748b; margin-bottom: 0.5rem; }
            .editor-box { border: 1px solid #ddd; margin-bottom: 0px; border-radius: 4px; overflow: hidden; }
            .cm-vdm-error-underline { text-decoration: underline red wavy; text-underline-offset: 3px; text-decoration-thickness: 2px; }
        </style>
    </meta>
</head>
<body>
  <div id="all" style="width: 850px">
    <div id="menu" style="float: left; width: 50px">
    <img id="rootMenuIcon" src="/rootMenuOff.png" alt="root menu">
    <div id="root_menu" style="display: none; margin-top: 40px" width: 100%>
      <div id="file_items" style="margin-bottom: 20px; width: 100%;"></div>
      <img id="copyVipButton" style="cursor: pointer;" src="/copyLink.png" />
      <img id="showVipQRButton" style="cursor: pointer;" src="/copyQR.png" />
      <dialog id="vipQRDialog"></dialog>
      <div id="config" style="border: 1px solid #c0c0c0; border-radius: 5px; margin-top: 20px; margin-bottom: 20px; padding-left: 10px; width: 270px">
          Config
          <div><input id="unittestCheckbox" type="checkbox" style="padding-right: 10px" /><label>Unit testing</label></div>
          <div><input id="visualCheckbox" type="checkbox" style="padding-right: 10px" /><label>Visual Expression</label></div>
          <div><input id="sequenceDiagramCheckbox" type="checkbox" style="padding-right: 10px" /><label>Sequence Diagram</label></div>
          <div><input id="stateDiagramCheckbox" type="checkbox" style="padding-right: 10px" /><label>State Diagram</label></div>
      </div>
      <div id="epilogButton" style="padding-left: 20px; padding-right: 20px; padding-top: 5px; padding-bottom: 5px; margin-top: 15px; display: inline-block; border: 1px solid; border-radius: 6px;">
          EpiLog
      </div>
    </div>
  </div>
  <div id="main" style="float: left; width: 800px">
    <div id="title">
      <a href="/about.html" target="aboutVDMPad" style="float: left; font-size:1.0rem; font-weight: 600; color: #808080; text-decoration: none">
        VDMPad
      </a>
      <div style="float: right">
        <span style="padding-top:0.15rem; font-size: 0.6rem; color: #404040">
          powered by 
        </span>
        <a href="https://viennatalk.org/" style="text-decoration: none; font-size: 0.75rem; font-weight: 900; color: #808080" target="ViennaTalk">
          ViennaTalk
        </a>
      </div>
    </div>
    <div id="ide" style="width: 100%; float: right">
      <form method="POST" action="/eval">
        <div style="border-width: 1px; border-style: solid; border-color: black">
          <div id="source" name="source" class="editor-box shadow-sm"></div>
        </div>
        <div align=right>
          <input
            id="formatButton"
            title="Formats the source" 
            type="button" 
            value="Format" 
            style="cursor: pointer; background-color: #f4f4f4; border: 1px solid #808080; box-shadow: none; outline: none; width: 150px; height: 30px">
        </div>
        <div id="states" style="margin-top: 20px"></div>
        <div align=right>
          <input 
            id="initButton"
            title="Initializes the states" 
            type="button" 
            value="Initialize" 
            style="cursor: pointer; background-color: #f4f4f4; border: 1px solid #808080; box-shadow: none; outline: none; width: 150px; height: 30px">
        </div>
        <div id="workspace" align=right style="margin-top: 30px">
          <div style="border-width: 1px; border-style: solid; border-color: black" align=left>
            <div id="expression" class="editor-box shadow-sm"></div>
          </div>
          <input 
            id="evalButton"
            title="Evaluates the expression selected in the above textbox" 
            type="button" 
            value="evaluate" 
            style="cursor: pointer; background-color: #d0d8ff; border: 1px solid #808080; box-shadow: none; outline: none; width: 150px; height: 30px"><br>
          <input 
            id="addTestcaseButton" 
            title="Makes the previous evaluation as a testcase." 
            type="button" 
            value="make it a testcase" 
            style="visibility: hidden; cursor: pointer; background-color: #f0f0f0; border: 1px solid #808080; box-shadow: none; outline: none; width: 150px; height: 20px"><br>
          <textarea
            title="Displays the return value of the evaluation." 
            id="value" 
            name="value" 
            readonly  
            style="width: 100%; height: 50px; resize: vertical">
          </textarea>
        </div>
        <div id="valueVisual"></div>
        <div title="Displays error messages"  id="message" style="white-space: pre-wrap"></div>
        <div style="display:none" id="sequenceDiagramSection">
          Sequence Diagram
          <img id="copySequenceDiagramButton" style="float: right; display: block; cursor: pointer" src="/copy.png" />
          <div title="Sequence Diagram" id="sequenceDiagram" style="background-color: #fefefe; border: 1px solid  #c0c0c0"; display: block; justify-content: center;></div>
        </div>
        <div style="display:none" id="stateDiagramSection">
          <div>
            State Diagram
            <img id="copyStateDiagramButton" style="float: right; display: block; cursor: pointer" src="/copy.png" /><br />
          </div>
          <div title="State Diagram" id="stateDiagram" style="background-color: #fefefe; border: 1px solid #c0c0c0; display: block; justify-content: center;"></div>
        </div>
        <hr>
        <div id="unittest"></div>
      </div>
    </div>
  </div>
  <div id="EpiLogArea" style="float:left; margin-left: 60px; width: 800px;"></div>
  <script>' , (self VDMPadForVip:
			    ((self getParamsFrom: aZnRequest) at: 'vip' ifAbsent: [ nil ]))
		   , '</script>
  <script type="module" src="/VDMPad.js"></script>
</body>
</html>') withUnixLineEndings
]

{ #category : 'private' }
VDMPad >> responseBinary: aByteArray [
	^ ZnResponse ok: (ZnByteArrayEntity with: aByteArray type: ZnMimeType applicationOctetStream)
]

{ #category : 'private' }
VDMPad >> responseBinary: aByteArray mimeType: aZnMimeType [
	^ ZnResponse ok: (ZnByteArrayEntity with: aByteArray type: aZnMimeType)
]

{ #category : 'private' }
VDMPad >> responseCss: aString [
	^ ZnResponse ok: (ZnStringEntity with: aString type: ZnMimeType textCss)
]

{ #category : 'private' }
VDMPad >> responseHtml: aString [
	^ ZnResponse ok: (ZnStringEntity html: aString)
]

{ #category : 'private' }
VDMPad >> responseJS: aString [
	^ ZnResponse ok: (ZnStringEntity with: aString type: ZnMimeType applicationJavascript)
]

{ #category : 'private' }
VDMPad >> responseJSON: anObject [

	| response |
	response := ZnResponse ok: (ZnStringEntity
			             with: (String streamContents: [ :stream |
						              (NeoJSONWriter on: stream)
							              asciiOnly: true;
							              nextPut: anObject ])
			             type: ZnMimeType applicationJson).
	response headers
		at: 'Access-Control-Allow-Origin' put: '*';
		at: 'Access-Control-Allow-Headers' put: '*'.
	^ response
]

{ #category : 'private' }
VDMPad >> responseNotFound: aUrl [
	^ ZnResponse notFound: aUrl
]

{ #category : 'private' }
VDMPad >> responsePNG: aByteArray [
	^ ZnResponse ok: (ZnByteArrayEntity with: aByteArray type: ZnMimeType imagePng)
]

{ #category : 'private' }
VDMPad >> responseText: aString [
	^ ZnResponse ok: (ZnStringEntity text: aString)
]

{ #category : 'request handling-image' }
VDMPad >> rootMenuOff [
	^ self
		responsePNG:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 16 0 0 0 16 8 6 0 0 0 31 243 255 97 0 0 10 175 105 67 67 80 73 67 67 32 80 114 111 102 105 108 101 0 0 72 13 173 150 119 84 147 201 26 198 231 251 210 27 45 33 2 82 66 239 72 175 210 107 232 189 217 8 73 32 161 196 16 8 34 54 68 22 87 112 45 136 136 128 34 200 10 136 130 107 1 100 45 136 5 11 139 128 98 215 5 89 20 148 117 177 96 67 229 126 129 75 220 123 238 221 255 238 156 51 51 191 188 243 228 157 249 166 156 243 0 64 46 103 9 133 105 176 28 0 233 130 44 81 184 175 7 35 54 46 158 129 123 12 176 128 8 240 192 18 192 44 118 166 208 61 52 52 16 252 99 121 127 7 64 146 193 91 166 146 92 255 40 251 223 3 242 28 110 38 27 0 40 20 25 78 228 100 178 211 17 62 137 212 60 182 80 148 5 0 202 26 137 235 172 202 18 74 56 22 97 154 8 89 32 194 146 121 104 201 115 156 39 225 196 57 46 157 213 68 134 123 34 154 6 0 240 100 22 75 148 12 0 233 36 18 103 100 179 147 145 60 164 219 8 155 11 56 124 1 0 100 52 194 46 108 30 139 131 176 23 194 38 233 233 43 37 44 68 216 32 241 111 121 146 255 198 44 86 162 52 39 139 149 44 229 185 111 65 254 137 76 236 197 207 20 166 177 86 207 254 248 127 54 233 105 98 100 191 102 139 58 210 146 51 83 35 2 144 30 143 236 89 14 155 229 29 49 207 60 46 83 114 102 179 113 97 150 71 248 60 243 179 152 145 243 204 19 251 69 205 179 56 53 202 125 158 83 87 6 72 245 130 196 224 144 249 56 59 211 19 217 251 185 156 185 188 200 152 121 230 112 189 188 231 89 180 50 92 170 207 204 142 144 198 115 121 158 193 243 154 20 150 191 228 188 103 215 198 18 33 244 111 230 166 249 74 231 21 102 133 74 215 41 72 11 150 126 75 146 200 71 170 225 102 126 255 222 44 94 164 223 124 158 44 81 164 84 147 196 247 97 206 199 121 34 63 105 92 152 54 123 167 103 215 32 18 135 75 247 129 43 136 146 238 33 135 229 37 221 91 192 7 65 128 5 216 89 220 28 228 14 1 224 185 82 184 90 196 79 230 101 49 220 145 91 207 53 97 48 5 108 51 19 134 165 185 133 21 144 188 33 137 6 128 183 244 217 183 1 209 175 127 143 101 116 2 224 80 132 156 151 228 250 50 36 42 0 88 218 0 156 126 6 0 245 253 247 152 246 27 228 120 119 0 112 182 143 45 22 101 207 233 36 215 21 96 144 183 41 11 104 64 25 168 3 109 96 0 76 145 119 106 11 156 128 27 240 6 254 32 4 68 130 56 176 28 176 1 15 164 3 17 88 5 214 130 141 160 16 20 131 29 96 55 168 0 213 224 32 104 0 71 193 113 208 6 206 128 11 224 10 184 1 250 192 32 120 8 134 192 40 120 9 38 193 123 48 13 65 16 14 162 64 84 72 25 210 128 116 33 99 200 18 178 135 92 32 111 40 16 10 135 226 160 4 40 25 18 64 98 104 45 180 9 42 134 74 160 10 168 6 106 132 126 129 78 67 23 160 107 80 63 116 31 26 134 198 161 55 208 103 24 5 147 97 26 172 6 235 193 139 96 123 216 29 14 128 35 225 101 112 50 156 1 231 194 5 240 54 184 28 174 133 143 192 173 240 5 248 6 60 8 15 193 47 225 41 20 64 145 80 116 148 38 202 20 101 143 242 68 133 160 226 81 73 40 17 106 61 170 8 85 134 170 69 53 163 58 80 221 168 91 168 33 212 4 234 19 26 139 166 162 25 104 83 180 19 218 15 29 133 102 163 51 208 235 209 91 209 21 232 6 116 43 250 18 250 22 122 24 61 137 254 134 161 96 84 49 198 24 71 12 19 19 139 73 198 172 194 20 98 202 48 135 48 167 48 151 49 131 152 81 204 123 44 22 75 199 234 99 237 176 126 216 56 108 10 118 13 118 43 118 31 182 5 219 137 237 199 142 96 167 112 56 156 50 206 24 231 140 11 193 177 112 89 184 66 220 94 220 17 220 121 220 0 110 20 247 17 79 194 107 224 45 241 62 248 120 188 0 159 143 47 195 31 198 159 195 15 224 159 227 167 9 114 4 93 130 35 33 132 192 33 172 38 108 39 212 17 58 8 55 9 163 132 105 162 60 81 159 232 76 140 36 166 16 55 18 203 137 205 196 203 196 71 196 183 36 18 73 139 228 64 10 35 241 73 121 164 114 210 49 210 85 210 48 233 19 89 129 108 68 246 36 47 37 139 201 219 200 245 228 78 242 125 242 91 10 133 162 71 113 163 196 83 178 40 219 40 141 148 139 148 39 148 143 50 84 25 51 25 166 12 71 102 131 76 165 76 171 204 128 204 43 89 130 172 174 172 187 236 114 217 92 217 50 217 19 178 55 101 39 228 8 114 122 114 158 114 44 185 245 114 149 114 167 229 238 202 77 201 83 229 45 228 67 228 211 229 183 202 31 150 191 38 63 166 128 83 208 83 240 86 224 40 20 40 28 84 184 168 48 66 69 81 181 169 158 84 54 117 19 181 142 122 153 58 74 195 210 244 105 76 90 10 173 152 118 148 214 75 155 84 84 80 180 86 140 86 204 81 172 84 60 171 56 68 71 209 245 232 76 122 26 125 59 253 56 253 14 253 243 2 181 5 238 11 184 11 182 44 104 94 48 176 224 131 210 66 37 55 37 174 82 145 82 139 210 160 210 103 101 134 178 183 114 170 242 78 229 54 229 199 42 104 21 35 149 48 149 85 42 251 85 46 171 76 44 164 45 116 90 200 94 88 180 240 248 194 7 170 176 170 145 106 184 234 26 213 131 170 61 170 83 106 234 106 190 106 66 181 189 106 23 213 38 212 233 234 110 234 41 234 165 234 231 212 199 53 168 26 46 26 124 141 82 141 243 26 47 24 138 12 119 70 26 163 156 113 137 49 169 169 170 233 167 41 214 172 209 236 213 156 214 210 215 138 210 202 215 106 209 122 172 77 212 182 215 78 210 46 213 238 210 158 212 209 208 9 210 89 171 211 164 243 64 151 160 107 175 203 211 221 163 219 173 251 65 79 95 47 70 111 179 94 155 222 152 190 146 62 83 63 87 191 73 255 145 1 197 192 213 32 195 160 214 224 182 33 214 208 222 48 213 112 159 97 159 17 108 100 99 196 51 170 52 186 105 12 27 219 26 243 141 247 25 247 155 96 76 28 76 4 38 181 38 119 77 201 166 238 166 217 166 77 166 195 102 116 179 64 179 124 179 54 179 87 139 116 22 197 47 218 185 168 123 209 55 115 27 243 52 243 58 243 135 22 10 22 254 22 249 22 29 22 111 44 141 44 217 150 149 150 183 173 40 86 62 86 27 172 218 173 94 91 27 91 115 173 247 91 223 179 161 218 4 217 108 182 233 178 249 106 107 103 43 178 109 182 29 183 211 177 75 176 171 178 187 107 79 179 15 181 223 106 127 213 1 227 224 225 176 193 225 140 195 39 71 91 199 44 199 227 142 127 57 153 58 165 58 29 118 26 91 172 191 152 187 184 110 241 136 179 150 51 203 185 198 121 200 133 225 146 224 114 192 101 200 85 211 149 229 90 235 250 212 77 219 141 227 118 200 237 185 187 161 123 138 251 17 247 87 30 230 30 34 143 83 30 31 60 29 61 215 121 118 122 161 188 124 189 138 188 122 189 21 188 163 188 43 188 159 248 104 249 36 251 52 249 76 250 218 248 174 241 237 244 195 248 5 248 237 244 187 203 84 99 178 153 141 204 73 127 59 255 117 254 151 2 200 1 17 1 21 1 79 3 141 2 69 129 29 65 112 144 127 208 174 160 71 193 186 193 130 224 182 16 16 194 12 217 21 242 56 84 63 52 35 244 215 48 108 88 104 88 101 216 179 112 139 240 181 225 221 17 212 136 21 17 135 35 222 71 122 68 110 143 124 24 101 16 37 142 234 138 150 141 94 26 221 24 253 33 198 43 166 36 102 40 118 81 236 186 216 27 113 42 113 252 184 246 120 92 124 116 252 161 248 169 37 222 75 118 47 25 93 106 179 180 112 233 157 101 250 203 114 150 93 91 174 178 60 109 249 217 21 178 43 88 43 78 36 96 18 98 18 14 39 124 97 133 176 106 89 83 137 204 196 170 196 73 182 39 123 15 251 37 199 141 83 202 25 231 58 115 75 184 207 147 156 147 74 146 198 146 157 147 119 37 143 243 92 121 101 188 9 190 39 191 130 255 58 197 47 165 58 229 67 106 72 106 125 234 76 90 76 90 75 58 62 61 33 253 180 64 65 144 42 184 180 82 125 101 206 202 126 161 177 176 80 56 148 225 152 177 59 99 82 20 32 58 148 9 101 46 203 108 207 162 33 102 165 71 108 32 254 65 60 156 237 146 93 153 253 113 85 244 170 19 57 242 57 130 156 158 213 70 171 183 172 126 158 235 147 251 243 26 244 26 246 154 174 181 154 107 55 174 29 94 231 190 174 102 61 180 62 113 125 215 6 237 13 5 27 70 243 124 243 26 54 18 55 166 110 252 45 223 60 191 36 255 221 166 152 77 29 5 106 5 121 5 35 63 248 254 208 84 40 83 40 42 188 187 217 105 115 245 143 232 31 249 63 246 110 177 218 178 119 203 183 34 78 209 245 98 243 226 178 226 47 91 217 91 175 255 100 241 83 249 79 51 219 146 182 245 110 183 221 190 127 7 118 135 96 199 157 157 174 59 27 74 228 75 114 75 70 118 5 237 106 45 101 148 22 149 190 219 189 98 247 181 50 235 178 234 61 196 61 226 61 67 229 129 229 237 123 117 246 238 216 251 165 130 87 49 88 233 81 217 82 165 90 181 165 234 195 62 206 190 129 253 110 251 155 171 213 170 139 171 63 31 224 31 184 87 227 91 211 90 171 87 91 118 16 123 48 251 224 179 186 232 186 238 159 237 127 110 60 164 114 168 248 208 215 122 65 253 80 67 120 195 165 70 187 198 198 195 170 135 183 55 193 77 226 166 241 35 75 143 244 29 245 58 218 222 108 218 92 211 66 111 41 62 6 142 137 143 189 248 37 225 151 59 199 3 142 119 157 176 63 209 124 82 247 100 213 41 234 169 162 86 168 117 117 235 100 27 175 109 168 61 174 189 255 180 255 233 174 14 167 142 83 191 154 253 90 127 70 243 76 229 89 197 179 219 207 17 207 21 156 155 57 159 123 126 170 83 216 57 113 33 249 194 72 215 138 174 135 23 99 47 222 190 20 118 169 247 114 192 229 171 87 124 174 92 236 118 239 62 127 213 249 234 153 107 142 215 78 95 183 191 222 118 195 246 70 107 143 77 207 169 223 108 126 59 213 107 219 219 122 211 238 102 123 159 67 95 71 255 226 254 115 3 174 3 23 110 121 221 186 114 155 121 251 198 96 240 96 255 157 168 59 247 238 46 189 59 116 143 115 111 236 126 218 253 215 15 178 31 76 63 204 123 132 121 84 244 88 238 113 217 19 213 39 181 191 27 254 222 50 100 59 116 118 216 107 184 231 105 196 211 135 35 236 145 151 127 100 254 241 101 180 224 25 229 89 217 115 141 231 141 99 150 99 103 198 125 198 251 94 44 121 49 250 82 248 114 122 162 240 79 249 63 171 94 25 188 58 249 151 219 95 61 147 177 147 163 175 69 175 103 222 108 125 171 252 182 254 157 245 187 174 169 208 169 39 239 211 223 79 127 40 250 168 252 177 225 147 253 167 238 207 49 159 159 79 175 250 130 251 82 254 213 240 107 199 183 128 111 143 102 210 103 102 132 44 17 107 214 11 160 144 22 78 74 2 224 77 61 0 148 56 196 59 244 1 64 148 153 243 184 179 10 104 206 151 35 44 241 231 179 30 253 191 121 206 7 207 234 109 1 168 119 3 32 42 15 128 192 78 0 246 35 85 23 97 50 210 75 236 90 164 27 128 173 172 164 21 137 72 74 102 146 149 229 44 64 100 17 98 77 62 206 204 188 85 3 0 215 1 192 87 209 204 204 244 190 153 153 175 117 136 23 191 15 64 103 198 156 183 150 168 177 114 0 28 80 144 80 143 250 122 73 247 31 229 95 114 244 240 233 55 163 56 236 0 0 0 9 112 72 89 115 0 0 11 19 0 0 11 19 1 0 154 156 24 0 0 1 155 105 84 88 116 88 77 76 58 99 111 109 46 97 100 111 98 101 46 120 109 112 0 0 0 0 0 60 120 58 120 109 112 109 101 116 97 32 120 109 108 110 115 58 120 61 34 97 100 111 98 101 58 110 115 58 109 101 116 97 47 34 32 120 58 120 109 112 116 107 61 34 88 77 80 32 67 111 114 101 32 53 46 49 46 50 34 62 10 32 32 32 60 114 100 102 58 82 68 70 32 120 109 108 110 115 58 114 100 102 61 34 104 116 116 112 58 47 47 119 119 119 46 119 51 46 111 114 103 47 49 57 57 57 47 48 50 47 50 50 45 114 100 102 45 115 121 110 116 97 120 45 110 115 35 34 62 10 32 32 32 32 32 32 60 114 100 102 58 68 101 115 99 114 105 112 116 105 111 110 32 114 100 102 58 97 98 111 117 116 61 34 34 10 32 32 32 32 32 32 32 32 32 32 32 32 120 109 108 110 115 58 101 120 105 102 61 34 104 116 116 112 58 47 47 110 115 46 97 100 111 98 101 46 99 111 109 47 101 120 105 102 47 49 46 48 47 34 62 10 32 32 32 32 32 32 32 32 32 60 101 120 105 102 58 80 105 120 101 108 88 68 105 109 101 110 115 105 111 110 62 49 54 60 47 101 120 105 102 58 80 105 120 101 108 88 68 105 109 101 110 115 105 111 110 62 10 32 32 32 32 32 32 32 32 32 60 101 120 105 102 58 80 105 120 101 108 89 68 105 109 101 110 115 105 111 110 62 49 54 60 47 101 120 105 102 58 80 105 120 101 108 89 68 105 109 101 110 115 105 111 110 62 10 32 32 32 32 32 32 60 47 114 100 102 58 68 101 115 99 114 105 112 116 105 111 110 62 10 32 32 32 60 47 114 100 102 58 82 68 70 62 10 60 47 120 58 120 109 112 109 101 116 97 62 10 63 39 231 132 0 0 0 60 73 68 65 84 56 17 99 12 11 11 251 207 200 200 200 0 2 132 104 108 106 88 64 130 43 86 172 128 152 0 226 144 0 226 226 226 254 51 145 160 30 171 210 81 3 24 24 70 195 96 52 12 64 153 131 145 210 236 12 0 46 89 8 95 77 129 151 73 0 0 0 0 73 69 78 68 174 66 96 130]
]

{ #category : 'request handling-image' }
VDMPad >> rootMenuOn [
	^ self
		responsePNG:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 16 0 0 0 16 8 2 0 0 0 144 145 104 54 0 0 10 175 105 67 67 80 73 67 67 32 80 114 111 102 105 108 101 0 0 72 13 173 150 119 84 147 201 26 198 231 251 210 27 45 33 2 82 66 239 72 175 210 107 232 189 217 8 73 32 161 196 16 8 34 54 68 22 87 112 45 136 136 128 34 200 10 136 130 107 1 100 45 136 5 11 139 128 98 215 5 89 20 148 117 177 96 67 229 126 129 75 220 123 238 221 255 238 156 51 51 191 188 243 228 157 249 166 156 243 0 64 46 103 9 133 105 176 28 0 233 130 44 81 184 175 7 35 54 46 158 129 123 12 176 128 8 240 192 18 192 44 118 166 208 61 52 52 16 252 99 121 127 7 64 146 193 91 166 146 92 255 40 251 223 3 242 28 110 38 27 0 40 20 25 78 228 100 178 211 17 62 137 212 60 182 80 148 5 0 202 26 137 235 172 202 18 74 56 22 97 154 8 89 32 194 146 121 104 201 115 156 39 225 196 57 46 157 213 68 134 123 34 154 6 0 240 100 22 75 148 12 0 233 36 18 103 100 179 147 145 60 164 219 8 155 11 56 124 1 0 100 52 194 46 108 30 139 131 176 23 194 38 233 233 43 37 44 68 216 32 241 111 121 146 255 198 44 86 162 52 39 139 149 44 229 185 111 65 254 137 76 236 197 207 20 166 177 86 207 254 248 127 54 233 105 98 100 191 102 139 58 210 146 51 83 35 2 144 30 143 236 89 14 155 229 29 49 207 60 46 83 114 102 179 113 97 150 71 248 60 243 179 152 145 243 204 19 251 69 205 179 56 53 202 125 158 83 87 6 72 245 130 196 224 144 249 56 59 211 19 217 251 185 156 185 188 200 152 121 230 112 189 188 231 89 180 50 92 170 207 204 142 144 198 115 121 158 193 243 154 20 150 191 228 188 103 215 198 18 33 244 111 230 166 249 74 231 21 102 133 74 215 41 72 11 150 126 75 146 200 71 170 225 102 126 255 222 44 94 164 223 124 158 44 81 164 84 147 196 247 97 206 199 121 34 63 105 92 152 54 123 167 103 215 32 18 135 75 247 129 43 136 146 238 33 135 229 37 221 91 192 7 65 128 5 216 89 220 28 228 14 1 224 185 82 184 90 196 79 230 101 49 220 145 91 207 53 97 48 5 108 51 19 134 165 185 133 21 144 188 33 137 6 128 183 244 217 183 1 209 175 127 143 101 116 2 224 80 132 156 151 228 250 50 36 42 0 88 218 0 156 126 6 0 245 253 247 152 246 27 228 120 119 0 112 182 143 45 22 101 207 233 36 215 21 96 144 183 41 11 104 64 25 168 3 109 96 0 76 145 119 106 11 156 128 27 240 6 254 32 4 68 130 56 176 28 176 1 15 164 3 17 88 5 214 130 141 160 16 20 131 29 96 55 168 0 213 224 32 104 0 71 193 113 208 6 206 128 11 224 10 184 1 250 192 32 120 8 134 192 40 120 9 38 193 123 48 13 65 16 14 162 64 84 72 25 210 128 116 33 99 200 18 178 135 92 32 111 40 16 10 135 226 160 4 40 25 18 64 98 104 45 180 9 42 134 74 160 10 168 6 106 132 126 129 78 67 23 160 107 80 63 116 31 26 134 198 161 55 208 103 24 5 147 97 26 172 6 235 193 139 96 123 216 29 14 128 35 225 101 112 50 156 1 231 194 5 240 54 184 28 174 133 143 192 173 240 5 248 6 60 8 15 193 47 225 41 20 64 145 80 116 148 38 202 20 101 143 242 68 133 160 226 81 73 40 17 106 61 170 8 85 134 170 69 53 163 58 80 221 168 91 168 33 212 4 234 19 26 139 166 162 25 104 83 180 19 218 15 29 133 102 163 51 208 235 209 91 209 21 232 6 116 43 250 18 250 22 122 24 61 137 254 134 161 96 84 49 198 24 71 12 19 19 139 73 198 172 194 20 98 202 48 135 48 167 48 151 49 131 152 81 204 123 44 22 75 199 234 99 237 176 126 216 56 108 10 118 13 118 43 118 31 182 5 219 137 237 199 142 96 167 112 56 156 50 206 24 231 140 11 193 177 112 89 184 66 220 94 220 17 220 121 220 0 110 20 247 17 79 194 107 224 45 241 62 248 120 188 0 159 143 47 195 31 198 159 195 15 224 159 227 167 9 114 4 93 130 35 33 132 192 33 172 38 108 39 212 17 58 8 55 9 163 132 105 162 60 81 159 232 76 140 36 166 16 55 18 203 137 205 196 203 196 71 196 183 36 18 73 139 228 64 10 35 241 73 121 164 114 210 49 210 85 210 48 233 19 89 129 108 68 246 36 47 37 139 201 219 200 245 228 78 242 125 242 91 10 133 162 71 113 163 196 83 178 40 219 40 141 148 139 148 39 148 143 50 84 25 51 25 166 12 71 102 131 76 165 76 171 204 128 204 43 89 130 172 174 172 187 236 114 217 92 217 50 217 19 178 55 101 39 228 8 114 122 114 158 114 44 185 245 114 149 114 167 229 238 202 77 201 83 229 45 228 67 228 211 229 183 202 31 150 191 38 63 166 128 83 208 83 240 86 224 40 20 40 28 84 184 168 48 66 69 81 181 169 158 84 54 117 19 181 142 122 153 58 74 195 210 244 105 76 90 10 173 152 118 148 214 75 155 84 84 80 180 86 140 86 204 81 172 84 60 171 56 68 71 209 245 232 76 122 26 125 59 253 56 253 14 253 243 2 181 5 238 11 184 11 182 44 104 94 48 176 224 131 210 66 37 55 37 174 82 145 82 139 210 160 210 103 101 134 178 183 114 170 242 78 229 54 229 199 42 104 21 35 149 48 149 85 42 251 85 46 171 76 44 164 45 116 90 200 94 88 180 240 248 194 7 170 176 170 145 106 184 234 26 213 131 170 61 170 83 106 234 106 190 106 66 181 189 106 23 213 38 212 233 234 110 234 41 234 165 234 231 212 199 53 168 26 46 26 124 141 82 141 243 26 47 24 138 12 119 70 26 163 156 113 137 49 169 169 170 233 167 41 214 172 209 236 213 156 214 210 215 138 210 202 215 106 209 122 172 77 212 182 215 78 210 46 213 238 210 158 212 209 208 9 210 89 171 211 164 243 64 151 160 107 175 203 211 221 163 219 173 251 65 79 95 47 70 111 179 94 155 222 152 190 146 62 83 63 87 191 73 255 145 1 197 192 213 32 195 160 214 224 182 33 214 208 222 48 213 112 159 97 159 17 108 100 99 196 51 170 52 186 105 12 27 219 26 243 141 247 25 247 155 96 76 28 76 4 38 181 38 119 77 201 166 238 166 217 166 77 166 195 102 116 179 64 179 124 179 54 179 87 139 116 22 197 47 218 185 168 123 209 55 115 27 243 52 243 58 243 135 22 10 22 254 22 249 22 29 22 111 44 141 44 217 150 149 150 183 173 40 86 62 86 27 172 218 173 94 91 27 91 115 173 247 91 223 179 161 218 4 217 108 182 233 178 249 106 107 103 43 178 109 182 29 183 211 177 75 176 171 178 187 107 79 179 15 181 223 106 127 213 1 227 224 225 176 193 225 140 195 39 71 91 199 44 199 227 142 127 57 153 58 165 58 29 118 26 91 172 191 152 187 184 110 241 136 179 150 51 203 185 198 121 200 133 225 146 224 114 192 101 200 85 211 149 229 90 235 250 212 77 219 141 227 118 200 237 185 187 161 123 138 251 17 247 87 30 230 30 34 143 83 30 31 60 29 61 215 121 118 122 161 188 124 189 138 188 122 189 21 188 163 188 43 188 159 248 104 249 36 251 52 249 76 250 218 248 174 241 237 244 195 248 5 248 237 244 187 203 84 99 178 153 141 204 73 127 59 255 117 254 151 2 200 1 17 1 21 1 79 3 141 2 69 129 29 65 112 144 127 208 174 160 71 193 186 193 130 224 182 16 16 194 12 217 21 242 56 84 63 52 35 244 215 48 108 88 104 88 101 216 179 112 139 240 181 225 221 17 212 136 21 17 135 35 222 71 122 68 110 143 124 24 101 16 37 142 234 138 150 141 94 26 221 24 253 33 198 43 166 36 102 40 118 81 236 186 216 27 113 42 113 252 184 246 120 92 124 116 252 161 248 169 37 222 75 118 47 25 93 106 179 180 112 233 157 101 250 203 114 150 93 91 174 178 60 109 249 217 21 178 43 88 43 78 36 96 18 98 18 14 39 124 97 133 176 106 89 83 137 204 196 170 196 73 182 39 123 15 251 37 199 141 83 202 25 231 58 115 75 184 207 147 156 147 74 146 198 146 157 147 119 37 143 243 92 121 101 188 9 190 39 191 130 255 58 197 47 165 58 229 67 106 72 106 125 234 76 90 76 90 75 58 62 61 33 253 180 64 65 144 42 184 180 82 125 101 206 202 126 161 177 176 80 56 148 225 152 177 59 99 82 20 32 58 148 9 101 46 203 108 207 162 33 102 165 71 108 32 254 65 60 156 237 146 93 153 253 113 85 244 170 19 57 242 57 130 156 158 213 70 171 183 172 126 158 235 147 251 243 26 244 26 246 154 174 181 154 107 55 174 29 94 231 190 174 102 61 180 62 113 125 215 6 237 13 5 27 70 243 124 243 26 54 18 55 166 110 252 45 223 60 191 36 255 221 166 152 77 29 5 106 5 121 5 35 63 248 254 208 84 40 83 40 42 188 187 217 105 115 245 143 232 31 249 63 246 110 177 218 178 119 203 183 34 78 209 245 98 243 226 178 226 47 91 217 91 175 255 100 241 83 249 79 51 219 146 182 245 110 183 221 190 127 7 118 135 96 199 157 157 174 59 27 74 228 75 114 75 70 118 5 237 106 45 101 148 22 149 190 219 189 98 247 181 50 235 178 234 61 196 61 226 61 67 229 129 229 237 123 117 246 238 216 251 165 130 87 49 88 233 81 217 82 165 90 181 165 234 195 62 206 190 129 253 110 251 155 171 213 170 139 171 63 31 224 31 184 87 227 91 211 90 171 87 91 118 16 123 48 251 224 179 186 232 186 238 159 237 127 110 60 164 114 168 248 208 215 122 65 253 80 67 120 195 165 70 187 198 198 195 170 135 183 55 193 77 226 166 241 35 75 143 244 29 245 58 218 222 108 218 92 211 66 111 41 62 6 142 137 143 189 248 37 225 151 59 199 3 142 119 157 176 63 209 124 82 247 100 213 41 234 169 162 86 168 117 117 235 100 27 175 109 168 61 174 189 255 180 255 233 174 14 167 142 83 191 154 253 90 127 70 243 76 229 89 197 179 219 207 17 207 21 156 155 57 159 123 126 170 83 216 57 113 33 249 194 72 215 138 174 135 23 99 47 222 190 20 118 169 247 114 192 229 171 87 124 174 92 236 118 239 62 127 213 249 234 153 107 142 215 78 95 183 191 222 118 195 246 70 107 143 77 207 169 223 108 126 59 213 107 219 219 122 211 238 102 123 159 67 95 71 255 226 254 115 3 174 3 23 110 121 221 186 114 155 121 251 198 96 240 96 255 157 168 59 247 238 46 189 59 116 143 115 111 236 126 218 253 215 15 178 31 76 63 204 123 132 121 84 244 88 238 113 217 19 213 39 181 191 27 254 222 50 100 59 116 118 216 107 184 231 105 196 211 135 35 236 145 151 127 100 254 241 101 180 224 25 229 89 217 115 141 231 141 99 150 99 103 198 125 198 251 94 44 121 49 250 82 248 114 122 162 240 79 249 63 171 94 25 188 58 249 151 219 95 61 147 177 147 163 175 69 175 103 222 108 125 171 252 182 254 157 245 187 174 169 208 169 39 239 211 223 79 127 40 250 168 252 177 225 147 253 167 238 207 49 159 159 79 175 250 130 251 82 254 213 240 107 199 183 128 111 143 102 210 103 102 132 44 17 107 214 11 160 144 22 78 74 2 224 77 61 0 148 56 196 59 244 1 64 148 153 243 184 179 10 104 206 151 35 44 241 231 179 30 253 191 121 206 7 207 234 109 1 168 119 3 32 42 15 128 192 78 0 246 35 85 23 97 50 210 75 236 90 164 27 128 173 172 164 21 137 72 74 102 146 149 229 44 64 100 17 98 77 62 206 204 188 85 3 0 215 1 192 87 209 204 204 244 190 153 153 175 117 136 23 191 15 64 103 198 156 183 150 168 177 114 0 28 80 144 80 143 250 122 73 247 31 229 95 114 244 240 233 55 163 56 236 0 0 0 9 112 72 89 115 0 0 11 19 0 0 11 19 1 0 154 156 24 0 0 1 155 105 84 88 116 88 77 76 58 99 111 109 46 97 100 111 98 101 46 120 109 112 0 0 0 0 0 60 120 58 120 109 112 109 101 116 97 32 120 109 108 110 115 58 120 61 34 97 100 111 98 101 58 110 115 58 109 101 116 97 47 34 32 120 58 120 109 112 116 107 61 34 88 77 80 32 67 111 114 101 32 53 46 49 46 50 34 62 10 32 32 32 60 114 100 102 58 82 68 70 32 120 109 108 110 115 58 114 100 102 61 34 104 116 116 112 58 47 47 119 119 119 46 119 51 46 111 114 103 47 49 57 57 57 47 48 50 47 50 50 45 114 100 102 45 115 121 110 116 97 120 45 110 115 35 34 62 10 32 32 32 32 32 32 60 114 100 102 58 68 101 115 99 114 105 112 116 105 111 110 32 114 100 102 58 97 98 111 117 116 61 34 34 10 32 32 32 32 32 32 32 32 32 32 32 32 120 109 108 110 115 58 101 120 105 102 61 34 104 116 116 112 58 47 47 110 115 46 97 100 111 98 101 46 99 111 109 47 101 120 105 102 47 49 46 48 47 34 62 10 32 32 32 32 32 32 32 32 32 60 101 120 105 102 58 80 105 120 101 108 88 68 105 109 101 110 115 105 111 110 62 49 54 60 47 101 120 105 102 58 80 105 120 101 108 88 68 105 109 101 110 115 105 111 110 62 10 32 32 32 32 32 32 32 32 32 60 101 120 105 102 58 80 105 120 101 108 89 68 105 109 101 110 115 105 111 110 62 49 54 60 47 101 120 105 102 58 80 105 120 101 108 89 68 105 109 101 110 115 105 111 110 62 10 32 32 32 32 32 32 60 47 114 100 102 58 68 101 115 99 114 105 112 116 105 111 110 62 10 32 32 32 60 47 114 100 102 58 82 68 70 62 10 60 47 120 58 120 109 112 109 101 116 97 62 10 63 39 231 132 0 0 0 37 73 68 65 84 40 21 99 12 11 11 99 100 100 100 96 96 192 69 162 73 49 1 249 36 129 81 13 196 4 215 104 40 13 142 80 2 0 134 180 1 55 7 243 163 188 0 0 0 0 73 69 78 68 174 66 96 130]
]

{ #category : 'request handling-image' }
VDMPad >> saveIcon [
	^ self
		responsePNG:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 34 0 0 0 18 8 6 0 0 0 62 61 12 111 0 0 1 241 73 68 65 84 120 94 229 148 33 112 163 64 20 134 35 91 71 93 34 57 71 220 226 54 146 56 234 18 7 50 231 56 151 184 156 4 151 186 212 165 146 56 226 168 11 146 56 226 136 3 73 28 113 123 238 191 7 108 143 92 103 152 171 234 244 38 204 32 216 229 127 239 127 31 255 210 3 190 198 213 195 237 27 249 31 140 148 201 22 115 83 71 95 121 128 162 124 131 102 216 88 197 151 79 54 82 30 48 103 67 204 252 19 202 122 65 160 72 15 216 167 191 62 217 72 246 12 67 179 17 150 29 111 150 17 92 107 4 181 223 208 98 150 135 125 33 165 155 71 176 217 43 90 169 64 178 28 129 47 143 242 241 132 96 57 5 171 180 253 33 204 249 14 169 232 50 34 14 88 178 1 21 124 130 31 30 145 22 239 72 16 177 32 56 32 171 187 157 17 206 117 104 212 188 246 146 189 192 100 223 219 33 170 90 124 4 55 169 106 92 176 119 116 48 71 54 39 83 254 76 7 119 143 16 93 25 17 89 132 245 220 38 50 3 220 245 238 161 26 11 248 29 159 70 164 30 56 91 32 174 171 229 240 39 58 172 224 220 236 197 11 112 195 107 26 151 175 176 180 41 252 226 74 155 252 4 231 30 18 241 129 83 35 202 35 124 154 68 53 95 144 73 220 89 232 193 226 67 25 230 123 220 169 63 164 17 160 240 9 189 181 35 66 23 196 68 203 88 157 154 137 171 79 78 239 42 181 230 234 214 90 237 63 143 175 72 159 96 48 41 40 118 52 217 24 174 60 69 53 145 235 98 180 63 97 52 121 26 193 97 99 172 223 72 86 58 90 15 138 143 134 181 136 176 241 163 54 27 34 71 72 129 211 38 219 134 72 182 133 169 202 6 162 201 136 162 94 79 117 70 96 13 193 173 49 52 243 89 82 132 204 8 5 183 10 104 249 70 59 71 28 159 80 118 29 223 181 243 8 174 14 26 116 148 110 131 130 187 47 218 130 241 106 10 141 246 250 68 198 113 41 7 236 111 188 69 104 67 237 61 192 220 228 239 208 230 8 92 251 79 237 74 63 91 69 29 70 110 255 23 127 251 70 190 184 145 223 102 223 179 244 143 251 227 64 0 0 0 0 73 69 78 68 174 66 96 130]
]

{ #category : 'request handling-image' }
VDMPad >> saveSelectedIcon [
	^ self
		responsePNG:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 34 0 0 0 18 8 6 0 0 0 62 61 12 111 0 0 1 204 73 68 65 84 120 94 229 148 161 147 181 32 20 197 247 15 39 88 8 20 2 133 96 48 88 8 150 23 44 4 131 193 98 48 24 40 6 11 129 98 32 24 44 231 187 138 251 61 119 103 156 221 180 179 59 47 16 4 238 229 156 31 7 223 178 44 195 111 24 111 175 47 228 79 8 17 185 65 59 123 108 235 138 117 93 16 39 135 70 139 31 22 34 52 90 31 209 27 9 113 204 49 112 169 81 74 246 195 66 212 3 83 116 40 196 205 102 81 194 186 128 101 75 180 188 179 40 121 90 83 245 12 223 23 167 129 100 34 239 2 66 151 167 111 38 81 117 35 252 94 187 69 204 109 5 201 238 132 48 141 206 111 212 176 129 41 114 72 254 137 4 17 171 42 13 117 8 229 40 90 143 72 135 243 195 68 141 217 247 79 19 123 175 16 96 243 189 135 64 57 120 248 225 60 156 68 153 222 35 216 28 236 46 35 76 149 120 180 142 200 108 0 34 150 169 133 185 185 26 38 45 130 111 161 15 103 10 102 244 112 21 79 107 186 69 152 108 58 88 20 112 113 132 225 151 218 188 67 8 22 57 251 198 171 97 34 135 33 39 203 92 67 157 184 85 97 225 66 60 195 76 90 151 225 20 146 129 27 66 239 42 34 36 160 137 214 212 200 228 120 191 114 218 187 30 53 151 17 159 181 95 62 95 38 27 76 254 44 224 21 57 155 96 207 87 116 16 185 54 163 245 209 147 115 89 98 240 19 30 239 36 247 58 154 175 248 119 195 202 75 212 166 124 102 131 41 20 20 184 56 154 68 68 25 204 203 121 0 75 25 89 151 171 43 142 202 69 4 55 33 206 143 147 98 118 102 132 130 187 7 84 188 211 86 208 90 94 194 253 233 249 62 134 25 97 217 18 58 74 247 68 193 45 249 179 161 110 70 68 90 219 136 204 96 41 7 254 35 94 94 56 44 88 49 215 234 163 99 50 85 89 247 191 247 94 223 55 229 141 144 215 255 197 191 190 144 95 46 228 31 219 214 96 11 162 24 27 201 0 0 0 0 73 69 78 68 174 66 96 130]
]

{ #category : 'request handling-image' }
VDMPad >> saveTransparentIcon [
	^ self
		responsePNG:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 34 0 0 0 18 8 6 0 0 0 62 61 12 111 0 0 0 6 98 75 71 68 0 255 0 255 0 255 160 189 167 147 0 0 0 9 112 72 89 115 0 0 11 19 0 0 11 19 1 0 154 156 24 0 0 0 7 116 73 77 69 7 221 8 27 23 15 58 141 225 78 134 0 0 2 51 73 68 65 84 72 199 237 149 47 116 218 64 28 199 127 157 25 117 201 84 144 116 42 184 48 21 100 112 212 21 23 230 50 199 28 56 38 193 129 163 174 200 108 42 76 81 87 234 136 3 7 83 105 93 152 74 166 46 83 159 137 48 254 236 181 117 219 235 222 235 189 247 19 119 239 238 247 253 115 247 125 119 2 200 115 24 175 228 153 140 23 34 79 18 73 151 95 232 156 191 163 168 191 65 215 223 82 174 189 103 24 254 248 55 143 8 200 43 9 105 91 101 60 127 77 2 103 160 36 94 133 220 172 50 118 123 254 98 237 39 209 37 142 217 100 154 240 48 112 50 163 231 86 41 25 58 154 118 134 229 246 185 137 243 189 209 213 57 150 119 189 21 128 128 146 69 183 138 221 93 230 189 212 154 160 219 192 50 116 52 163 76 189 61 97 165 142 113 246 64 42 164 107 21 177 188 33 254 116 201 42 254 195 137 36 36 8 66 162 4 96 195 180 93 193 244 174 137 1 162 49 117 235 195 94 132 10 233 218 85 122 139 12 72 229 166 85 193 106 109 193 213 26 223 171 96 247 150 168 7 137 128 168 104 198 168 221 196 49 139 20 228 148 146 211 193 127 228 106 212 170 143 109 117 152 43 128 59 252 139 10 110 176 1 16 53 239 96 59 253 28 56 185 198 53 27 248 241 222 1 181 248 132 109 247 89 28 184 242 232 157 169 100 137 223 170 80 170 143 137 0 80 18 77 251 184 118 25 67 211 209 180 83 10 165 143 91 34 72 236 55 176 220 9 49 41 243 118 5 103 176 206 21 71 151 56 218 41 154 166 31 151 185 63 251 36 145 92 245 16 199 218 30 136 39 184 102 141 222 60 101 231 200 97 179 120 194 133 213 192 95 205 104 89 53 70 191 157 140 39 184 86 131 32 230 201 71 191 143 239 230 150 241 231 91 214 155 159 121 92 179 123 102 126 32 113 169 42 70 65 68 84 38 105 38 162 105 5 145 236 59 179 113 32 235 236 32 126 70 85 154 230 90 70 189 190 204 138 23 82 55 95 111 215 157 19 175 26 203 96 240 85 214 169 32 34 146 165 247 132 225 55 82 145 179 7 227 59 106 157 99 151 138 185 117 70 25 199 27 238 146 1 169 204 7 13 76 77 199 48 107 180 122 29 108 235 216 222 120 218 164 36 58 245 171 187 99 245 234 142 160 215 220 245 54 204 26 222 96 118 144 50 228 228 229 211 123 33 242 191 16 249 5 21 100 218 229 151 74 60 187 0 0 0 0 73 69 78 68 174 66 96 130]
]

{ #category : 'request handling-api' }
VDMPad >> test: anHttpRequest [
	| json vdm10 rtc source prestates expression expectedPoststates expectedValue states triple actualValue actualPoststates diff |
	json := NeoJSONReader fromString: anHttpRequest contents.
	vdm10 := (json at: 'classic' ifAbsent: [ false ]) = false.
	rtc := (json at: 'ignoreRuntimeChecking' ifAbsent: [ false ]) = false.
	source := json at: 'source'.
	prestates := json at: 'prestates' ifAbsent: [ Dictionary new ].
	expression := ((json at: 'expression' ifAbsent: [ String new ]) copyReplaceAll: String cr with: ' ')
		copyReplaceAll: String lf
		with: ' '.
	expectedValue := json at: 'value' ifAbsent: [  ].
	expectedPoststates := json at: 'poststates' ifAbsent: [  ].
	states := Dictionary new.
	prestates
		keysAndValuesDo: [ :key :value | 
			((key includes: $`) and: [ value trim notEmpty ])
				ifTrue: [ 
					(states at: (key copyFrom: 1 to: (key indexOf: $`) - 1) ifAbsentPut: [ Dictionary new ])
						at: (key copyFrom: (key indexOf: $`) + 1 to: key size)
						put: ((value copyReplaceAll: String cr with: ' ') copyReplaceAll: String lf with: ' ') ].
			prestates add: key -> value ].
	triple := self engine
		evaluate: expression
		specification: source
		states: states.
	diff := Array new writeStream.
	actualValue := triple first.
	actualValue
		ifNil: [ diff nextPut: triple third ]
		ifNotNil: [ 
			actualValue ~= expectedValue
				ifTrue: [ diff nextPut: 'RESUT=' , actualValue , ' (excepted ' , expectedValue , ')' ].
			actualPoststates := Dictionary new.
			triple second
				keysAndValuesDo: [ :moduleName :bindings | bindings keysAndValuesDo: [ :var :val | actualPoststates at: moduleName , '`' , var put: val ] ].
			expectedPoststates
				keysAndValuesDo: [ :key :value | 
					| actual |
					actual := actualPoststates at: key ifAbsent: [  ].
					actual ~= value
						ifTrue: [ diff nextPut: key , '=' , actual , ' (expected ' , value , ')' ] ] ].
	diff := diff contents.
	^ self responseJSON: (diff ifEmpty: [ true ] ifNotEmpty: [ diff ])
]

{ #category : 'request handling-api' }
VDMPad >> vdm2html: aZnRequest [
	^ self
		responseHtml:
			(aZnRequest contents
				ifNil: [ String new ]
				ifNotNil: [ :contents | contents trimmed ifEmpty: [ String new ] ifNotEmpty: [ :value | VDMValue2HtmlDiagram current vdmToHtml: value ] ])
]

{ #category : 'request handling-image' }
VDMPad >> vdmpadIcon [
	^ self
		responsePNG:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 32 0 0 0 32 8 6 0 0 0 115 122 122 244 0 0 0 1 115 82 71 66 0 174 206 28 233 0 0 0 9 112 72 89 115 0 0 11 19 0 0 11 19 1 0 154 156 24 0 0 1 89 105 84 88 116 88 77 76 58 99 111 109 46 97 100 111 98 101 46 120 109 112 0 0 0 0 0 60 120 58 120 109 112 109 101 116 97 32 120 109 108 110 115 58 120 61 34 97 100 111 98 101 58 110 115 58 109 101 116 97 47 34 32 120 58 120 109 112 116 107 61 34 88 77 80 32 67 111 114 101 32 53 46 52 46 48 34 62 10 32 32 32 60 114 100 102 58 82 68 70 32 120 109 108 110 115 58 114 100 102 61 34 104 116 116 112 58 47 47 119 119 119 46 119 51 46 111 114 103 47 49 57 57 57 47 48 50 47 50 50 45 114 100 102 45 115 121 110 116 97 120 45 110 115 35 34 62 10 32 32 32 32 32 32 60 114 100 102 58 68 101 115 99 114 105 112 116 105 111 110 32 114 100 102 58 97 98 111 117 116 61 34 34 10 32 32 32 32 32 32 32 32 32 32 32 32 120 109 108 110 115 58 116 105 102 102 61 34 104 116 116 112 58 47 47 110 115 46 97 100 111 98 101 46 99 111 109 47 116 105 102 102 47 49 46 48 47 34 62 10 32 32 32 32 32 32 32 32 32 60 116 105 102 102 58 79 114 105 101 110 116 97 116 105 111 110 62 49 60 47 116 105 102 102 58 79 114 105 101 110 116 97 116 105 111 110 62 10 32 32 32 32 32 32 60 47 114 100 102 58 68 101 115 99 114 105 112 116 105 111 110 62 10 32 32 32 60 47 114 100 102 58 82 68 70 62 10 60 47 120 58 120 109 112 109 101 116 97 62 10 76 194 39 89 0 0 6 90 73 68 65 84 88 9 93 215 201 203 206 109 20 7 240 243 60 207 109 158 231 153 18 37 202 92 40 11 89 177 177 144 149 34 101 99 201 127 192 142 133 236 148 108 40 69 162 36 115 34 74 153 21 25 66 230 41 67 145 121 124 222 251 115 94 231 237 238 61 245 123 126 215 239 124 207 249 158 233 186 174 155 182 103 207 158 117 246 232 209 35 126 255 254 29 63 127 254 140 110 221 186 197 143 31 63 130 174 189 189 61 126 253 250 149 88 52 165 75 151 46 241 245 235 215 196 251 244 233 19 157 157 157 212 209 181 107 215 248 243 231 79 218 126 255 254 61 121 122 246 236 153 111 28 29 29 29 137 177 251 246 237 91 242 193 191 124 249 18 13 4 103 206 156 137 89 179 102 69 255 254 253 227 198 141 27 241 233 211 167 184 116 233 82 52 26 141 232 213 171 87 44 89 178 36 94 189 122 21 119 238 220 137 165 75 151 102 176 83 167 78 101 66 31 63 126 140 71 143 30 101 144 249 243 231 199 148 41 83 50 49 129 36 40 49 129 217 221 187 119 47 166 77 155 150 73 40 132 180 171 244 246 237 219 113 245 234 213 116 56 112 224 64 220 189 123 55 147 88 188 120 113 118 97 199 142 29 241 224 193 131 216 186 117 107 188 126 253 58 237 118 237 218 21 23 47 94 140 203 151 47 199 140 25 51 98 246 236 217 177 125 251 246 120 247 238 93 234 112 84 229 236 206 159 63 31 231 206 157 203 234 117 69 113 240 134 76 230 204 153 147 93 152 52 105 82 102 59 102 204 152 108 243 196 137 19 99 248 240 225 177 113 227 198 248 240 225 67 76 152 48 33 174 93 187 22 112 221 26 60 120 112 124 254 252 57 222 191 127 159 221 160 59 123 246 108 86 248 252 249 243 108 241 149 43 87 98 208 160 65 113 253 250 245 24 56 112 96 118 196 136 107 28 237 218 32 176 249 31 63 126 60 38 79 158 156 100 53 95 115 175 86 106 239 253 251 247 51 137 169 83 167 70 91 91 91 86 164 181 111 222 188 137 213 171 87 199 208 161 67 115 159 72 64 215 4 91 181 106 85 44 91 182 44 247 151 234 5 183 231 112 183 107 133 71 85 135 15 31 14 115 212 21 132 102 187 111 223 190 220 7 125 251 246 205 138 17 170 74 119 84 111 211 218 23 203 151 47 143 33 67 134 196 209 163 71 115 206 163 71 143 86 91 118 227 201 147 39 113 235 214 173 236 136 4 20 107 111 144 142 181 107 215 174 167 28 48 96 64 244 235 215 47 55 163 111 14 42 80 229 138 21 43 114 47 8 48 126 252 248 24 49 98 68 140 29 59 54 122 247 238 157 235 145 35 71 38 153 66 84 101 76 54 239 176 97 195 98 250 244 233 113 236 216 177 172 218 70 231 235 164 84 135 219 94 190 124 153 103 73 32 155 66 133 68 101 8 25 202 88 203 106 110 48 58 193 84 194 87 215 248 211 57 186 108 72 181 154 61 193 95 58 133 182 53 219 211 201 9 9 169 22 229 199 223 63 136 233 119 239 222 29 205 132 51 169 149 43 87 102 203 97 68 0 65 37 164 66 82 156 78 90 21 82 122 73 74 166 99 221 186 117 235 25 122 84 76 170 50 153 102 150 77 76 224 19 39 78 196 166 77 155 178 130 23 47 94 132 203 196 190 65 100 243 57 110 198 102 52 176 199 143 31 39 215 233 211 167 243 14 24 55 110 92 216 15 142 188 19 36 94 147 191 217 134 102 0 25 106 163 39 111 168 38 88 35 128 9 96 163 110 216 176 33 143 221 188 121 243 98 231 206 157 185 39 92 100 39 79 158 204 111 93 216 179 103 79 250 30 58 116 40 142 28 57 146 246 56 247 239 223 31 219 182 109 203 141 41 201 140 253 240 225 195 78 9 248 208 78 193 180 241 111 118 105 12 183 227 233 117 231 224 193 131 121 33 185 148 92 64 110 73 155 146 205 154 53 107 98 203 150 45 185 1 117 243 230 205 155 121 103 24 131 228 234 184 218 164 110 203 118 74 193 5 172 123 191 130 35 176 241 124 155 235 230 205 155 163 249 219 145 29 115 98 4 117 181 186 128 28 83 54 56 230 206 157 27 123 247 238 141 5 11 22 100 135 70 141 26 21 142 37 155 18 227 237 222 189 123 228 41 224 40 144 234 85 139 68 82 196 183 13 166 101 126 39 220 1 142 236 162 69 139 226 233 211 167 113 225 194 133 36 119 220 92 195 146 50 70 199 120 230 204 153 57 78 123 64 192 133 11 23 198 219 183 111 243 40 42 10 119 91 243 198 234 20 76 112 79 173 109 44 237 38 116 218 111 68 178 150 144 153 234 94 217 104 103 141 16 78 95 5 241 145 0 189 192 124 217 226 109 248 83 82 73 232 64 141 161 72 188 145 152 179 55 156 78 96 193 232 84 68 71 90 253 116 88 65 124 172 217 137 235 221 168 246 3 9 37 65 160 234 34 50 34 2 71 70 224 245 206 121 54 177 214 4 224 197 87 184 68 61 68 236 252 45 224 68 201 65 245 42 146 33 157 55 189 199 55 92 235 73 5 107 245 101 215 186 159 216 209 17 35 192 7 175 125 150 55 33 101 9 50 226 216 88 87 235 4 171 68 216 195 97 108 106 246 133 43 192 147 199 172 105 171 11 173 254 10 224 147 56 39 217 16 134 30 32 93 181 79 230 214 2 123 10 183 70 92 182 133 227 146 152 177 194 172 139 171 124 196 77 123 217 180 6 173 68 202 176 198 225 27 153 119 145 149 159 132 172 11 103 67 36 96 237 93 29 96 75 39 1 163 104 88 16 6 130 33 170 214 211 115 128 121 106 35 242 41 191 34 99 87 184 142 17 60 132 45 187 194 91 55 113 187 128 181 169 24 10 68 103 45 33 2 167 167 131 17 223 149 112 157 243 242 245 38 146 82 125 141 34 149 205 63 120 96 158 236 85 57 20 185 204 145 23 97 57 86 181 149 92 225 190 73 225 120 170 237 173 190 85 24 236 191 181 118 228 44 254 42 1 136 36 81 196 72 170 125 112 45 134 181 38 94 93 100 91 27 207 154 224 43 92 213 112 190 120 26 213 102 1 41 17 203 176 12 57 19 78 149 144 100 56 179 135 123 87 80 223 56 203 86 194 173 56 94 184 75 72 156 6 71 70 132 51 71 231 211 92 25 151 33 61 92 162 124 220 3 146 240 176 43 92 71 173 85 236 71 73 240 234 170 24 248 232 20 145 247 0 37 5 146 90 183 206 95 150 130 86 16 100 240 210 241 17 16 78 39 73 107 73 178 43 225 7 111 157 63 187 252 247 0 163 170 158 82 66 164 170 178 134 87 162 133 211 39 73 19 171 46 150 63 155 210 9 250 127 193 45 193 54 255 57 5 50 174 7 40 91 130 176 50 247 205 198 55 27 210 138 87 192 86 92 226 196 27 46 49 221 41 105 234 255 189 169 188 145 86 117 222 213 66 251 193 119 225 245 174 147 1 167 43 189 4 240 193 235 45 104 43 183 196 19 215 30 128 167 42 96 12 68 136 0 33 220 186 108 109 178 10 228 77 224 124 8 255 86 28 70 112 139 233 219 250 31 89 226 69 254 119 66 132 132 0 0 0 0 73 69 78 68 174 66 96 130]
]
