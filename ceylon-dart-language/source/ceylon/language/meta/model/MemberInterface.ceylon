"A member interface model that you can inspect."
native shared sealed interface MemberInterface<in Container=Nothing, out Type=Anything>
    satisfies InterfaceModel<Type> & Member<Container, Interface<Type>> {
    
    shared actual formal Interface<Type> bind(Object container);
}
