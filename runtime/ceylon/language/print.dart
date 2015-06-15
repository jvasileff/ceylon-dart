part of ceylon.language;

void print(core.Object val) {
  if (val == null) {
    print("<null>");
  }
  else {
    core.print(val);
  }
}
