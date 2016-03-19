package com.vasileff.ceylon.dart.compiler.loader;

import java.util.ArrayList;
import java.util.List;

import com.redhat.ceylon.model.typechecker.model.Class;
import com.redhat.ceylon.model.typechecker.model.ClassOrInterface;
import com.redhat.ceylon.model.typechecker.model.Constructor;
import com.redhat.ceylon.model.typechecker.model.Declaration;
import com.redhat.ceylon.model.typechecker.model.Function;
import com.redhat.ceylon.model.typechecker.model.ModelUtil;
import com.redhat.ceylon.model.typechecker.model.Module;
import com.redhat.ceylon.model.typechecker.model.Setter;
import com.redhat.ceylon.model.typechecker.model.TypeAlias;
import com.redhat.ceylon.model.typechecker.model.TypeDeclaration;
import com.redhat.ceylon.model.typechecker.model.TypedDeclaration;

public class TypeUtils {

    /** Returns the list of keys to get from the package to the declaration, in the model. */
    public static List<String> generateModelPath(final Declaration d) {
        final ArrayList<String> sb = new ArrayList<>();
        final String pkgName = d.getUnit().getPackage().getNameAsString();
        sb.add(Module.LANGUAGE_MODULE_NAME.equals(pkgName)?"$":pkgName);
        if (d.isToplevel()) {
            sb.add(d.getName());
            if (d instanceof Setter) {
                sb.add("$set");
            }
        } else {
            Declaration p = d;
            final int i = sb.size();
            while (p instanceof Declaration) {
                if (p instanceof Setter) {
                    sb.add(i, "$set");
                }
                final String mname = TypeUtils.modelName(p);
                if (!(mname.startsWith("anon$") || mname.startsWith("anonymous#"))) {
                    sb.add(i, mname);
                    //Build the path in reverse
                    if (!p.isToplevel()) {
                        if (p instanceof Class) {
                            sb.add(i, p.isAnonymous() ? MetamodelGenerator.KEY_OBJECTS : MetamodelGenerator.KEY_CLASSES);
                        } else if (p instanceof com.redhat.ceylon.model.typechecker.model.Interface) {
                            sb.add(i, MetamodelGenerator.KEY_INTERFACES);
                        } else if (p instanceof Function) {
                            if (!p.isAnonymous()) {
                                sb.add(i, MetamodelGenerator.KEY_METHODS);
                            }
                        } else if (p instanceof TypeAlias || p instanceof Setter) {
                            sb.add(i, MetamodelGenerator.KEY_ATTRIBUTES);
                        } else if (p instanceof Constructor || ModelUtil.isConstructor(p)) {
                            sb.add(i, MetamodelGenerator.KEY_CONSTRUCTORS);
                        } else { //It's a value
                            TypeDeclaration td=((TypedDeclaration)p).getTypeDeclaration();
                            sb.add(i, (td!=null&&td.isAnonymous())? MetamodelGenerator.KEY_OBJECTS
                                    : MetamodelGenerator.KEY_ATTRIBUTES);
                        }
                    }
                }
                p = ModelUtil.getContainingDeclaration(p);
                while (p != null  && p instanceof ClassOrInterface == false &&
                        !(p.isToplevel() || p.isAnonymous() || p.isClassOrInterfaceMember() || p.isCaptured())) {
                    p = ModelUtil.getContainingDeclaration(p);
                }
            }
        }
        return sb;
    }

    public static String modelName(Declaration d) {
        String dname = d.getName();
        if (dname == null && d instanceof com.redhat.ceylon.model.typechecker.model.Constructor) {
            dname = "$def";
        }
        if (dname.startsWith("anonymous#")) {
            dname = "anon$" + dname.substring(10);
        }
        if (d.isToplevel() || d.isShared()) {
            return dname;
        }
        if (d instanceof Setter) {
            d = ((Setter)d).getGetter();
        }
        return dname+"$"+Long.toString(Math.abs((long)d.hashCode()), 36);
    }

}
