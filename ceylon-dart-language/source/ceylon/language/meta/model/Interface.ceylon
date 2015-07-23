"An interface model that you can inspect."
native shared sealed interface Interface<out Type=Anything>
    satisfies InterfaceModel<Type> {}
