import ceylon.dart.runtime.structures {
    LinkedListMultimap,
    ListMultimap
}

shared abstract
class Element() of Declaration satisfies Scope {

    LinkedListMultimap<String, Declaration> memberMap
        // note: insertion order must be preserved for TypeParameters
        =   LinkedListMultimap<String, Declaration>();

    shared actual formal
    Unit unit;

    shared actual formal
    Scope container;

    shared actual default
    Scope scope => container;

    shared actual // Better would be to have an unmodifiable list multimap wrapper
    ListMultimap<String, Declaration> members => memberMap;

    shared
    void addMember(Declaration member)
        =>  this.memberMap.put(member.name, member);

    shared
    void addMembers({Declaration*} members) {
        for (member in members) {
            addMember(member);
        }
    }
}
