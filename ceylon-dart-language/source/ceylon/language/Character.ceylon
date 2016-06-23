import dart.core {
    DString = String,
    DStringClass = String_C
}
import ceylon.interop.dart {
    dartString
}

"""A 32-bit [Unicode][] character.
   
   Literal characters may be written between single quotes:
   
       ' '
       '\n'
       '\{#03C0}'
       '\{GREEK SMALL LETTER PI}'
   
   Every `Character` has a unique [[Integer]]-valued Unicode 
   _code point_.
   
       Integer piCodePoint = '\{GREEK SMALL LETTER PI}'.integer; // #03C0
       Character pi = #03C0.character; // GREEK SMALL LETTER PI
   
   Characters are [[Enumerable]], so character ranges may be
   produced using the [[measure]] and [[span]] operators.
   
       value lowerLatinLetters = 'a'..'z';
       value upperLatinLetters = 'A':26;
   
   Characters have a [[natural order|Comparable]] determined
   by their Unicode code points. So, for example, `'a'<'b'`,
   since `'a'.integer<'b'.integer`.
   
   [Unicode]: http://www.unicode.org/"""
see (`class String`)
by ("Gavin")
tagged("Basic types", "Strings")
shared final native class Character(Character character)
        extends Object()
        satisfies Comparable<Character> & 
                  Enumerable<Character> {
    
    "A string containing just this character."
    shared actual native String string => String { this };
    
    "The lowercase representation of this character.
     
     Conversion of uppercase characters to lowercase is
     performed according to a locale-independent mapping
     that produces incorrect results in certain locales
     (e.g. `tr-TR`).
     
     Furthermore, this conversion always produces a single
     character, which is incorrect for characters whose
     uppercase representation comprises multiple characters,
     for example \{LATIN CAPITAL LETTER I WITH DOT ABOVE}. 
     Thus,
     
     - `'\{LATIN CAPITAL LETTER I WITH DOT ABOVE}'.uppercased`
       evaluates to `'i'`, whereas
     - `\"\{LATIN CAPITAL LETTER I WITH DOT ABOVE}\".uppercased`
       evaluates, more correctly, to the string 
       `\"i\{COMBINING DOT ABOVE}\"`.
     
     Therefore, for most purposes, it is better to use 
     `char.string.lowercased` instead of `char.lowercased`."
    see (`value String.lowercased`)
    shared native Character lowercased;
    
    "The uppercase representation of this character, in the
     [[system]] default locale.
     
     Conversion of lowercase characters to uppercase is
     performed according to a locale-independent mapping
     that produces incorrect results in certain locales
     (e.g. `tr-TR`).
     
     Furthermore, this conversion always produces a single
     character, which is incorrect for characters whose
     uppercase representation comprises multiple characters,
     for example \{LATIN SMALL LETTER SHARP S}. Thus,
     
     - `'\{LATIN SMALL LETTER SHARP S}'.uppercased`
       evaluates to `'\{LATIN SMALL LETTER SHARP S}'`, 
       whereas
     - `\"\{LATIN SMALL LETTER SHARP S}\".uppercased`
       evaluates, more correctly, to the string `\"SS\"`.
     
     Therefore, for most purposes, it is better to use 
     `char.string.uppercased` instead of `char.uppercased`."
    see (`value String.uppercased`)
    shared native Character uppercased;
    
    "The title case representation of this character."
    shared native Character titlecased;
    
    "Determine if this is a lowercase representation of the
     character. That is, if its Unicode general category is 
     *Ll*."
    shared native Boolean lowercase;
    
    "Determine if this is an uppercase representation of the
     character. That is, if its Unicode general category is 
     *Lu*."
    shared native Boolean uppercase;
    
    "Determine if this is a title case representation of the
     character. That is, if its Unicode general category is 
     *Lt*."
    shared native Boolean titlecase;

    "Determine if this character is a numeric digit. That 
     is, if its Unicode general category is *Nd*."
    shared native Boolean digit;

    "Determine if this character is a letter. That is, if 
     its Unicode general category is *Lu*, *Ll*, *Lt*, *Lm*,
     or *Lo*."
    shared native Boolean letter;

    "Determine if this character is a whitespace character. 
     The following characters are whitespace characters:
     
     - *LINE FEED*, `\\n` or `\\{#000A}`,
     - *FORM FEED*, `\\f` or `\\{#000C}`,
     - *CARRIAGE RETURN*, `\\r` or `\\{#000D}`,
     - *HORIZONTAL TABULATION*, `\\t` or `\\{#0009}`,
     - *LINE TABULATION*, `\\{#000B}`,
     - *FILE SEPARATOR*, `\\{#001C}`,
     - *GROUP SEPARATOR*, `\\{#001D}`,
     - *RECORD SEPARATOR*, `\\{#001E}`,
     - *UNIT SEPARATOR*, `\\{#001F}`, and
     - any Unicode character in the general category *Zs*, 
       *Zl*, or *Zp* that is not a non-breaking space."
    shared native Boolean whitespace;
    
    "Determine if this character is an ISO control character."
    shared native Boolean control;
    
    /*"The general category of the character"
    shared native CharacterCategory category;*/
    
    /*"The directionality of the character."
    shared native CharacterDirectionality directionality;*/
    
    "The Unicode code point of the character, an [[Integer]]
     in the range `0..#10FFFF`."
    aliased("codePoint")
    shared native Integer integer;
    
    "Compare this character with the given character, 
     according to the Unicode code points of the characters."
    shared actual native Comparison compare(Character other)
            => this.integer <=> other.integer;
    
    "Determines if the given object is a character with the
     same code point as this character."
    shared actual native Boolean equals(Object that)
            => if (is Character that)
                then that.integer == this.integer
                else false;
    
    "The hash code for this `Character`, which is always its 
     32-bit [[Unicode code point|integer]]."
    shared actual native Integer hash => integer;
    
    "The character with the Unicode code point that is the
     predecessor of the unicode code point this character."
    shared actual native Character predecessor
            => (integer-1).character;

    "The character with the Unicode code point that is the
     successor of the unicode code point this character."
    shared actual native Character successor
            => (integer+1).character;
    
    shared actual native Character neighbour(Integer offset)
            => (integer + offset).character;
    
    "The difference between the Unicode code point of this
     character, and the Unicode code point of the given
     character."
    shared actual native Integer offset(Character other)
            => integer - other.integer;
    
    shared actual native Integer offsetSign(Character other)
            => super.offsetSign(other);
    
    "Determine if this character's code point is larger than
     the given character's code point, returning `false` if
     the two characters represent the same code point."
    shared actual native Boolean largerThan(Character other)
            => this.integer > other.integer;
     
    "Determine if this character's code point is smaller 
     than the given character's code point, returning `false` 
     if the two characters represent the same code point."
    shared actual native Boolean smallerThan(Character other)
            => this.integer < other.integer; 

     "Determine if this character's code point is larger 
      than or equal to the given character's code point, 
      returning `true` if the two characters represent the 
      same code point."
    shared actual native Boolean notSmallerThan(Character other)
            => this.integer >= other.integer; 

     "Determine if this character's code point is smaller 
      than or equal to the given character's code point, 
      returning `true` if the two characters represent the 
      same code point."
    shared actual native Boolean notLargerThan(Character other)
            => this.integer <= other.integer; 
}

