"A single token, that is, a fragment of code with a certain [[type]]."
shared abstract
class Token()
        of IgnoredToken | IdentifierToken | LiteralToken
            | KeywordToken | SymbolToken | ErrorToken {

    shared formal String type;
    shared formal String text;
    //shared Integer? column;
    //shared Integer? line;

    shared actual default String string {
        Boolean verbatimQuoteText;
        if (this is IdentifierToken) {
            verbatimQuoteText = text.startsWith("\\");
        } else { // TODO literal tokens
            verbatimQuoteText = false;
        }
        value quotes = verbatimQuoteText
                then "\"\"\""
                else "\"";
        return "``type``(``quotes````text````quotes``)";
    }
}

"An ignored token that’s not visible to the parser."
shared abstract class IgnoredToken()
        of Whitespace | LineComment | MultiComment
        extends Token() {}

"Whitespace."
shared class Whitespace(text) extends IgnoredToken() {
    shared actual String text;
    shared actual String type => "Whitespace";
}

"A single-line comment, for example:

     // comment
     #!/usr/bin/ceylon"
shared class LineComment(text) extends IgnoredToken() {
    shared actual String text;
    shared actual String type => "LineComment";
}

"A multi-line comment, for example:

     /*
      * comment
      */

     /* doesn’t actually have to be multi-line */

     /* can /* be */ nested */"
shared class MultiComment(text) extends IgnoredToken() {
    shared actual String text;
    shared actual String type => "MultiComment";
}

"""An identifier (with optional prefix), for example:

       Anything
       \iSOUTH"""
shared abstract class IdentifierToken()
        of LIdentifier | UIdentifier
        extends Token() {

    "The identifier, without a leading '\\I' or '\\i'."
    shared String identifier
        =>  if (text.startsWith("\\"))
            then text[2...]
            else text;
}

"""An initial lowercase identifier (with optional prefix), for example:

       null
       \iSOUTH"""
shared class LIdentifier(text) extends IdentifierToken() {
    shared actual String text;
    shared actual String type => "LIdentifier";
}

"""An initial uppercase identifier (with optional prefix), for example:

       Object
       \Iklass"""
shared class UIdentifier(text) extends IdentifierToken() {
    shared actual String text;
    shared actual String type => "UIdentifier";
}

"A literal value token."
shared abstract class LiteralToken()
        of NumericLiteralToken
        extends Token() {}

"A numeric literal."
shared abstract class NumericLiteralToken()
        of IntegerLiteralToken
        extends LiteralToken() {}

"An integer literal."
shared abstract class IntegerLiteralToken()
        of DecimalLiteral
        extends NumericLiteralToken() {}

"A decimal integer literal, with an optional magnitude, for example:

     10_000
     10k"
shared class DecimalLiteral(text) extends IntegerLiteralToken() {
    shared actual String text;
    shared actual String type => "DecimalLiteral";
}

"A keyword."
shared abstract class KeywordToken()
        of InKeyword | OutKeyword | PackageKeyword
        extends Token() {}

"The ‘`package`’ keyword."
shared class PackageKeyword() extends KeywordToken() {
    shared actual String text => "package";
    shared actual String type => "PackageKeyword";
}

"The ‘`in`’ keyword."
shared class InKeyword() extends KeywordToken() {
    shared actual String text => "in";
    shared actual String type => "InKeyword";
}

"The ‘`out`’ keyword."
shared class OutKeyword() extends KeywordToken() {
    shared actual String text => "out";
    shared actual String type => "OutKeyword";
}

"A symbol, that is, an operator or punctuation."
shared abstract
class SymbolToken()
        of Comma | LBrace | RBrace | LParen | RParen | LBracket | RBracket | QuestionMark
            | MemberOp | Specify | SumOp | ProductOp | EntryOp | IntersectionOp | UnionOp
            | SmallerOp | LargerOp | DoubleColon | Caret | DollarSign
        extends Token() {}

"Two colons: ‘`::`’"
shared class DoubleColon() extends SymbolToken() {
    shared actual String text => "::";
    shared actual String type => "DoubleColon";
}

