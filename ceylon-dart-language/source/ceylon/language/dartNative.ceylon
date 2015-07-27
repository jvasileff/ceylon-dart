String dartJoin(String val, {Object*} objects) {
    variable value result = "";
    variable value first = true;
    for (el in objects) {
        if (first) {
            first = false;
        }
        else {
            result = result + val;
        }
        result = result + el.string;
    }
    return result;
}