native Character characterFromInteger(Integer integer);

native("dart")
Set<Integer> wsChars
    =   set {
            #9, #a, #b, #c, #d, #20, #85,
            #1680, #180e, #2028, #2029, #205f, #3000,
            #1c, #1d, #1e, #1f,
            #2000, #2001, #2002, #2003, #2004, #2005, #2006,
            #2008, #2009, #200a
        };

native("dart")
Set<Integer> digitZeroChars
    =   set {
            #30, #660, #6f0, #7c0, #966, #9e6, #a66,
            #ae6, #b66, #be6, #c66, #ce6, #d66, #e50,
            #ed0, #f20, #1040, #1090, #17e0, #1810, #1946,
            #19d0, #1a80, #1a90, #1b50, #1bb0, #1c40, #1c50,
            #a620, #a8d0, #a900, #a9d0, #aa50, #abf0, #ff10,
            #104a0, #11066, #110f0, #11136, #111d0, #116c0
        };

abstract native("dart")
class BaseCharacter(shared Integer integer) extends Object()
        satisfies Comparable<BaseCharacter> /*& Enumerable<Char>*/ {

    if (integer > #10FFFF || integer < 0) {
        throw OverflowException("``integer`` is not a possible Unicode code point");
    }

    shared actual String string => DStringClass.fromCharCode(integer).string;

    shared Character lowercased
        =>  characterFromInteger(
                dartString(string.lowercased).runes.elementAt(0).toInt());

    shared Character uppercased
        =>  characterFromInteger(
                dartString(string.uppercased).runes.elementAt(0).toInt());

    shared Character titlecased => uppercased;

    shared Boolean lowercase => uppercased != this;

    shared Boolean uppercase => lowercased != this;

    shared Boolean titlecase => uppercase;

    shared Boolean digit {
        // logic from javascript backend
        value check = integer.and(#fffffff0);
        if (digitZeroChars.contains(check)) {
            return integer.and(#f) <= 9;
        }
        else if (digitZeroChars.contains(check.or(6))) {
            return integer.and(#f) >= 6;
        }
        else {
            return integer >= #1d7ce && integer <= #1d7ff;
        }
    }

    shared Boolean letter => lowercase || uppercase;

    shared Boolean whitespace => wsChars.contains(integer);

    shared Boolean control => nothing;

    shared actual Comparison compare(BaseCharacter other) => integer <=> other.integer;

    shared actual Boolean equals(Object that)
        =>  if (is Character that)
            then integer == that.integer
            else false;

    shared actual Integer hash => integer;

    shared /*actual*/ Character predecessor => characterFromInteger(integer - 1);

    shared /*actual*/ Character successor => characterFromInteger(integer + 1);

    shared /*actual*/ Character neighbour(Integer offset)
        =>  characterFromInteger(integer + offset);

    shared /*actual*/ Integer offset(Character other) => integer - other.integer;

    shared /*actual*/ Integer offsetSign(Character other) => offset(other).sign;

    shared actual Boolean largerThan(BaseCharacter other) => integer > other.integer;

    shared actual Boolean smallerThan(BaseCharacter other) => integer < other.integer;

    shared actual Boolean notSmallerThan(BaseCharacter other) => integer >= other.integer;

    shared actual Boolean notLargerThan(BaseCharacter other) => integer <= other.integer;
}
