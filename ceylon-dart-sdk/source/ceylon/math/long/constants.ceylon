shared Long zero = longNumber(0);
shared Long one = longNumber(1);
shared Long two = longNumber(2);
shared Long ten = longNumber(10);

"The maximum [[Long]] value, equal to (2<sup>63</sup> - 1)."
shared
Long maxLongValue
    =   longNumberOfWords(#7fff, #ffff, #ffff, #ffff);

"The minimum [[Long]] value, equal to -(2<sup>63</sup>)."
shared
Long minLongValue
    =   longNumberOfWords(#8000, 0, 0, 0);
