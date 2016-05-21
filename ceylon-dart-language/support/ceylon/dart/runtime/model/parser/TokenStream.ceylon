import ceylon.dart.runtime.model.internal {
    eq
}

shared
class TokenStream(List<Character> characters) satisfies {Token*} {

    shared actual
    Iterator<Token> iterator() => object satisfies Iterator<Token> {
        variable List<Character> characters
            // workaround https://github.com/ceylon/ceylon/issues/6237
            =   if (outer.characters is String)
                then outer.characters.sequence()
                else outer.characters;

        void consume(Integer count = 1) {
            characters = characters.sublistFrom(count);
        }

        shared actual
        Token|Finished next() {
            "Given an initial character of an identifier, consumes that character, then
             reads on until the identifier is finished."
            Token identifier(Character first) {
                consume();
                StringBuilder text = StringBuilder();
                text.appendCharacter(first);
                Boolean lowercase = first.lowercase;
                while (exists next = characters[0], isIdentifierPart(next)) {
                    text.appendCharacter(next);
                    consume();
                }
                return if (lowercase)
                       then LIdentifier(text.string)
                       else UIdentifier(text.string);
            }

            value first = characters[0];
            if (!exists first) {
                return finished;
            }

            switch (first)
            case ('/') {
                // start of comment?
                switch (characters[1])
                case ('/') {
                    // line comment
                    value line = characters.takeWhile(not('\n'.equals)).sequence();
                    consume(line.size);
                    return LineComment(String(line));
                }
                case ('*') {
                    // multi comment
                    consume(2);
                    StringBuilder text = StringBuilder();
                    text.append("/*");
                    variable Integer level = 1;
                    while (level != 0) {
                        value next = characters[0];
                        if (!exists next) {
                            return OpenMultiComment(text.string);
                        }
                        else if (next == '/', eq(characters[1], '*')) {
                            level++;
                            text.append("/*");
                            consume(2);
                        } else if (next == '*', eq(characters[1], '/')) {
                            level--;
                            text.append("*/");
                            consume(2);
                        } else {
                            text.appendCharacter(next);
                            consume();
                        }
                    }
                    return MultiComment(text.string);
                }
                else {
                    consume();
                    return UnknownCharacter(first.string);
                }
            }
            case ('#') {
                if (eq(characters[1], '!')) {
                    #! line comment
                    value line = characters.takeWhile(not('\n'.equals)).sequence();
                    consume(line.size);
                    return LineComment(String(line));
                }
                else {
                    consume();
                    return UnknownCharacter(first.string);
                }
            }
            case ('\\') {
                switch (next = characters[1])
                case ('i') {
                    // forced lowercase identifier
                    value text = characters.takeWhile(isIdentifierPart).sequence();
                    consume(text.size);
                    return LIdentifier(String(text));
                }
                case ('I') {
                    // forced uppercase identifier
                    value text = characters.takeWhile(isIdentifierPart).sequence();
                    consume(text.size);
                    return UIdentifier(String(text));
                }
                else {
                    // unknown escape, consume only the backslash
                    consume();
                    return UnknownEscape("\\");
                }
            }
            case ('0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9') {
                // numeric literal, we don’t know yet which kind
                consume();
                StringBuilder text = StringBuilder();
                text.appendCharacter(first);
                while (exists next = characters[0], '0' <= next <= '9' || next == '_') {
                    text.appendCharacter(next);
                    consume();
                }
                switch (next = characters[0])
                case ('k' | 'M' | 'G' | 'T' | 'P') {
                    // regular magnitude
                    text.appendCharacter(first);
                    consume();
                    return DecimalLiteral(text.string);
                }
                else {
                    // belongs to the next token
                    return DecimalLiteral(text.string);
                }
            }
            case ('i') {
                if (eq(characters[1], 'n')) {
                    value next = characters[2];
                    if (exists next, isIdentifierPart(next)) {
                        return identifier(first);
                    }
                    else {
                        consume(2);
                        return InKeyword();
                    }
                }
                else {
                    return identifier(first);
                }
            }
            case ('o') {
                if (eq(characters[1], 'u') && eq(characters[2], 't')) {
                    value next = characters[3];
                    if (exists next, isIdentifierPart(next)) {
                        return identifier(first);
                    }
                    else {
                        consume(3);
                        return OutKeyword();
                    }
                }
                else {
                    return identifier(first);
                }
            }
            case (',') { consume(); return Comma(); }
            case ('{') { consume(); return LBrace(); }
            case ('}') { consume(); return RBrace(); }
            case ('(') { consume(); return LParen(); }
            case (')') { consume(); return RParen(); }
            case ('[') { consume(); return LBracket(); }
            case (']') { consume(); return RBracket(); }
            case ('.') { consume(); return MemberOp(); }
            case ('?') { consume(); return QuestionMark(); }
            case ('*') { consume(); return ProductOp(); }
            case ('=') { consume(); return Specify(); }
            case ('+') { consume(); return SumOp(); }
            case ('&') { consume(); return IntersectionOp(); }
            case ('|') { consume(); return UnionOp(); }
            case ('<') { consume(); return SmallerOp(); }
            case ('>') { consume(); return LargerOp(); }
            case ('^') { consume(); return Caret(); }
            case ('$') { consume(); return DollarSign(); }
            case ('-') {
                if (eq(characters[1], '>')) {
                    consume(2);
                    return EntryOp();
                }
                else {
                    consume();
                    return UnknownCharacter(first.string);
                }
            }
            case (':') {
                if (eq(characters[1], ':')) {
                    consume(2);
                    return DoubleColon();
                }
                else {
                    consume();
                    return UnknownCharacter(first.string);
                }
            }
            else {
                if (isIdentifierStart(first)) {
                    return identifier(first);
                } else {
                    if (first.whitespace) {
                        consume();
                        StringBuilder text = StringBuilder();
                        text.appendCharacter(first);
                        while (exists next = characters[0], next.whitespace) {
                            text.appendCharacter(first);
                            consume();
                        }
                        return Whitespace(text.string);
                    } else {
                        consume();
                        return UnknownCharacter(first.string);
                    }
                }
            }
        }
    };

    Boolean isIdentifierStart(Character character)
            => character.letter || character == '_';

    Boolean isIdentifierPart(Character character)
            => character.letter || character.digit || character == '_';
}
