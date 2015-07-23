"Thrown when attempting to invoke something which can't be invoked, like abstract class
 initialisers."
native shared class InvocationException(String message) extends Exception(message){}
