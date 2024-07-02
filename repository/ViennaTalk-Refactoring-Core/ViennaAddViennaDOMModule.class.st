Class {
	#name : 'ViennaAddViennaDOMModule',
	#superclass : 'ViennaAddModule',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaAddViennaDOMModule >> findContainerNode [

	^ super findContainerNode ifNotNil: [ :document | 
		  (document moduleNamed: self newName)
			  ifNotNil: [ nil ]
			  ifNil: [ document ] ]
]

{ #category : 'accessing' }
ViennaAddViennaDOMModule >> findNewName [

	^ 'ViennaDOM'
]

{ #category : 'accessing' }
ViennaAddViennaDOMModule >> name [
	^ 'Add ViennaDOM module'
]

{ #category : 'accessing' }
ViennaAddViennaDOMModule >> sortingOrder [
	^ 0.02
]

{ #category : 'accessing' }
ViennaAddViennaDOMModule >> sourceWithNewName: aString [

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
