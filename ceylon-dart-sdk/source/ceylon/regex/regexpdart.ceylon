import dart.core {
    RegExp
}
import ceylon.interop.dart {
    CeylonIterable, dartString
}

/*
 * Copyright Red Hat Inc. and/or its affiliates and other contributors
 * as indicated by the authors tag. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
native("dart")
class RegexDart(expression, global = false, ignoreCase = false, multiLine = false)
        extends Regex(expression, global, ignoreCase, multiLine) {
    String expression;
    Boolean global;
    Boolean ignoreCase;
    Boolean multiLine;

    shared actual variable Integer lastIndex = 0;

    RegExp ex;

    try {
        ex = RegExp.Class(expression, multiLine, !ignoreCase);
    } catch (Throwable th) {
        throw RegexException("Problem found within regular expression", th);
    }

    shared actual MatchResult? find(String input) {
        // Start the search at lastIndex if the global flag is true.
        value match
            =   if (global)
                // TODO Look into Character vs. code unit issues. For now, using Dart's
                //      substring since we're also (currently) using code units for
                //      lastIndex
                then (ex.firstMatch(dartString(input).substring(lastIndex).string) else null)
                else (ex.firstMatch(input) else null);

        if (exists match) {
            value groups = (1:match.groupCount).collect((i) => match.group(i) else null);
            variable value start = match.start;
            variable value end = match.end;
            if (global) {
                start += lastIndex;
                end += lastIndex;
                lastIndex += match.end;
            }
            return MatchResult(start, end, match.group(0), groups);
        }
        return null;
    }

    shared actual String[] split(String input, Integer limit) {
        if (limit == 0) {
            return [];
        }
        value allParts = dartString(input).split(ex);
        if (limit > 0) {
            return CeylonIterable(allParts.take(limit)).map(Object.string).sequence();
        }
        return CeylonIterable(allParts).map(Object.string).sequence();
    }

    shared actual String replaceDollarSignPattern(String input, String replacement)
        =>  if (global)
            then dartString(input).replaceAll(ex, replacement)
            else dartString(input).replaceFirst(ex, replacement);
}
