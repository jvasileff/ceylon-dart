shared
class DartTypeModel(dartModule, name) extends Object() {
    shared String dartModule;
    shared String name;

    shared actual
    Boolean equals(Object that) {
        if (is DartTypeModel that) {
            return dartModule==that.dartModule &&
                name==that.name;
        }
        else {
            return false;
        }
    }

    shared actual
    Integer hash {
        variable value hash = 1;
        hash = 31*hash + dartModule.hash;
        hash = 31*hash + name.hash;
        return hash;
    }
}