"A comma: ‘`,`’"
shared class Comma() extends SymbolToken() {
    shared actual String text => ",";
    shared actual String type => "Comma";
}

"A left brace: ‘`{`’"
shared class LBrace() extends SymbolToken() {
    shared actual String text => "{";
    shared actual String type => "LBrace";
}

"A right brace: ‘`}`’"
shared class RBrace() extends SymbolToken() {
    shared actual String text => "}";
    shared actual String type => "RBrace";
}

"A left parenthesis: ‘`(`’"
shared class LParen() extends SymbolToken() {
    shared actual String text => "(";
    shared actual String type => "LParen";
}

"A right parenthesis: ‘`)`’"
shared class RParen() extends SymbolToken() {
    shared actual String text => ")";
    shared actual String type => "RParen";
}

"A left bracket: ‘`[`’"
shared class LBracket() extends SymbolToken() {
    shared actual String text => "[";
    shared actual String type => "LBracket";
}

"A right bracket: ‘`]`’"
shared class RBracket() extends SymbolToken() {
    shared actual String text => "]";
    shared actual String type => "RBracket";
}

"A question mark: ‘`?`’"
shared class QuestionMark() extends SymbolToken() {
    shared actual String text => "?";
    shared actual String type => "QuestionMark";
}

"A member operator: ‘`.`’"
shared class MemberOp() extends SymbolToken() {
    shared actual String text => ".";
    shared actual String type => "MemberOp";
}

"An eager specification operator: ‘`=`’"
shared class Specify() extends SymbolToken() {
    shared actual String text => "=";
    shared actual String type => "Specify";
}

"A sum operator: ‘`+`’"
shared class SumOp() extends SymbolToken() {
    shared actual String text => "+";
    shared actual String type => "SumOp";
}

"A product or spread operator: ‘`*`’"
shared class ProductOp() extends SymbolToken() {
    shared actual String text => "*";
    shared actual String type => "ProductOp";
}

"An entry operator: ‘`->`’"
shared class EntryOp() extends SymbolToken() {
    shared actual String text => "->";
    shared actual String type => "EntryOp";
}

"An intersection operator: ‘`&`’"
shared class IntersectionOp() extends SymbolToken() {
    shared actual String text => "&";
    shared actual String type => "IntersectionOp";
}

"A union operator: ‘`|`’"
shared class UnionOp() extends SymbolToken() {
    shared actual String text => "|";
    shared actual String type => "UnionOp";
}

"A smaller-as operator: ‘`<`’"
shared class SmallerOp() extends SymbolToken() {
    shared actual String text => "<";
    shared actual String type => "SmallerOp";
}

"A larger-as operator: ‘`>`’"
shared class LargerOp() extends SymbolToken() {
    shared actual String text => ">";
    shared actual String type => "LargerOp";
}

"A dollar sign, which serves as a shortcut for the language module: ‘`$`’"
shared class DollarSign() extends SymbolToken() {
    shared actual String text => "$";
    shared actual String type => "DollarSign";
}

"A caret, which serves as a placeholder for a type: ‘`^`’"
shared class Caret() extends SymbolToken() {
    shared actual String text => "^";
    shared actual String type => "Caret";
}

"An erroneous token."
shared abstract class ErrorToken()
        of UnknownToken | OpenToken
        extends Token() {}

"A token where the lexer does not understand a character,
 but is able to proceed past it."
shared abstract class UnknownToken()
        of UnknownCharacter | UnknownEscape
        extends ErrorToken() {}

"A character that cannot begin any token."
shared class UnknownCharacter(text) extends UnknownToken()  {
    shared actual String text;
    shared actual String type => "UnknownCharacter";
}

"A character other than lower-or uppercase I after a backslash."
shared class UnknownEscape(text) extends UnknownToken()  {
    shared actual String text;
    shared actual String type => "UnknownEscape";
}

"A token that was not terminated. The token stream ends after this token."
shared abstract class OpenToken()
        of OpenMultiComment
        extends ErrorToken() {}

"An unterminated [[MultiComment]]."
shared class OpenMultiComment(text) extends OpenToken() {
    shared actual String text;
    shared actual String type => "OpenMultiComment";
}
