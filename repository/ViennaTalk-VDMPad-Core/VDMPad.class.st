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
						nextPutAll: 'VDMPad.setupIdeNodes(); VDMPad.setupMenuNodes(); VDMPad.loadFromLocalStorage();' ])
]

{ #category : 'request handling-javascript' }
VDMPad >> VDMPadEpiLog [
	^ self responseJS: self VDMPadEpiLogSrc
]

{ #category : 'request handling-javascript' }
VDMPad >> VDMPadEpiLogSrc [
	^ '
      if (typeof(VDMPad) == "undefined") VDMPad = {};
      if (localStorage)
          VDMPad.EpiLog = JSON.parse(localStorage.getItem("`EpiLog")) || [];

      VDMPad.epilogOn = function () { 
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
          var button = document.getElementById("EpiLogButton");
          if (button) button.turnOn();
      };
      VDMPad.epilogOff = function () { 
          var areaNode = document.getElementById("EpiLogArea");
          while (areaNode.firstElementChild)
              areaNode.firstElementChild.remove();
          VDMPad.epilogRender();
          var button = document.getElementById("EpiLogButton");
          if (button) button.turnOff();
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
          if (localStorage)
              localStorage.setItem("`EpiLog", JSON.stringify(VDMPad.EpiLog));
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
        document.querySelectorAll("code.vdm").forEach(function(node) {
            hljs.highlightBlock(node);
        });
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
' copyReplaceAll: String cr with: String crlf
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

var VDMPad = {};
VDMPad.visualEnabled = false;
VDMPad.unittestEnabled = false;
VDMPad.unittestRunning = false;
VDMPad.protoTestcase = null;
VDMPad.testcases = [];
VDMPad.currentSource = null;

VDMPad.enableUnittest = function () {
    if (localStorage) {
        localStorage.setItem("Config`unittestEnabled", "true");
    }
    VDMPad.unittestEnabled = true;
    if (VDMPad.protoTestcase != null) {
        VDMPad.enableMakeItATestcaseButton();
    }
    VDMPad.startTests();
};
VDMPad.disableUnittest = function () {
    if (localStorage) {
        localStorage.setItem("Config`unittestEnabled", "false");
    }
    VDMPad.unittestEnabled = false;
    VDMPad.disableMakeItATestcaseButton();
    while (VDMPad.unittestNode.firstChild)
        VDMPad.unittestNode.removeChild(VDMPad.unittestNode.firstChild);
};

VDMPad.enableVisual = function () {
    if (localStorage) {
        localStorage.setItem("Config`visualEnabled", "true");
    }
    VDMPad.visualEnabled = true;
    VDMPad.loadFromLocalStorage();
};

VDMPad.disableVisual = function () {
    if (localStorage) {
        localStorage.setItem("Config`visualEnabled", "false");
    }
    VDMPad.visualEnabled = false;
    VDMPad.loadFromLocalStorage();
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
    if (localStorage) {
        var snapshot = JSON.parse(localStorage.getItem("`lastSnapshot"));
        snapshot.testcases = VDMPad.testcases;
        localStorage.setItem("`lastSnapshot", JSON.stringify(snapshot));
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
                        if (localStorage) {
                            var snapshot = JSON.parse(localStorage.getItem("`lastSnapshot"));
                            snapshot.testcases = VDMPad.testcases;
                            localStorage.setItem("`lastSnapshot", JSON.stringify(snapshot));
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
    if (VDMPad.visualEnabled) {
        queryOptions += "visual=&";
    }
    if (VDMPad.unittestEnabled) {
        queryOptions += "unittest=&";
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
    if (localStorage)
        localStorage.setItem("`lastSnapshot", JSON.stringify(result));
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
    while (VDMPad.valueVisualNode.firstChild) VDMPad.valueVisualNode.removeChild(VDMPad.valueVisualNode.firstChild);
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
    VDMPad.loadJson(localStorage.getItem(name));
    if (name != "`lastSnapshot") {
        VDMPad.currentSpec = name;
        if (localStorage)
            localStorage.setItem("`currentSpec", name);
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

VDMPad.saveAs= function (name, export_flag) {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            if (localStorage) {
                localStorage.setItem(name, this.responseText);
                localStorage.setItem("`lastSnapshot", this.responseText);
                localStorage.setItem("`currentSpec", name);
                var files = JSON.parse(localStorage.getItem("`files"));
                if (files.indexOf(name) < 0) {
                    files.push(name);
                    files.sort();
                    localStorage.setItem("`files", JSON.stringify(files));
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
        if (localStorage)
            localStorage.setItem("`files", JSON.stringify(files));
    }
    if (localStorage)
        localStorage.removeItem(name);
    VDMPad.updateFileItems();
};

VDMPad.loadFromLocalStorage = function () {
    if (localStorage) {
        VDMPad.unittestEnabled = localStorage.getItem("Config`unittestEnabled") == "true";
        VDMPad.visualEnabled = localStorage.getItem("Config`visualEnabled") == "true";
        if (localStorage.getItem("`lastSnapshot") == undefined) {
            var counter = {};
            counter["source"] = "module Counter\nexports all\ndefinitions\nstate counter of\n\tcount : nat\n\tinit s == s = mk_counter(0)\nend\noperations\n\tstep : () ==> nat\n\tstep() == (count := count + 1; return count);\nend Counter\n";
            counter["Counter`count"] = "1002";
            counter["expression"] = "Counter`step()";
            counter["value"] = "";
            counter["message"] = "";
            counter["testcases"] = [];
            localStorage.setItem("example:Counter", JSON.stringify(counter));
            localStorage.setItem("`files", JSON.stringify(["example:Counter"]));
            localStorage.setItem("`lastSnapshot", localStorage.getItem("lastSnapshot"));
            localStorage.removeItem("lastSnapshot");
        }
        VDMPad.load("`lastSnapshot");
        if (localStorage.getItem("`currentSpec") == undefined) {
            localStorage.setItem("`currentSpec", "");
        }          
        VDMPad.currentSpec = localStorage.getItem("`currentSpec");
    }
};

VDMPad.setupIdeNodes = function () {
    VDMPad.node = document.getElementById("all");
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
    VDMPad.unittestNode = document.getElementById("unittest");
    VDMPad.makeItATestcaseButtonNode = document.getElementById("addTestcaseButton");
    document.documentElement.addEventListener(''drop'', (event) => {
        event.preventDefault();
        VDMPad.acceptDroppedFile(event);
    });
    document.documentElement.addEventListener(''dragenter'', (event) => {
        event.preventDefault();
    });
    document.documentElement.addEventListener(''dragover'', (event) => {
        event.preventDefault();
        event.dataTransfer.dropEffect = ''copy'';
    });
    document.getElementById("formatButton").addEventListener(''click'', () => {VDMPad.format();});
    document.getElementById("initButton").addEventListener(''click'', () => {VDMPad.init();});
    document.getElementById("evalButton").addEventListener(''click'', () => {VDMPad.eval();});
    document.getElementById("addTestcaseButton").addEventListener(''click'', () => {VDMPad.addTestcase();});
};
' withUnixLineEndings
]

{ #category : 'request handling-javascript' }
VDMPad >> VDMPadMenu [

	^ '
VDMPad.fileItemsExpanded = false;
VDMPad.currentFileItemNode = null;

VDMPad.files = function () {
    if (localStorage) {
        try {
          return JSON.parse(localStorage.getItem("`files"));
        } catch (e) { 
          var files = [];
          for (var i = 0; i < localStorage.length; i++) {
            var file = localStorage.key(i);
            if (file[0] != ''`'' && file.substr(0, 7) != "Config`") files.push(file);
          }
          localStorage.setItem("`files", JSON.stringify(files));
          return files;
        }
   }
    return [];
};

VDMPad.setupMenuNodes = function () {
    VDMPad.menuNode = document.getElementById("menu");
    VDMPad.rootMenuNode = document.getElementById("root_menu");
    VDMPad.rootMenuIconNode = document.getElementById("rootMenuIcon");
    VDMPad.fileItemsNode = document.getElementById("file_items");
    VDMPad.rootMenuNode.onmouseover = function () {
        VDMPad.expandFileItems();
    };
    VDMPad.mainNode.onmouseover = function () {
        VDMPad.currentFileItemNode = null;
        if (!VDMPad.fileItemsExpanded)
            VDMPad.shrinkFileItems();
    };
    VDMPad.rootMenuNode.onclick = function () {
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
        VDMPad.fileItemsNode.appendChild(VDMPad.createConfigNode());
    }
};

VDMPad.expandFileItems = function () {
    if (!VDMPad.fileItemsNode.firstChild) {
        VDMPad.node.style.width = "1100px";
        VDMPad.menuNode.style.width = "300px";
        var files = VDMPad.files();
        for (var i = 0; i < files.length; i++)
            VDMPad.fileItemsNode.appendChild(VDMPad.createFileNode(files[i]));
        VDMPad.fileItemsNode.appendChild(VDMPad.createSaveAsInputNode());
        VDMPad.fileItemsNode.appendChild(VDMPad.createConfigNode());
        VDMPad.fileItemsNode.appendChild(VDMPad.createEpilogButtonNode());
    }
};

VDMPad.shrinkFileItems = function () {
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
    node.style.marginBottom = "12px";
    node.style.display = "block";
    inputNode.style.width = "100%";
    inputNode.style.display = "block";
    node.appendChild(inputNode);
    saveNode.style.visibility = "hidden";
    saveNode.style.marginTop = "1px";
    saveNode.style.borderStyle = "solid";
    saveNode.style.borderColor = "#c0c0c0";
    saveNode.style.borderWidth = "1px";
    saveNode.style.borderRadius = "6px";
    saveNode.style.paddingTop = "1px";
    saveNode.style.paddingBottom = "1px";
    saveNode.style.paddingLeft = "4px";
    saveNode.style.paddingRight = "4px";
    saveNode.style.backgroundColor = "#ffffff";
    saveNode.style.display = "block";
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
        saveNode.style.backgroundColor = "#808080";
    };
    saveNode.onmouseout = function () {
        saveNode.src = "/save.png";
        saveNode.style.backgroundColor = "#ffffff";
    };
    saveNode.onclick = function () {
        VDMPad.saveAs(inputNode.value, false);
    };
    return node;
};

VDMPad.createConfigNode = function () {
	var configNode = document.createElement("div");
	configNode.style.border="1px solid lightgrey";
	configNode.style.borderRadius = "5px";
	configNode.style.paddingLeft = "10px";
	configNode.style.width = "270px";
	configNode.innerText = "Config";
	configNode.textContent = "Config";
	var unittestNode = document.createElement("div");
	var unittestCheckbox = document.createElement("input");
	unittestCheckbox.type = "checkbox";
	unittestCheckbox.style.PaddingRight = "10px";
	unittestCheckbox.checked = VDMPad.unittestEnabled;
	unittestCheckbox.onclick = function () {if (this.checked) VDMPad.enableUnittest(); else VDMPad.disableUnittest();};
	unittestNode.appendChild(unittestCheckbox);
	unittestNode.appendChild(document.createTextNode("Unit Testing"));
	configNode.appendChild(unittestNode);
	var visualNode = document.createElement("div");
	var visualCheckbox = document.createElement("input");
	visualCheckbox.type = "checkbox";
	visualCheckbox.style.PaddingRight = "10px";
	visualCheckbox.checked = VDMPad.visualEnabled;
	visualCheckbox.onclick = function () {if (this.checked) VDMPad.enableVisual(); else VDMPad.disableVisual();};
	visualNode.appendChild(visualCheckbox);
	visualNode.appendChild(document.createTextNode("Visual Expressions"));
	configNode.appendChild(visualNode);
	return configNode;
};

VDMPad.createEpilogButtonNode = function () { 
   var epilogNode = document.createElement("div");
   epilogNode.id = "EpiLogButton";
   epilogNode.style.paddingLeft = "20px";
   epilogNode.style.paddingRight = "20px";
   epilogNode.style.paddingTop = "5px";
   epilogNode.style.paddingBottom = "5px";
   epilogNode.style.marginTop = "15px";
   epilogNode.style.display = "inline-block";
   epilogNode.style.cursor = "pointer";
   epilogNode.innerText = "EpiLog";
   epilogNode.style.borderStyle = "solid";
   epilogNode.style.borderWidth = "1px";
   epilogNode.style.borderRadius = "6px";

   epilogNode.turnOn = function () { 
      epilogNode.style.color = "white";
      epilogNode.style.backgroundColor = "black";
      epilogNode.style.borderColor = "white";
      epilogNode.onclick = VDMPad.epilogOff;
   };
   epilogNode.turnOff = function () { 
      epilogNode.style.color = "black";
      epilogNode.style.backgroundColor = "white";
      epilogNode.style.borderColor = "black";
      epilogNode.onclick = VDMPad.epilogOn;
   };
   if (document.getElementById("EpiLogArea").firstElementChild) { 
      epilogNode.turnOn();
   } else { 
      epilogNode.turnOff();
   }
   return epilogNode;
};
' copyReplaceAll: String cr with: String crlf
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

{ #category : 'request handling-image' }
VDMPad >> codemirrorGlass [
	^ self
		responsePNG:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 115 0 0 0 115 8 6 0 0 0 171 67 61 230 0 0 0 9 112 72 89 115 0 0 11 19 0 0 11 19 1 0 154 156 24 0 0 2 108 105 84 88 116 88 77 76 58 99 111 109 46 97 100 111 98 101 46 120 109 112 0 0 0 0 0 60 120 58 120 109 112 109 101 116 97 32 120 109 108 110 115 58 120 61 34 97 100 111 98 101 58 110 115 58 109 101 116 97 47 34 32 120 58 120 109 112 116 107 61 34 88 77 80 32 67 111 114 101 32 53 46 49 46 50 34 62 10 32 32 32 60 114 100 102 58 82 68 70 32 120 109 108 110 115 58 114 100 102 61 34 104 116 116 112 58 47 47 119 119 119 46 119 51 46 111 114 103 47 49 57 57 57 47 48 50 47 50 50 45 114 100 102 45 115 121 110 116 97 120 45 110 115 35 34 62 10 32 32 32 32 32 32 60 114 100 102 58 68 101 115 99 114 105 112 116 105 111 110 32 114 100 102 58 97 98 111 117 116 61 34 34 10 32 32 32 32 32 32 32 32 32 32 32 32 120 109 108 110 115 58 120 109 112 61 34 104 116 116 112 58 47 47 110 115 46 97 100 111 98 101 46 99 111 109 47 120 97 112 47 49 46 48 47 34 62 10 32 32 32 32 32 32 32 32 32 60 120 109 112 58 67 114 101 97 116 111 114 84 111 111 108 62 65 99 111 114 110 32 118 101 114 115 105 111 110 32 51 46 53 60 47 120 109 112 58 67 114 101 97 116 111 114 84 111 111 108 62 10 32 32 32 32 32 32 60 47 114 100 102 58 68 101 115 99 114 105 112 116 105 111 110 62 10 32 32 32 32 32 32 60 114 100 102 58 68 101 115 99 114 105 112 116 105 111 110 32 114 100 102 58 97 98 111 117 116 61 34 34 10 32 32 32 32 32 32 32 32 32 32 32 32 120 109 108 110 115 58 116 105 102 102 61 34 104 116 116 112 58 47 47 110 115 46 97 100 111 98 101 46 99 111 109 47 116 105 102 102 47 49 46 48 47 34 62 10 32 32 32 32 32 32 32 32 32 60 116 105 102 102 58 67 111 109 112 114 101 115 115 105 111 110 62 53 60 47 116 105 102 102 58 67 111 109 112 114 101 115 115 105 111 110 62 10 32 32 32 32 32 32 32 32 32 60 116 105 102 102 58 89 82 101 115 111 108 117 116 105 111 110 62 55 50 60 47 116 105 102 102 58 89 82 101 115 111 108 117 116 105 111 110 62 10 32 32 32 32 32 32 32 32 32 60 116 105 102 102 58 88 82 101 115 111 108 117 116 105 111 110 62 55 50 60 47 116 105 102 102 58 88 82 101 115 111 108 117 116 105 111 110 62 10 32 32 32 32 32 32 60 47 114 100 102 58 68 101 115 99 114 105 112 116 105 111 110 62 10 32 32 32 60 47 114 100 102 58 82 68 70 62 10 60 47 120 58 120 109 112 109 101 116 97 62 10 236 230 140 102 0 0 54 113 73 68 65 84 120 1 237 157 121 144 95 213 117 231 223 123 191 253 215 155 118 36 209 173 125 65 66 104 101 209 2 18 8 16 72 66 36 196 196 78 92 118 197 100 176 43 9 222 38 101 123 202 227 204 20 89 92 99 79 165 106 50 73 38 254 35 169 138 99 99 7 99 59 36 96 68 64 70 172 146 216 4 66 8 161 13 109 173 93 173 165 247 254 237 243 249 158 247 222 175 127 106 180 171 37 53 73 95 233 244 93 222 125 247 221 123 190 247 156 123 238 242 222 207 45 149 74 206 39 196 77 160 158 115 160 153 208 116 104 26 52 10 234 109 183 151 2 55 65 27 161 13 208 122 104 7 212 231 157 219 199 193 92 8 7 111 131 230 67 115 161 65 144 185 98 177 232 28 58 116 168 116 228 200 209 210 177 99 77 197 99 199 142 59 39 79 158 40 53 55 183 148 90 91 91 75 29 29 237 78 103 103 87 41 151 203 57 133 66 193 137 68 34 78 44 22 115 82 169 164 155 78 87 57 53 53 53 110 93 93 173 59 96 192 64 119 240 224 65 206 224 193 67 188 97 195 134 186 195 135 15 119 61 207 11 31 35 255 56 244 58 180 22 122 21 122 5 234 147 174 47 130 121 51 156 186 27 186 19 186 35 228 154 0 218 181 107 87 177 177 177 177 184 103 207 158 226 254 253 251 1 241 88 49 153 76 150 162 209 104 41 30 143 59 161 47 224 20 22 40 174 235 26 169 211 138 212 9 242 249 188 43 128 179 217 172 133 67 191 171 171 11 96 7 123 215 94 123 173 59 122 244 104 175 161 161 193 27 59 118 172 39 224 195 122 224 191 8 189 0 173 130 222 132 250 140 235 43 96 214 192 145 21 208 114 104 41 52 16 114 14 28 60 88 220 182 117 107 113 251 246 237 133 157 187 118 21 90 91 90 138 169 116 186 36 0 171 171 170 74 215 12 31 94 168 171 171 43 85 87 87 139 138 85 164 137 18 201 164 147 136 197 74 81 36 17 105 44 121 0 90 4 72 164 212 205 35 169 25 252 76 87 151 211 222 222 238 138 218 218 218 60 200 109 110 110 118 15 31 58 20 105 35 77 192 118 118 116 184 53 181 181 222 184 177 99 35 19 39 78 140 76 154 60 217 27 57 98 68 40 182 39 168 226 179 208 51 208 211 80 43 116 85 221 213 6 115 36 173 255 45 232 1 104 177 56 113 226 196 137 210 7 31 124 144 223 180 105 83 126 235 214 173 5 164 169 32 128 174 185 230 154 66 125 125 125 1 201 41 14 25 50 164 56 104 208 160 66 109 109 109 175 15 248 45 45 45 238 241 227 199 35 77 77 77 30 146 239 237 219 183 47 114 248 240 225 136 64 199 69 38 79 158 28 153 54 109 90 244 250 235 175 143 14 28 56 48 148 216 213 84 253 73 232 95 160 3 208 85 113 87 11 204 107 104 237 103 160 79 67 11 212 242 29 59 118 20 54 108 216 144 223 184 113 99 14 64 243 0 88 156 48 97 66 110 204 152 49 121 198 177 130 192 148 68 42 239 149 116 146 80 129 201 248 28 217 189 123 119 148 122 198 0 214 3 200 232 244 233 211 99 51 103 206 140 82 207 72 80 167 53 248 79 64 63 131 14 7 105 87 204 187 210 96 70 105 217 231 2 210 152 232 72 2 223 126 251 237 44 64 102 29 199 45 140 27 55 46 71 239 207 34 133 249 134 134 250 188 242 244 37 215 216 184 47 138 180 70 209 26 241 157 59 119 198 28 167 20 1 208 248 141 55 222 24 151 196 6 117 213 152 250 88 64 87 172 13 87 18 76 169 209 135 32 129 233 108 222 188 57 191 110 221 186 236 187 239 190 219 149 74 165 242 55 220 112 67 215 164 73 147 178 72 98 46 145 72 92 113 9 84 157 46 196 101 50 25 23 73 141 109 219 182 45 254 254 251 239 39 59 59 59 163 179 102 205 74 206 155 55 47 62 117 234 212 16 84 1 250 143 144 212 240 101 119 87 2 204 97 180 226 139 208 195 208 24 122 117 254 213 87 95 205 172 91 247 122 87 34 145 204 206 154 53 179 115 234 212 235 51 163 70 53 228 46 123 107 47 211 3 246 238 109 140 109 222 252 65 226 221 119 55 164 50 153 174 248 188 121 115 147 183 221 118 91 2 237 34 80 119 67 255 0 253 61 116 4 186 108 238 114 131 169 41 198 31 66 15 96 254 151 94 121 229 149 174 151 95 126 185 179 181 173 173 147 94 220 129 122 234 26 57 114 228 39 22 196 158 168 28 56 112 32 198 112 145 68 219 164 107 170 171 83 139 22 45 74 45 92 184 48 201 180 73 134 146 12 164 31 64 171 122 222 215 91 241 203 9 230 87 168 164 104 34 227 75 246 133 23 86 119 174 95 255 118 59 0 182 207 157 59 175 109 212 168 81 140 145 255 49 221 222 189 123 227 175 191 190 174 26 96 171 230 204 185 177 234 206 59 23 167 176 3 226 180 118 59 244 55 1 245 122 227 47 7 152 163 169 229 215 3 114 86 173 90 213 241 252 243 171 218 18 137 120 235 173 183 222 214 50 99 198 204 142 94 111 69 31 45 240 189 247 54 164 95 123 237 213 218 76 38 91 179 100 201 221 213 119 223 125 119 58 168 234 95 225 139 246 244 102 213 123 27 204 91 168 220 55 160 7 143 30 61 154 127 230 153 103 218 25 31 79 222 116 211 77 45 11 23 46 106 174 171 27 80 232 205 202 127 18 202 106 110 62 25 121 229 149 151 235 222 122 235 173 90 198 209 1 203 151 47 175 26 58 116 168 198 210 95 64 127 9 189 209 91 237 232 77 48 151 81 169 255 6 45 252 240 195 45 153 167 159 126 186 245 200 145 35 77 183 223 190 232 228 204 153 179 218 123 171 194 159 212 114 54 108 120 183 234 165 151 94 30 48 108 216 176 33 43 86 172 168 153 50 229 186 4 109 209 58 239 247 161 149 189 209 174 222 2 83 147 255 239 64 211 223 120 227 141 142 39 159 124 178 153 245 204 195 75 151 45 107 26 52 104 200 21 155 103 245 6 67 46 103 25 199 143 55 69 159 93 185 114 8 235 204 215 60 240 192 3 117 183 220 114 139 212 174 118 103 190 11 61 113 169 207 238 13 48 63 79 37 254 7 52 113 245 234 213 173 79 61 245 212 49 38 254 135 238 187 111 197 209 75 173 220 127 212 251 127 245 171 167 135 178 224 48 252 254 251 239 31 188 120 241 98 173 75 203 48 250 115 232 199 151 210 230 75 5 83 64 62 10 141 91 185 114 101 243 179 207 62 123 144 41 199 225 219 22 45 210 182 81 191 59 11 7 94 125 249 229 65 76 97 174 89 186 116 233 136 101 203 150 213 145 117 39 244 40 116 209 128 106 32 190 88 39 213 42 137 28 247 212 83 79 159 124 254 249 231 27 231 207 159 119 96 206 156 155 90 138 249 226 197 150 249 159 230 190 5 11 110 59 194 90 115 215 202 149 207 230 242 249 66 195 253 247 175 24 23 240 51 131 127 81 42 247 98 193 148 177 163 49 114 34 22 235 9 128 220 179 112 225 237 141 211 167 79 107 45 149 250 129 132 47 231 229 102 207 158 115 44 26 77 100 225 95 33 18 241 70 99 233 78 228 70 241 181 13 186 96 163 232 98 192 212 244 67 86 235 244 95 255 250 215 39 87 173 250 245 174 69 139 22 238 193 58 107 101 211 151 228 126 119 33 28 152 58 245 186 19 174 91 204 195 199 34 107 210 238 93 119 221 165 35 49 226 239 49 232 130 166 45 23 10 166 22 4 52 143 92 200 34 121 203 115 207 61 183 251 198 155 110 222 57 233 186 235 90 10 253 18 9 91 46 206 193 191 19 153 108 190 0 63 61 182 254 198 177 88 191 144 146 196 103 209 121 47 44 92 40 152 90 217 121 144 205 227 118 12 158 198 73 147 38 239 152 50 101 202 137 124 174 64 114 191 187 20 14 136 143 157 29 237 59 224 107 140 77 247 49 108 126 63 72 121 251 160 255 122 190 229 94 8 152 90 103 253 58 155 180 89 30 120 128 3 80 155 103 206 158 117 180 88 234 7 242 124 153 125 174 124 240 243 72 107 107 91 233 153 149 43 227 156 168 24 205 166 188 132 71 86 174 214 115 207 233 206 119 106 162 221 143 255 7 77 252 225 15 127 184 151 131 85 235 239 185 103 249 190 104 212 59 231 3 250 51 92 24 7 242 204 4 158 123 238 153 122 246 117 111 124 232 161 135 26 184 91 115 208 71 160 85 231 42 233 124 36 115 24 133 104 27 107 226 179 207 254 251 209 55 223 124 123 227 242 21 43 246 151 24 180 115 133 126 203 245 92 12 190 224 235 108 150 221 60 119 254 254 103 158 126 58 54 124 248 136 228 210 165 247 202 194 21 255 223 131 142 156 173 188 243 1 243 139 20 240 0 39 3 218 214 172 121 109 251 188 5 243 247 212 214 212 116 20 251 129 60 27 95 47 233 26 252 205 137 207 175 189 246 218 160 209 163 71 165 56 185 160 3 111 235 161 239 158 173 224 115 129 169 163 30 15 179 177 92 124 233 229 151 27 135 12 27 182 105 84 125 67 75 145 51 167 253 238 242 114 64 124 230 112 247 166 151 94 122 105 32 7 198 38 179 193 253 48 79 92 7 173 62 211 147 207 6 166 174 61 4 141 121 241 197 151 14 110 249 112 219 59 236 201 29 231 236 105 191 110 61 19 55 123 57 125 194 184 9 199 217 11 126 7 254 15 184 231 158 37 99 40 94 120 104 167 229 180 19 250 179 129 249 57 110 250 220 222 198 198 142 181 175 175 219 54 109 250 13 135 226 201 100 166 31 73 184 114 133 28 252 206 139 239 226 255 148 169 83 234 70 53 52 8 147 23 160 31 158 174 10 103 2 243 26 50 235 70 103 237 154 53 251 240 54 143 110 104 104 41 245 171 87 177 228 138 58 241 125 255 254 198 205 224 48 98 212 239 252 206 36 30 46 92 158 133 14 247 172 200 153 192 252 12 25 239 100 113 224 228 219 235 215 111 156 62 99 70 83 254 10 77 40 25 159 11 249 108 6 47 155 107 111 239 202 114 164 49 215 213 149 201 119 102 59 11 29 173 29 185 174 92 87 161 165 165 35 159 237 236 40 180 183 119 20 50 252 235 108 237 44 182 118 182 21 52 182 183 181 103 138 133 124 87 169 171 171 80 98 121 177 196 42 118 249 216 102 44 26 117 121 7 197 77 38 35 110 36 154 116 171 171 18 30 99 145 87 147 170 142 164 106 82 94 34 146 136 84 85 165 35 241 84 58 82 91 155 142 38 99 201 72 186 38 29 75 197 83 145 100 50 17 101 185 45 86 85 165 243 89 241 88 52 158 144 31 233 201 208 203 17 31 63 126 124 211 91 235 215 191 207 113 212 97 44 38 220 201 51 132 207 95 247 124 214 233 192 212 43 3 218 17 113 56 234 176 167 166 186 166 113 208 128 65 157 165 66 190 231 189 23 28 47 22 221 66 91 103 91 166 179 173 173 171 185 181 45 211 220 210 146 105 110 110 203 158 104 58 150 105 58 217 148 57 120 240 80 118 255 254 3 128 215 213 107 218 28 75 191 236 4 174 150 143 121 205 4 215 236 28 107 42 95 186 224 0 59 30 188 96 52 50 54 98 196 240 248 144 1 67 18 3 135 12 78 212 213 85 199 235 106 107 19 117 53 213 137 84 117 117 178 58 85 157 240 188 210 37 3 46 254 215 86 215 236 21 30 128 57 128 202 10 31 29 59 57 229 85 136 211 129 169 119 63 22 32 149 199 56 109 190 97 230 236 27 89 8 118 47 136 185 28 8 206 0 86 103 115 75 115 231 241 163 77 157 77 77 39 186 246 237 59 208 185 123 223 238 174 198 125 251 114 148 127 118 87 137 192 217 115 94 181 171 93 153 174 194 71 59 119 138 172 107 156 174 34 13 245 245 177 49 245 99 146 245 245 35 83 67 134 12 76 14 26 58 36 85 87 91 151 2 108 206 125 167 116 108 228 188 221 248 137 147 78 172 95 191 254 61 112 169 7 208 5 220 40 156 254 182 178 128 158 96 106 215 91 115 26 103 253 59 239 236 173 170 169 105 170 171 171 201 22 157 211 99 89 226 181 158 150 150 246 142 147 173 39 219 143 29 57 210 126 240 224 209 206 157 59 119 117 108 222 188 165 163 181 171 245 244 55 85 62 253 63 120 88 29 55 232 188 167 188 33 86 147 172 241 216 45 73 143 27 55 54 61 98 196 208 212 224 97 195 170 6 212 12 168 170 173 173 74 187 17 94 89 59 141 19 14 181 181 213 71 133 11 96 14 38 139 112 250 39 168 92 118 79 48 87 112 113 241 71 31 237 60 185 233 253 77 155 167 92 63 237 164 203 82 15 105 230 58 24 192 120 67 170 141 23 92 219 247 237 59 212 190 125 203 214 182 119 222 223 208 17 94 63 213 63 109 157 78 205 242 159 52 214 218 213 86 120 227 157 183 91 69 149 44 152 125 195 204 244 196 235 38 87 215 215 15 175 226 197 223 42 222 116 171 78 51 80 135 121 198 140 25 103 184 128 207 216 241 227 199 105 13 64 120 253 52 188 222 19 76 189 31 233 188 191 233 253 125 94 196 59 146 174 170 106 222 221 216 216 118 104 255 129 150 93 187 26 219 214 175 127 183 237 96 211 161 115 171 201 176 244 126 255 130 56 32 193 168 20 142 17 67 134 199 230 204 153 85 61 118 108 67 245 240 107 71 214 114 68 179 90 184 8 31 192 212 216 41 188 78 11 230 205 92 88 202 235 116 157 47 174 126 105 253 7 91 182 190 241 175 79 254 251 190 126 240 46 8 143 94 205 44 222 255 234 185 103 245 82 175 200 17 184 245 163 71 28 233 236 232 26 180 104 225 194 241 188 86 184 148 100 225 246 166 174 87 238 154 124 135 248 95 240 62 200 198 187 238 89 250 215 169 170 90 29 1 236 119 125 144 3 157 237 45 211 127 253 220 179 95 229 61 22 157 74 248 19 200 214 108 43 247 176 52 127 113 214 190 254 250 135 174 27 239 63 93 39 102 244 81 7 62 39 214 172 91 183 37 168 158 225 166 112 8 230 66 194 119 48 199 59 246 248 79 31 223 28 143 68 251 193 12 56 213 23 61 240 57 246 83 112 18 94 194 13 18 126 78 104 0 221 166 200 246 237 219 118 109 222 186 173 49 157 168 109 63 253 82 174 114 245 187 171 205 129 72 36 214 190 117 219 246 189 194 139 133 11 77 83 132 223 43 161 100 206 87 5 217 120 222 237 186 222 73 133 251 93 223 230 0 11 57 205 194 43 168 165 225 39 48 39 64 115 249 116 74 7 103 123 118 122 145 136 84 172 214 51 251 169 15 243 192 67 213 10 47 225 38 252 160 9 2 115 14 52 136 143 37 237 91 187 118 237 238 68 36 213 70 188 223 245 113 14 8 39 240 218 35 220 168 234 32 104 142 192 156 169 122 111 217 186 245 32 75 73 167 172 72 40 189 223 245 93 14 128 87 139 112 11 106 56 83 96 106 174 226 188 191 113 211 33 215 139 181 104 234 217 79 159 12 30 8 47 225 22 128 57 93 96 78 227 123 114 197 53 235 214 28 113 189 72 115 112 161 223 251 4 112 64 120 189 182 246 181 163 194 79 56 106 5 168 116 232 208 225 35 215 54 140 254 223 201 234 218 213 159 128 54 244 87 177 130 3 93 109 45 119 238 111 220 243 205 225 195 175 25 102 243 204 163 71 143 28 143 184 78 123 220 183 222 42 178 246 7 251 58 7 114 224 38 252 4 166 212 172 179 127 255 65 230 150 110 103 95 175 120 127 253 78 199 1 183 195 199 47 88 1 58 120 112 127 179 235 70 59 114 102 252 156 238 134 254 180 190 202 1 112 235 20 126 170 159 169 89 62 129 214 234 70 221 51 30 127 232 171 13 169 172 23 223 149 181 221 240 88 44 122 202 174 184 190 254 220 211 233 235 208 149 46 151 243 15 125 145 94 62 252 85 121 189 47 135 193 173 83 248 169 142 6 38 11 182 109 110 209 251 196 168 217 74 224 66 176 194 52 157 190 11 153 95 25 14 211 66 95 135 187 122 134 67 48 5 246 39 6 224 130 167 243 85 246 105 158 64 50 247 119 56 49 47 195 247 175 101 226 246 73 23 71 242 4 88 44 110 146 86 138 69 99 110 52 22 117 116 124 82 21 14 129 11 253 16 228 179 52 198 13 37 52 124 227 59 244 117 60 51 159 203 59 185 188 47 169 185 172 192 205 149 178 125 80 114 221 184 215 197 39 206 187 193 228 3 126 93 44 176 235 195 8 125 206 85 130 24 0 232 134 231 95 5 156 64 139 70 177 197 113 145 72 8 172 31 247 211 186 195 97 227 248 62 123 133 84 250 225 66 193 151 84 62 22 97 31 233 247 143 101 250 231 110 121 46 231 111 115 78 44 155 83 7 232 83 160 130 27 199 83 247 27 118 193 212 228 112 150 159 12 192 202 181 197 245 176 205 87 205 71 250 76 10 227 177 56 223 88 231 224 178 36 210 14 47 39 61 31 60 210 34 58 200 28 128 167 48 164 111 178 203 69 35 94 89 213 42 189 103 67 78 1 179 80 52 96 245 237 118 165 231 3 160 11 146 78 197 241 37 193 58 203 235 75 172 169 96 39 155 203 154 180 34 181 229 142 209 243 57 87 34 14 110 89 190 132 102 31 149 52 48 249 46 121 193 245 146 87 93 197 246 4 145 179 165 158 164 79 68 184 12 160 1 25 128 39 224 4 24 187 61 230 139 129 17 175 27 76 20 241 199 120 138 2 45 167 21 138 62 152 2 146 183 219 120 3 67 128 22 81 179 221 224 10 88 61 159 243 192 6 174 0 38 92 100 92 117 178 177 172 73 235 213 2 149 223 134 40 130 159 157 80 55 48 217 69 41 166 235 82 87 245 61 189 116 85 218 147 36 166 210 41 47 84 163 6 32 64 114 218 208 11 1 228 53 129 83 192 19 112 2 140 79 175 232 247 72 124 117 155 240 165 49 140 151 145 43 7 82 250 73 12 147 40 222 110 48 95 241 130 64 4 104 1 92 9 46 175 71 88 156 122 148 56 109 90 20 152 234 96 38 181 2 182 163 179 40 80 59 218 59 174 184 64 176 175 89 232 232 232 176 54 24 152 233 234 42 143 95 253 224 23 35 188 43 14 168 140 26 190 176 129 90 141 58 233 64 18 5 162 142 255 75 226 248 180 41 224 198 28 222 235 176 56 175 121 72 90 29 147 68 192 243 138 72 38 224 9 56 75 183 180 98 89 181 242 50 73 57 28 98 89 228 67 198 229 112 181 87 18 144 0 99 0 11 220 162 7 152 164 73 82 149 206 23 171 9 22 74 122 151 133 206 20 225 147 163 69 234 200 251 44 93 69 36 212 97 92 247 58 144 212 120 60 161 159 214 144 90 46 151 31 62 231 114 249 124 119 41 146 174 74 217 226 143 129 201 123 12 177 230 230 172 235 36 174 236 152 9 136 124 42 37 205 120 24 115 83 209 164 151 172 97 76 68 202 146 53 9 207 254 1 146 140 155 88 58 238 197 93 31 68 192 7 55 95 181 2 176 129 168 184 79 116 71 194 98 28 198 144 241 143 232 199 193 12 190 1 143 209 99 121 4 102 177 24 55 80 139 73 133 139 2 206 151 78 126 23 37 71 231 17 168 89 94 56 202 117 68 138 169 40 166 63 160 171 3 82 223 34 163 168 171 122 119 198 186 0 52 198 239 165 116 232 55 83 174 140 148 102 29 183 182 174 206 26 107 127 248 108 102 226 100 251 94 102 221 94 247 96 98 205 188 60 127 4 66 58 141 90 165 225 244 112 47 133 20 166 162 72 227 25 64 68 189 73 234 2 201 244 1 84 92 64 233 143 164 91 126 209 245 129 140 145 206 21 3 145 206 240 177 70 96 177 90 26 189 186 148 211 175 215 224 144 79 3 81 82 37 48 169 163 164 146 160 1 235 73 50 19 252 82 81 198 205 120 89 238 138 118 100 139 137 60 154 131 110 151 41 102 138 2 51 154 103 6 239 191 244 84 164 78 17 212 31 74 160 91 11 124 172 34 189 144 80 138 22 99 28 142 78 170 40 3 115 196 136 17 169 173 91 183 39 156 84 244 12 175 26 244 194 83 131 34 36 141 166 90 211 105 95 26 171 1 18 181 170 113 145 151 228 188 100 133 36 134 32 74 26 213 1 66 0 99 49 1 138 196 69 162 158 128 83 121 2 79 105 114 122 84 8 166 229 235 81 125 132 205 0 20 152 41 174 105 231 8 204 244 215 84 164 1 92 16 144 37 47 151 203 150 129 5 24 169 120 64 60 21 212 8 160 106 90 20 205 68 139 92 119 249 173 35 183 51 106 111 178 169 173 165 203 41 165 165 108 38 193 119 238 213 12 31 76 126 251 42 77 75 202 239 52 244 104 123 175 69 67 181 122 90 105 140 71 220 84 109 42 34 117 122 58 16 145 48 235 4 2 48 142 181 35 137 99 76 53 248 228 67 78 209 160 68 82 5 52 46 4 246 116 13 16 116 74 23 112 2 209 227 47 210 167 197 135 98 210 15 99 232 20 28 30 90 116 0 22 137 53 32 145 86 183 39 168 40 226 98 148 109 253 104 201 134 133 178 148 178 168 161 49 85 234 214 187 92 128 82 247 36 248 117 131 89 95 127 109 21 137 105 90 127 217 6 110 126 187 203 171 138 165 101 173 186 169 100 202 173 193 42 197 152 240 226 85 213 94 18 67 135 95 207 139 8 68 73 25 126 196 151 68 1 24 143 40 77 96 10 52 133 61 94 184 144 196 73 10 36 129 36 7 50 201 239 59 149 65 61 51 160 130 79 64 202 15 128 179 176 226 88 180 236 241 154 65 228 73 90 83 197 130 166 30 82 179 2 215 194 12 15 204 86 236 135 225 84 135 66 156 223 22 139 213 70 35 252 42 96 33 90 136 49 238 59 78 172 75 125 43 168 86 142 215 175 112 252 198 88 175 143 163 84 57 125 237 181 35 170 213 158 64 205 142 172 85 162 18 122 219 105 5 71 192 0 164 203 103 196 34 201 4 106 21 67 2 41 229 109 228 164 174 121 248 6 36 150 171 249 48 11 76 162 146 80 73 160 129 8 186 129 68 70 221 146 64 21 140 130 212 0 245 195 130 86 14 145 181 102 16 242 37 148 94 26 182 75 191 213 167 48 127 253 142 139 52 10 196 60 164 1 50 98 17 155 122 20 115 132 249 57 63 169 206 82 22 63 130 53 75 125 52 30 186 154 162 40 204 53 135 48 53 137 20 32 55 194 43 219 49 167 90 6 152 61 51 138 202 141 213 98 142 180 56 5 167 202 241 52 134 246 230 178 32 85 76 141 28 89 175 87 49 125 48 27 26 174 173 197 8 79 187 217 222 253 146 136 129 8 144 213 213 85 24 58 140 145 169 24 191 91 153 198 212 79 8 76 77 55 36 145 140 135 9 39 194 20 164 134 223 182 20 136 76 56 13 200 132 212 39 32 130 166 201 162 128 151 45 171 223 82 244 165 82 32 42 6 168 104 85 50 3 155 175 108 13 213 98 229 234 143 166 43 204 192 2 87 242 244 155 113 114 81 200 43 197 10 89 161 139 52 202 37 164 124 221 24 115 72 151 215 189 115 164 0 164 83 224 237 58 125 54 135 247 237 157 104 50 33 16 89 161 202 241 171 129 9 94 195 239 210 184 78 150 184 167 223 237 36 76 159 211 212 42 195 239 121 162 174 189 42 55 209 233 150 218 56 251 216 206 46 77 111 25 70 224 86 37 252 202 96 242 141 182 1 52 196 208 13 27 219 27 62 18 38 32 1 44 141 145 147 212 239 80 26 72 26 59 25 55 193 41 38 31 240 226 145 106 44 90 24 32 61 42 85 27 73 198 16 73 192 147 66 13 65 180 9 71 34 90 6 48 194 8 43 48 125 224 180 8 20 145 12 10 87 116 48 84 12 36 179 226 5 86 189 32 172 182 149 60 100 16 113 244 149 173 83 42 112 35 152 250 35 104 209 5 179 44 96 68 129 145 82 50 249 82 44 233 21 4 42 32 20 121 144 73 41 38 87 33 199 20 136 1 149 58 120 133 54 250 20 253 206 76 101 1 121 6 30 106 252 213 184 107 245 56 67 158 243 78 22 110 194 79 55 152 154 229 23 240 6 58 133 146 192 236 149 7 168 224 154 154 106 230 144 213 78 58 45 48 25 35 249 65 81 230 148 82 169 138 227 39 12 72 164 82 31 127 48 32 37 157 204 57 35 41 64 212 154 28 107 175 145 20 162 8 104 194 212 51 177 132 107 90 147 5 117 86 10 0 18 192 164 210 0 15 134 130 26 220 119 240 34 122 141 38 0 49 4 85 245 194 204 243 219 8 168 5 108 27 218 141 96 154 249 35 112 1 17 132 99 104 222 98 140 143 144 229 136 230 233 95 8 108 174 232 198 36 179 81 183 208 73 152 175 253 162 89 138 78 103 150 229 60 62 60 39 117 43 98 181 200 124 45 38 80 99 169 13 230 163 50 201 60 198 77 191 223 229 248 10 168 58 32 31 61 188 244 49 180 80 170 54 252 104 155 192 220 11 178 245 11 111 95 56 246 141 117 111 15 138 70 47 253 13 176 0 72 253 12 112 68 192 73 34 245 21 143 0 72 129 103 233 33 144 168 93 62 136 156 240 36 141 146 66 44 86 0 141 1 162 12 86 73 43 44 129 19 44 164 107 144 228 247 106 165 193 64 202 132 212 36 82 188 225 62 254 218 31 69 180 40 226 143 149 32 91 150 146 242 88 9 126 216 191 142 105 89 117 226 2 9 72 102 1 31 19 8 11 136 133 32 61 7 99 135 72 49 47 101 91 98 189 41 71 93 60 70 80 58 84 39 195 82 149 231 162 117 93 183 11 201 84 37 120 168 191 18 65 160 194 73 90 123 78 120 149 230 93 10 160 249 124 102 176 112 3 63 29 130 222 43 48 55 81 187 81 243 231 205 27 186 110 205 154 33 142 115 105 96 134 64 166 89 99 13 129 148 228 85 2 41 227 199 55 118 108 23 4 96 147 8 27 171 175 0 41 179 53 205 220 131 151 99 164 114 81 179 165 136 64 228 31 122 177 104 6 17 121 60 100 81 221 28 189 6 152 146 72 225 103 253 157 63 164 209 46 224 236 6 84 241 110 71 73 0 73 95 65 191 74 181 2 166 132 211 30 64 64 105 96 138 25 36 179 214 99 232 44 198 18 172 244 32 169 2 213 45 166 93 38 160 176 173 84 232 0 72 234 82 72 81 129 60 192 234 25 92 64 112 169 16 126 247 51 181 41 83 176 122 41 13 85 43 13 97 211 150 139 5 20 165 63 120 222 220 185 195 120 142 202 221 36 48 55 66 203 102 206 152 49 140 5 143 65 216 38 23 173 106 145 42 89 167 142 63 78 166 204 200 1 40 91 237 209 56 41 80 81 189 30 171 3 94 76 211 16 166 32 85 10 51 253 16 144 62 158 2 210 166 35 146 76 250 127 2 223 52 43 86 15 184 149 36 137 81 3 210 134 40 113 205 7 146 52 140 32 178 152 36 158 102 188 164 157 230 194 113 19 172 1 206 193 138 149 174 149 250 45 21 177 62 139 5 140 35 196 176 160 222 131 184 21 163 113 198 206 60 65 45 14 56 113 20 113 70 106 150 53 249 136 147 142 100 249 237 234 136 147 103 236 148 145 4 95 75 237 153 172 83 20 210 116 197 26 198 102 207 107 51 117 171 135 83 87 89 205 66 86 96 51 213 201 150 208 76 250 253 235 11 230 59 120 13 158 53 115 230 80 191 85 206 70 129 185 65 145 201 215 93 119 13 45 66 50 47 222 1 162 199 111 63 219 152 200 52 196 84 43 203 118 124 40 201 128 140 196 100 236 48 253 72 106 181 7 213 26 0 41 21 27 73 32 152 96 104 127 164 97 37 110 146 70 1 102 43 119 102 211 218 18 158 50 249 82 105 26 150 32 146 104 128 2 160 129 41 35 200 126 59 220 87 179 180 168 172 102 9 35 133 252 17 124 242 176 123 24 102 149 166 36 32 68 203 50 190 73 72 237 15 163 178 128 45 68 144 59 236 34 176 240 188 98 188 192 54 181 212 66 33 155 75 240 232 172 217 91 25 36 84 220 171 242 85 173 120 155 215 193 170 88 49 117 70 160 2 9 245 142 31 207 86 74 177 138 57 167 163 126 131 133 91 144 113 131 30 184 30 58 206 143 100 15 159 55 239 150 113 111 190 251 254 128 116 44 121 193 47 219 74 189 122 201 84 17 48 35 154 138 196 153 122 196 170 152 134 240 123 209 49 126 208 155 143 28 49 37 177 53 89 71 203 118 218 112 142 39 109 46 169 141 103 169 81 55 154 192 151 106 165 127 203 7 75 76 27 179 125 164 180 100 15 153 239 99 105 186 21 41 21 176 37 169 25 102 38 118 168 11 123 199 118 77 200 16 33 124 10 144 214 110 97 201 206 165 129 137 42 198 143 129 150 175 246 88 196 97 220 100 152 4 102 72 65 64 45 178 221 21 65 124 139 76 69 248 53 121 196 57 150 139 218 210 95 52 166 37 64 175 148 119 243 69 47 150 243 114 49 230 70 25 109 230 68 56 218 98 237 41 170 71 102 216 249 41 184 109 14 208 151 114 244 49 38 81 78 117 177 96 191 78 223 193 6 106 109 109 222 185 16 117 203 183 202 6 221 124 243 205 227 133 155 240 131 214 11 204 29 208 235 128 176 108 201 146 37 99 94 127 235 173 145 206 5 130 105 234 181 186 198 29 136 181 202 0 232 69 153 83 34 121 94 53 160 177 136 30 73 96 240 104 140 36 159 86 115 52 6 98 4 69 181 64 16 161 193 81 174 68 0 82 14 32 185 156 4 69 7 173 139 94 197 73 102 203 62 98 16 0 234 72 36 13 76 192 147 32 123 242 113 14 202 94 224 26 168 178 58 0 172 44 153 228 49 41 137 59 113 3 19 80 145 188 34 250 60 142 178 101 97 128 169 38 207 0 204 2 160 154 53 5 136 18 124 0 66 132 53 238 1 23 216 130 6 53 113 186 56 160 193 146 143 50 0 226 41 198 143 164 82 189 66 67 143 92 46 31 172 152 106 227 155 227 41 249 124 186 20 201 229 189 129 140 159 124 129 162 24 207 100 207 123 202 82 204 119 93 187 116 233 61 163 193 77 139 61 47 65 59 4 166 220 90 104 217 220 185 115 235 177 226 70 16 222 164 196 243 117 146 202 106 164 66 59 33 41 22 208 89 170 243 210 140 133 113 192 149 132 201 16 18 144 248 2 52 122 58 32 5 178 1 137 143 146 101 147 137 21 247 64 26 67 64 97 23 184 154 68 226 51 95 0 60 228 71 234 88 172 84 71 16 215 133 39 61 158 41 11 220 38 92 6 82 237 33 77 215 124 169 68 181 50 34 242 199 126 250 129 194 60 134 70 22 10 34 12 137 78 28 80 181 114 139 21 83 48 52 193 17 32 177 115 180 172 135 98 65 172 242 124 94 128 92 204 27 221 88 0 228 89 78 82 165 208 215 204 119 248 121 251 116 169 90 133 50 250 10 80 44 44 236 41 52 3 124 60 118 236 248 121 169 91 225 36 188 2 140 132 159 63 207 196 127 85 17 190 252 84 63 121 242 132 113 59 246 28 168 67 213 114 202 253 220 78 64 178 121 91 146 97 19 5 200 58 237 134 4 243 74 68 210 173 98 209 160 134 5 129 88 74 107 174 17 140 32 45 10 176 64 0 102 236 51 120 241 20 210 138 146 149 140 249 170 213 35 110 18 9 96 44 28 96 223 6 62 113 179 118 52 133 148 36 106 159 34 8 75 106 100 123 104 231 68 18 43 231 199 253 22 116 111 86 35 167 204 55 4 54 6 171 103 118 10 99 166 162 69 210 145 185 18 122 148 178 164 98 121 14 128 105 30 171 85 61 25 44 17 188 60 5 71 48 96 240 129 63 231 229 165 54 164 114 105 144 205 43 35 165 14 45 31 105 224 213 220 178 139 78 33 43 54 70 183 161 68 9 43 130 28 173 177 47 189 48 32 151 152 167 230 221 42 91 247 205 23 53 31 63 151 186 69 197 14 0 167 177 194 43 64 200 240 83 225 114 175 64 47 178 250 62 248 193 223 254 237 169 197 76 231 40 75 61 199 31 141 129 72 154 172 86 79 83 145 1 0 9 178 72 36 179 47 36 18 67 39 82 133 68 34 138 146 80 214 4 24 43 57 22 128 129 35 32 163 2 18 70 8 35 52 175 166 34 146 200 152 144 212 112 19 248 132 152 119 195 104 196 79 62 154 217 139 198 145 30 75 3 84 205 66 149 142 249 228 50 36 49 167 33 76 113 254 245 136 43 179 74 105 1 41 110 139 76 150 207 207 239 178 114 24 97 221 144 114 236 126 158 69 30 61 71 247 249 207 101 51 134 122 216 88 80 81 63 171 175 234 205 3 113 170 51 95 197 164 205 106 159 218 73 123 213 110 93 23 31 196 15 241 69 252 17 159 196 47 241 77 252 19 31 197 79 241 245 108 172 23 62 194 73 120 9 55 72 248 149 37 83 225 23 160 59 22 223 113 199 232 239 254 197 255 170 199 50 51 43 87 23 206 228 146 73 230 146 3 6 148 188 36 19 134 100 178 20 175 142 59 85 233 152 147 230 148 92 18 170 170 78 148 162 17 194 201 168 147 140 38 220 4 211 20 204 28 55 25 15 142 132 196 108 218 65 67 53 45 209 230 179 140 28 216 1 11 20 69 188 36 128 230 139 83 60 69 195 173 58 160 141 163 72 148 82 213 33 52 159 98 20 179 249 37 49 120 33 217 228 175 145 86 133 66 7 34 4 125 66 252 144 65 162 44 207 201 202 33 191 36 20 109 90 224 135 33 36 141 225 10 13 143 38 31 162 204 45 146 104 124 73 161 68 26 195 39 143 89 203 157 212 131 13 80 86 15 116 150 133 217 104 148 82 220 98 87 49 194 198 59 113 36 59 227 112 88 200 248 130 40 235 1 78 190 74 3 46 230 80 54 89 242 50 173 37 241 179 157 241 52 115 150 117 114 170 208 32 156 130 38 9 55 115 98 76 232 86 17 56 49 99 198 140 209 247 220 115 247 236 124 219 201 134 240 194 233 124 140 23 147 74 172 59 127 30 153 246 15 94 209 179 232 113 218 9 177 109 172 72 60 141 136 160 14 89 237 241 152 137 153 209 67 163 205 24 146 31 101 249 14 32 1 197 199 19 32 37 149 2 16 67 86 152 146 65 26 21 197 165 206 77 58 163 148 239 19 215 126 88 12 93 166 3 66 190 132 18 87 30 180 45 59 164 1 33 248 18 126 163 32 77 215 149 143 158 96 247 233 126 149 163 242 172 92 133 187 159 99 207 87 61 84 31 211 240 212 79 245 12 235 235 215 95 157 144 222 86 209 62 25 121 106 183 218 111 124 128 31 240 200 86 193 196 39 241 75 198 98 21 252 147 205 33 126 250 210 153 232 238 128 21 0 128 203 40 62 175 62 123 250 244 233 99 72 214 151 187 132 155 185 208 0 82 68 159 236 122 150 79 120 125 246 193 7 63 53 145 111 131 143 165 203 236 181 92 167 249 163 21 29 172 84 166 27 181 14 234 129 138 12 112 249 164 174 195 247 246 108 87 36 149 72 105 10 226 166 98 41 55 206 25 30 16 2 13 252 164 166 30 62 114 106 136 164 17 141 3 120 98 132 198 72 146 112 146 73 24 199 201 45 172 24 73 164 148 35 153 16 15 93 53 95 107 118 164 233 30 117 74 242 217 152 68 154 146 3 169 244 165 83 45 16 115 36 134 114 242 37 99 144 89 183 140 92 102 10 251 166 45 67 30 69 35 105 178 94 61 44 84 27 144 89 181 97 133 33 90 194 52 138 59 172 11 49 170 106 174 170 233 5 39 192 176 72 60 210 80 26 248 158 22 228 101 253 90 87 209 244 134 231 185 5 22 64 156 14 89 202 200 121 138 133 3 202 23 191 116 190 72 252 211 198 55 27 46 78 34 153 119 146 72 46 7 199 194 250 170 206 230 120 232 216 7 31 252 173 137 250 72 34 9 63 133 236 83 107 186 88 9 166 226 207 64 159 189 245 214 91 199 79 154 52 97 218 142 61 123 54 69 226 117 199 116 161 167 171 67 175 87 51 88 75 215 71 163 254 84 36 158 192 106 5 25 27 240 232 182 234 226 56 137 28 158 164 83 195 14 82 153 176 116 41 84 173 202 1 146 186 188 172 87 25 59 6 164 73 128 128 36 19 122 200 151 212 110 32 1 14 64 43 64 228 94 89 63 62 152 240 205 152 231 235 91 171 121 101 47 55 6 161 77 17 68 12 89 108 39 114 16 19 105 74 104 75 112 176 89 250 86 198 15 230 139 25 177 69 194 218 9 97 94 2 184 44 171 179 8 155 55 235 24 112 116 244 18 203 84 101 154 26 214 226 49 11 241 49 142 102 106 106 162 37 122 180 45 192 23 34 5 59 31 148 143 230 139 177 66 180 36 126 197 19 213 156 213 237 164 140 116 41 157 46 96 217 214 148 216 248 116 123 190 198 94 200 54 15 6 151 235 249 237 234 113 1 30 194 171 236 212 232 74 247 52 145 213 147 38 77 26 241 208 67 15 205 46 102 242 147 43 47 134 97 84 168 203 49 52 233 61 35 212 3 40 20 24 54 205 178 208 231 177 77 39 114 21 159 81 83 35 165 193 132 46 163 242 18 62 26 143 175 213 29 127 124 4 101 114 0 145 203 110 174 36 240 84 32 117 147 74 48 53 8 87 45 142 36 74 157 42 236 171 86 147 131 64 109 90 39 64 221 122 70 228 145 1 99 20 7 108 51 118 116 95 72 60 211 79 163 60 43 87 29 141 231 72 237 234 185 122 62 121 172 99 89 7 243 151 245 73 243 235 173 250 75 237 170 61 65 187 184 197 111 47 247 147 174 194 186 249 161 142 30 240 137 33 137 158 9 255 196 199 144 167 226 175 248 28 242 92 190 240 248 253 223 255 253 57 194 135 232 106 72 120 149 93 79 201 212 171 97 79 66 139 151 44 185 103 194 255 249 191 127 115 125 211 201 227 155 163 241 58 233 230 178 11 22 205 109 77 177 138 10 160 46 217 124 214 49 16 84 175 198 210 42 8 131 19 245 138 201 169 147 6 72 43 234 21 216 108 96 84 171 173 229 52 27 237 75 147 53 116 249 7 104 96 152 218 46 92 153 64 96 90 250 227 164 144 143 32 82 154 193 168 206 216 39 176 204 115 36 217 178 119 148 70 22 147 72 117 208 144 84 88 185 222 221 1 155 202 73 66 145 74 45 18 201 183 48 122 87 83 6 147 84 149 162 114 200 160 89 10 243 19 156 164 16 13 136 106 32 89 235 244 168 107 170 192 98 131 164 156 133 249 146 126 96 66 107 199 90 57 242 87 166 164 110 145 116 171 19 235 192 196 252 169 142 212 108 194 201 187 164 184 57 219 74 203 96 64 166 93 109 163 49 189 99 211 59 89 86 181 249 108 243 64 222 142 158 118 247 221 75 198 83 39 57 225 36 188 202 78 15 232 233 254 133 132 53 51 102 76 31 253 181 175 126 121 110 177 43 119 125 101 6 198 73 51 157 57 125 238 234 208 178 22 55 192 207 139 201 240 1 36 83 177 26 8 165 94 49 58 249 106 61 109 85 183 214 126 149 250 170 45 203 105 80 19 98 186 162 30 79 152 252 8 170 102 20 166 132 233 172 210 210 60 59 4 146 145 149 222 192 202 144 8 0 3 105 145 47 149 43 169 113 108 42 65 161 101 137 131 161 241 158 84 121 157 231 218 125 186 95 229 156 82 110 240 44 61 23 228 85 166 213 199 31 61 168 159 110 230 159 234 173 250 171 29 106 143 218 165 176 132 84 237 229 190 114 251 197 15 241 69 249 249 107 252 50 190 153 33 132 117 6 63 141 175 240 87 83 20 241 91 252 7 135 105 95 254 242 31 205 21 46 68 215 64 194 233 20 215 83 50 117 241 0 244 4 180 96 249 178 101 147 127 244 79 63 158 181 125 251 206 109 209 154 164 125 162 36 205 137 1 48 44 213 213 113 50 147 253 169 84 132 30 228 37 141 216 102 46 97 240 56 34 36 148 41 73 2 14 152 181 102 21 67 26 65 93 111 109 177 55 137 228 74 227 98 45 128 36 4 163 144 50 3 92 18 41 70 208 213 185 4 3 229 35 39 172 3 8 52 130 54 94 138 177 92 70 62 204 55 70 171 115 82 142 63 102 18 22 31 241 204 137 41 146 70 173 16 152 23 196 139 48 86 162 170 105 9 15 146 160 80 8 39 6 252 124 146 83 230 41 200 153 37 35 156 186 0 234 156 24 40 240 124 109 161 73 104 181 180 192 138 32 205 240 193 212 154 95 134 1 56 206 217 114 93 213 120 75 87 97 221 214 77 234 13 8 86 35 50 12 218 49 138 207 114 176 12 227 73 70 85 54 194 25 33 72 252 109 239 208 98 132 91 106 111 58 57 108 242 228 73 51 239 187 239 190 73 170 56 78 248 8 167 83 92 185 165 167 164 58 206 207 136 191 48 109 218 180 250 175 124 229 145 121 197 98 102 70 120 93 106 84 226 47 221 142 25 46 181 234 49 191 212 84 68 227 35 32 233 189 15 157 248 208 240 166 45 73 73 164 97 164 222 42 145 225 178 248 173 241 177 76 97 207 86 175 150 106 149 78 67 2 109 238 40 31 222 105 156 52 32 77 66 192 8 96 77 189 42 46 233 50 9 147 47 65 80 90 207 116 174 209 239 237 186 93 83 190 30 247 89 57 97 217 92 87 199 33 175 234 201 243 169 7 120 88 189 84 191 64 66 213 142 114 253 43 218 100 237 228 102 93 167 40 57 245 101 241 195 231 143 248 36 126 137 111 226 159 248 40 126 138 175 226 175 248 44 126 139 255 194 65 120 80 223 23 32 225 243 49 119 38 48 15 147 243 49 229 166 55 76 94 190 124 197 109 185 150 142 201 200 156 246 152 74 73 199 30 194 131 88 174 70 47 232 31 211 14 36 46 166 180 96 254 105 131 189 38 99 70 136 150 124 228 72 61 87 139 4 26 43 21 246 85 178 132 8 230 168 197 101 73 83 88 99 35 60 231 130 77 65 4 146 164 81 32 40 108 68 88 224 132 113 25 67 33 97 146 0 66 15 18 243 195 60 220 87 190 183 178 28 191 124 95 197 251 101 155 10 13 234 163 58 116 215 83 245 86 253 195 182 168 93 126 251 176 207 44 172 106 88 251 141 23 2 84 96 169 195 139 95 62 160 62 31 197 79 241 21 16 225 114 210 57 114 224 192 164 229 247 221 191 144 223 163 190 142 58 201 9 23 225 243 49 119 38 48 149 81 55 61 86 95 95 63 228 225 47 254 151 89 236 106 207 200 229 50 172 159 7 96 21 37 153 33 80 112 26 85 41 176 164 42 43 157 41 82 90 174 198 163 58 233 230 24 58 166 6 217 229 160 187 27 87 228 131 171 86 116 184 102 8 163 147 8 107 113 64 82 41 117 106 82 2 96 166 86 203 32 82 71 3 67 62 247 10 36 117 125 179 66 241 181 46 166 125 49 157 123 236 246 149 30 230 9 238 169 44 167 34 28 60 207 87 235 170 135 95 31 234 165 250 169 214 84 82 245 86 253 85 97 85 84 237 226 114 160 137 56 41 65 187 85 127 8 23 28 64 227 70 223 249 124 19 255 2 30 250 128 195 223 142 142 182 234 92 103 118 214 151 224 127 67 67 195 96 234 101 152 224 159 214 157 13 76 38 203 206 63 66 187 239 89 178 100 234 119 190 243 157 123 51 153 182 155 217 153 116 226 53 0 89 21 53 43 214 111 133 122 162 248 171 138 249 146 166 136 212 133 120 37 208 37 56 68 66 162 129 132 233 206 240 64 189 90 237 34 13 168 164 90 153 147 73 51 51 186 149 65 68 221 153 196 114 93 15 82 56 148 78 11 219 131 66 128 124 240 216 14 97 6 95 98 179 146 41 76 165 175 244 0 224 110 224 169 232 153 202 182 58 217 243 195 177 58 168 31 245 212 53 213 91 245 87 59 212 30 181 203 218 71 26 233 214 102 181 95 124 240 249 225 27 133 240 142 52 195 216 248 23 242 82 210 41 254 238 223 191 235 198 111 127 251 91 119 227 166 240 156 221 144 240 16 46 167 117 103 3 83 55 172 134 254 129 194 163 159 253 236 103 175 95 188 248 246 219 121 192 117 9 116 57 27 239 76 134 19 166 102 81 25 26 67 165 251 81 181 221 36 117 162 6 72 197 136 255 126 215 245 59 52 90 137 116 105 45 45 233 152 10 45 171 41 117 4 241 197 239 0 138 169 99 251 198 14 1 3 143 123 13 104 49 209 136 204 38 45 48 87 192 1 190 207 185 64 242 140 139 21 97 93 87 190 240 30 245 182 176 44 61 67 142 182 91 199 233 126 182 128 225 42 192 248 245 179 140 86 111 165 170 29 126 123 76 27 171 125 1 233 46 181 223 87 181 1 95 202 188 18 223 66 30 10 72 241 245 157 117 111 78 186 249 230 185 183 127 230 51 159 185 94 252 23 14 144 240 56 163 59 23 152 186 241 239 161 39 175 187 238 186 145 143 60 242 200 45 45 45 39 102 239 219 177 103 136 30 232 143 153 33 144 122 135 82 70 80 184 152 128 66 146 181 32 22 153 116 42 30 54 142 110 174 246 193 17 108 29 210 101 168 178 38 77 64 97 241 149 107 230 48 30 1 205 151 74 37 80 23 25 27 0 86 146 49 162 185 167 24 110 64 250 32 154 90 166 241 28 152 12 72 2 16 82 152 38 95 42 83 229 133 160 170 28 149 103 229 82 190 158 163 235 193 115 173 30 126 125 84 17 165 234 177 65 189 169 164 194 106 143 33 77 251 4 30 69 88 187 79 229 131 94 118 18 201 174 208 176 101 139 44 6 40 115 114 103 235 214 205 131 249 234 214 236 71 30 249 195 155 248 97 113 45 16 104 78 41 28 206 234 206 7 204 35 148 240 3 104 59 198 208 180 239 125 239 123 203 247 238 221 197 207 47 104 197 74 99 129 86 125 226 106 26 62 11 55 244 93 84 7 252 240 43 204 125 1 160 154 142 216 218 153 198 20 3 77 183 51 222 168 71 179 179 200 58 166 129 105 227 146 152 104 68 49 170 163 245 126 165 225 52 25 215 3 148 46 37 101 249 0 132 110 227 143 167 150 206 220 144 188 70 196 205 74 149 31 166 201 87 62 145 238 211 253 132 37 238 6 160 202 215 115 112 122 78 232 155 202 84 92 20 60 207 198 9 213 255 148 246 8 100 202 80 7 85 187 213 14 1 202 125 240 73 220 241 249 36 126 249 124 19 255 226 58 232 21 217 188 121 211 205 143 62 250 63 239 197 232 153 74 254 237 144 248 47 28 206 234 84 209 243 113 171 200 244 55 202 136 186 189 225 243 159 255 252 138 23 95 124 110 1 252 8 212 136 233 65 191 134 44 39 219 126 15 127 201 174 6 233 148 147 133 21 87 119 133 19 196 201 21 2 169 22 193 52 218 75 125 252 149 18 117 14 164 64 221 223 152 105 0 6 76 12 128 228 14 159 209 167 1 210 7 36 0 139 231 74 63 148 193 83 92 36 132 194 240 169 128 250 229 134 207 33 143 52 129 1 168 250 4 245 82 155 172 190 170 183 234 175 158 28 2 170 246 169 157 106 47 206 218 47 62 136 31 138 251 206 184 99 65 21 43 22 252 242 151 79 204 251 244 167 31 92 246 187 191 251 187 211 116 35 78 124 23 255 207 233 206 23 76 21 164 66 255 138 23 59 107 255 224 15 190 116 195 45 183 220 178 228 169 167 126 62 83 23 84 17 254 171 146 97 45 131 202 154 130 181 193 171 156 224 55 72 185 213 147 173 97 42 194 39 177 69 170 203 151 70 165 193 68 161 170 124 228 55 169 52 112 137 195 37 159 193 42 203 143 155 4 137 123 129 196 217 120 90 6 146 98 44 140 95 206 19 0 170 184 106 19 148 227 151 171 52 61 95 207 37 108 245 80 92 97 159 168 174 95 95 171 95 144 46 64 85 99 211 64 106 76 232 252 135 235 239 169 142 251 76 163 61 254 248 79 102 78 159 62 237 238 135 31 126 120 26 47 64 235 13 131 191 130 76 136 148 231 92 78 149 186 16 167 194 127 33 61 254 213 175 126 245 38 126 173 252 206 149 43 159 158 162 193 155 6 179 210 28 250 182 115 169 180 83 136 150 139 99 154 216 169 3 24 137 71 172 138 138 43 214 32 36 83 29 67 117 50 230 5 205 46 3 106 113 174 33 149 1 3 5 60 252 131 225 34 238 19 43 149 95 225 143 73 99 152 86 145 167 226 94 95 152 244 108 149 207 3 78 125 174 95 110 80 5 85 95 85 176 250 90 253 213 14 221 18 182 77 237 84 123 21 231 33 61 40 97 6 16 233 198 183 95 252 226 231 147 248 241 182 219 191 252 229 175 204 153 58 117 170 78 220 233 39 21 197 239 243 118 23 10 230 30 74 254 75 232 149 5 11 22 140 253 198 55 190 113 43 75 86 11 159 122 234 95 199 171 157 146 78 57 61 157 191 230 179 233 99 106 150 77 245 242 53 198 17 174 153 154 85 30 159 24 115 148 166 114 72 35 236 31 151 12 174 171 158 162 224 154 194 149 18 98 215 2 233 50 16 67 201 11 129 149 31 146 202 57 229 122 16 87 90 248 156 158 229 87 60 55 168 175 95 63 90 172 250 210 90 171 191 127 141 225 195 210 252 118 250 173 82 251 165 102 197 15 158 163 59 2 223 117 159 124 242 137 241 24 150 183 125 237 107 95 155 191 96 193 252 209 92 126 5 18 159 247 64 231 237 34 143 62 250 232 121 103 14 50 238 199 215 96 124 195 132 9 19 166 14 25 50 164 122 229 202 103 10 71 143 31 109 157 49 125 90 51 231 92 220 68 76 167 240 224 29 75 35 105 22 144 213 47 145 94 52 18 194 195 31 96 215 117 50 72 152 52 191 212 188 95 198 138 196 65 147 107 127 145 128 68 147 44 93 20 201 210 148 252 41 15 207 15 169 60 246 169 39 4 233 210 101 234 90 33 104 97 186 24 168 116 117 27 138 51 134 106 97 85 97 105 6 237 105 42 12 14 160 133 253 34 82 34 55 129 133 118 83 108 33 86 215 21 55 124 40 78 190 142 141 48 7 4 74 48 163 150 156 213 212 166 10 62 231 172 209 186 122 233 161 200 98 17 39 116 237 61 22 222 179 247 138 63 255 249 47 234 183 109 219 186 224 91 223 250 214 34 12 30 173 189 234 13 131 63 133 94 130 46 200 169 145 23 227 86 114 211 119 161 237 191 249 155 191 57 133 5 133 187 118 239 220 185 232 137 95 74 66 105 26 46 24 232 21 236 225 236 186 229 1 180 192 149 207 232 40 93 69 152 175 139 48 72 94 24 183 251 122 196 43 175 41 172 27 66 10 165 45 4 190 50 30 230 145 223 179 140 202 56 151 187 175 7 245 177 180 138 122 42 63 206 111 71 119 187 116 159 207 15 255 122 247 95 241 231 137 95 60 62 102 235 246 45 183 126 243 155 223 188 227 55 126 227 55 180 119 44 203 85 124 21 127 47 216 169 33 23 235 158 224 198 63 135 118 62 240 192 3 83 254 251 183 191 125 231 254 189 187 238 248 201 63 253 88 189 203 156 90 162 128 205 177 152 76 8 38 255 138 245 223 48 28 248 33 160 161 31 22 17 222 81 246 149 191 124 111 80 100 152 102 126 144 22 130 36 73 44 19 247 86 166 171 208 211 221 91 46 191 226 89 202 27 186 240 58 241 176 190 161 239 215 205 87 181 65 118 42 128 142 176 41 154 82 184 217 253 201 143 126 52 97 199 182 29 11 191 241 199 127 124 7 252 19 207 118 66 226 167 248 122 81 238 98 212 108 229 131 164 18 180 113 61 141 69 133 73 124 245 162 110 205 218 53 137 13 27 55 100 231 205 159 223 196 33 117 169 87 25 24 90 183 162 83 75 205 74 99 74 189 134 106 86 170 85 6 12 167 28 109 13 86 199 71 194 181 88 51 102 76 170 140 29 244 11 141 204 60 143 52 51 86 148 87 64 169 140 32 221 226 10 91 156 116 49 62 188 86 86 169 164 153 42 197 151 90 85 186 212 166 212 168 212 100 64 150 71 111 21 113 68 200 222 228 212 61 138 75 176 228 51 15 211 107 11 242 245 42 182 222 69 81 186 205 207 44 157 178 10 156 248 145 197 160 247 237 245 140 194 223 253 224 7 147 249 81 217 91 191 252 200 31 221 130 106 29 71 154 36 242 207 160 31 67 23 237 212 200 75 117 170 192 159 64 27 151 44 89 50 238 91 223 252 230 130 116 50 121 239 95 126 239 123 55 229 114 156 66 164 165 23 249 128 211 221 87 153 86 25 14 31 209 51 141 167 91 146 254 136 145 149 241 240 30 249 61 239 235 153 118 174 235 149 101 157 49 204 23 189 188 239 127 255 251 179 24 86 239 254 250 215 190 118 203 61 247 220 51 134 204 18 8 241 239 146 128 228 126 231 82 37 83 101 200 125 0 237 133 88 220 111 184 97 226 196 137 3 26 27 247 13 125 252 137 199 157 33 3 7 182 142 26 53 138 239 72 33 125 72 39 50 132 17 35 75 72 107 175 190 133 233 75 165 226 102 201 151 211 233 229 146 58 25 56 234 116 38 125 126 90 89 210 184 238 75 162 210 201 99 68 88 210 24 74 36 65 34 24 57 1 146 146 174 16 92 133 77 218 2 95 146 105 18 170 56 165 96 208 132 134 142 127 122 143 235 202 175 116 187 143 190 66 126 59 167 87 33 157 152 172 24 69 146 80 29 12 83 126 126 252 187 230 239 254 246 111 103 142 31 63 126 209 151 190 244 165 235 230 204 153 163 183 183 94 129 254 20 250 87 232 146 93 111 129 169 138 72 85 124 8 13 96 97 225 198 233 211 111 24 192 185 255 193 143 61 246 88 228 100 75 75 113 214 140 217 45 12 154 166 102 105 168 173 150 162 49 165 127 5 82 0 36 81 166 155 126 220 212 169 118 53 44 78 185 82 173 22 230 126 64 179 137 189 226 101 34 143 192 36 137 28 62 152 120 6 106 40 89 98 108 79 32 149 86 38 31 76 3 204 84 166 174 5 0 155 170 228 230 60 242 45 53 43 165 35 32 117 38 15 95 47 121 10 68 212 173 172 91 212 42 199 125 80 173 110 254 103 143 255 180 225 95 126 249 203 27 150 45 91 182 224 161 135 30 154 48 118 236 216 58 202 213 60 82 64 190 4 245 138 83 119 237 149 130 42 10 25 77 248 235 1 57 207 60 179 114 15 19 226 29 224 181 241 247 126 239 11 59 104 72 30 120 120 29 128 173 77 206 142 32 160 118 24 25 232 116 232 88 243 24 173 92 234 117 41 157 241 81 88 159 16 225 149 106 124 108 8 165 3 57 219 90 90 72 183 188 26 140 195 48 128 251 107 172 220 167 176 73 106 224 227 153 235 1 156 73 94 0 12 223 120 226 235 5 148 45 201 227 109 32 151 143 26 240 105 60 199 225 123 174 188 11 95 42 241 73 146 18 135 60 74 89 229 83 58 225 12 178 199 61 5 210 44 158 101 70 146 229 163 65 217 189 123 247 122 63 250 209 143 198 114 134 246 250 79 125 234 83 227 238 189 247 222 6 171 129 191 24 160 5 129 61 65 188 87 188 222 148 204 176 66 58 238 249 28 164 119 6 39 76 154 52 113 220 228 201 147 7 30 109 58 58 244 159 255 249 39 177 206 206 118 119 250 244 25 45 38 157 38 85 54 175 4 43 173 205 74 237 250 106 19 128 4 4 146 10 244 128 194 53 226 190 42 37 37 136 91 186 58 164 226 114 220 226 91 147 22 240 227 10 170 199 150 65 84 152 123 20 71 162 186 9 128 202 113 202 178 48 249 202 105 228 229 181 47 95 34 3 223 212 176 175 106 245 22 24 175 144 73 237 242 6 253 19 79 60 49 146 31 44 101 49 103 202 205 95 248 194 23 38 204 155 55 79 106 85 218 75 210 248 103 80 207 99 177 36 93 154 187 28 146 89 89 163 187 137 252 33 244 0 189 179 240 194 11 47 28 252 183 127 251 183 70 222 152 218 186 124 197 138 198 91 231 207 111 133 41 146 76 36 213 246 18 36 153 129 164 154 180 153 116 114 191 78 6 196 129 196 36 80 146 73 154 73 39 247 74 2 21 151 132 106 177 64 241 144 76 50 73 35 201 119 128 163 64 8 108 25 48 128 20 48 38 145 2 144 123 36 121 161 100 242 98 8 210 199 113 11 210 202 82 25 72 113 183 68 22 114 185 55 222 120 43 245 171 149 191 186 150 94 57 145 93 166 145 139 23 47 190 134 253 72 213 71 219 88 218 253 88 5 93 22 119 185 193 84 165 135 65 95 132 30 134 198 52 54 54 182 61 255 252 243 71 87 175 94 189 123 248 200 145 141 247 223 119 223 126 94 77 203 250 96 58 9 164 78 192 216 145 73 249 34 64 178 52 132 211 212 44 105 204 119 252 195 88 48 222 214 175 73 51 48 241 205 80 146 15 9 76 33 25 146 144 12 201 36 147 251 205 15 193 36 110 210 71 62 1 105 224 18 70 157 90 184 12 164 210 216 174 50 85 203 18 81 238 195 15 183 68 159 121 230 233 225 251 246 237 171 95 180 104 81 253 93 119 221 53 4 99 144 55 226 237 132 192 63 224 255 61 116 206 109 44 242 92 180 187 18 96 134 149 91 76 224 33 232 115 74 248 224 131 15 78 34 169 199 248 193 242 189 19 199 143 63 200 209 136 35 51 102 204 226 219 29 165 50 128 72 71 8 164 129 41 201 3 9 93 215 209 47 1 171 116 249 2 78 190 133 67 235 151 120 37 152 68 205 157 2 102 240 166 151 36 84 192 137 194 112 142 243 144 138 235 219 245 2 81 97 73 102 56 174 26 176 91 182 108 137 63 247 220 170 193 219 182 109 25 198 107 233 215 34 137 131 232 156 181 228 147 123 12 250 71 104 181 34 151 219 93 73 48 213 22 49 251 115 1 221 169 132 247 222 123 175 249 181 215 214 156 120 235 173 55 15 241 113 162 35 183 222 122 219 177 69 139 22 242 177 171 192 248 233 150 76 1 103 7 181 228 7 96 26 128 104 78 12 37 3 206 192 228 186 63 214 250 250 53 148 74 146 205 25 152 72 32 90 211 166 13 225 152 168 241 78 211 17 73 155 128 227 75 3 62 152 100 84 154 17 183 200 207 190 246 218 107 85 175 190 250 234 192 195 135 15 15 158 53 107 214 48 54 30 234 120 131 46 4 241 5 242 8 72 145 202 186 34 238 74 131 25 54 74 198 192 103 160 79 67 11 148 184 109 219 182 182 55 223 124 179 229 245 215 95 111 230 109 168 67 48 166 21 117 213 60 102 204 24 141 95 49 44 90 251 180 44 89 1 85 7 171 76 29 27 152 164 133 146 41 63 36 45 51 133 64 202 15 157 129 137 68 202 55 21 139 95 6 52 8 27 152 82 159 178 98 73 211 251 240 185 157 31 125 20 93 187 118 109 213 198 141 27 249 26 135 55 236 166 155 110 170 65 26 107 38 77 154 36 117 42 183 6 210 114 220 207 160 211 30 135 36 253 178 185 171 5 102 216 160 145 4 126 11 122 0 146 26 118 78 156 56 145 219 176 97 67 219 59 239 188 211 182 121 243 230 102 94 49 108 97 255 180 125 246 236 217 29 83 167 94 175 41 130 73 104 0 104 8 166 252 16 68 249 82 175 33 133 128 146 100 206 192 36 36 32 67 10 193 148 31 2 137 95 202 163 70 163 212 39 245 225 150 45 169 147 39 78 212 2 92 13 117 73 211 217 170 168 155 234 34 39 53 42 3 71 175 12 28 128 174 138 187 218 96 134 141 214 174 250 10 104 57 180 20 26 8 57 24 19 153 15 63 252 176 99 211 166 77 153 237 219 183 235 39 2 90 71 53 52 100 216 122 203 178 202 148 155 50 101 106 22 9 13 1 13 193 12 65 12 253 80 42 229 11 72 185 80 42 67 48 229 27 160 60 47 186 99 199 142 248 142 29 59 227 251 246 237 149 197 92 197 252 42 117 253 148 41 9 214 159 83 156 35 214 152 45 167 53 233 103 33 189 86 247 52 212 10 93 85 215 87 192 172 100 194 205 68 238 134 238 132 238 8 47 232 183 87 62 250 232 163 204 174 93 187 50 59 119 238 204 225 231 249 144 67 199 208 161 67 242 67 135 14 43 14 25 50 180 192 222 42 254 160 194 0 94 37 23 241 138 156 222 164 210 135 8 245 69 16 251 46 44 223 77 119 155 155 155 61 52 0 31 82 58 238 29 61 122 212 107 106 58 30 109 106 58 26 17 165 211 85 201 177 99 199 68 199 142 29 27 27 55 110 92 140 229 183 4 31 141 80 71 9 221 139 4 94 128 86 65 111 134 137 125 193 239 139 96 86 242 101 33 145 219 160 249 208 92 104 16 100 14 67 164 180 127 255 254 60 6 72 30 64 10 77 77 77 133 99 199 142 21 1 73 63 218 82 228 39 239 245 67 50 246 25 51 189 153 172 243 188 204 247 236 75 40 124 59 199 171 171 171 115 81 147 238 224 193 131 35 34 206 220 68 48 192 34 124 175 94 219 60 225 99 228 107 241 227 117 104 45 244 42 244 10 212 39 93 95 7 179 146 105 19 136 204 129 102 66 211 161 105 208 40 168 183 221 94 10 212 119 144 180 155 177 1 90 15 237 128 250 188 251 255 34 145 104 56 151 105 41 197 0 0 0 0 73 69 78 68 174 66 96 130]
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

	| parser params valueReader documentSource documentNode module expressionSource expressionNode transpiledSpec prestates result json |
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
				          (documentNode moduleNamed: m) ifNil: [
						          ^ self responseJSON: (json
								             at: 'message' put: 'Unknown module: ' , m;
								             yourself) ] ]
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
						          ^ self responseJSON: json ] ].
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
	^ (aZnRequest contentType notNil
		and: [ aZnRequest contentType main = 'application' and: [ aZnRequest contentType sub asLowercase = 'json' ] ])
		ifTrue: [ NeoJSONReader fromString: aZnRequest entity ]
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
		              at: '/' put: #mainPage;
		              at: 'EpiLog' put: #epiLogPage;
		              at: 'epilog.css' put: #epilogCss;
		              at: 'foundation.css' put: #foundationCss;
		              at: 'favicon.ico' put: #vdmpadIcon;
		              at: 'about.html' put: #aboutPage;
		              at: 'VDMPad.js' put: #VDMPad;
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
		              at: 'vdmj-3.0.1.jar' put: #binaryFileService:;
		              at: 'vdmj-3.1.1.jar' put: #binaryFileService:;
		              at: 'vdmj-3.2.0.jar' put: #binaryFileService:;
		              at: 'Json4VDMJ.jar' put: #binaryFileService:;
		              yourself
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
VDMPad >> mainPage [

	^ self responseHtml:
		  '<!DOCTYPE html><html>
<head>
    <title>VDMPad</title>
    <meta charset="utf-8">
        <link rel="stylesheet" href="epilog.css">
        <script src="/blob.js"></script>
        <script src="/fileSaver.js"></script>
        <style>
            body { padding: 1.5rem; background-color: #fbfbfb; font-family: Helvetica sans-serif}
            .editor-container { 
                max-width: 56rem; margin: 0 auto; 
                background: white; border-radius: 0.25rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1); 
            }
            .cm-editor {
                font-family: Helvetica sans-serif;
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
      <div id="root_menu" style="margin-top: 40px" width: 100%>
        <img id="rootMenuIcon" src="/rootMenuOff.png" alt="root menu">
      </div>
      <div id="file_items" style="width: 100%"></div>
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
        <hr>
        <div title="Displays error messages"  id="message" style="white-space: pre-wrap"></div>
        <div id="unittest"></div>
      </div>
    </div>
  </div>
  <div id="EpiLogArea" style="float:left; margin-left: 60px; width: 800px;"></div>

  <script type="module" src="/VDMPad.js"></script>
</body>
</html>' withUnixLineEndings
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
