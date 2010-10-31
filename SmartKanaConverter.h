// -*- objc -*-
// Copyright (c) 2010, KOSUGI Tomo
// This software is licensed under the New BSD License.

@class NSString;

enum {

    // converts spc to halfwidth/fullwidth
    SKCONV_2H_SPC = 1 << 0,
    SKCONV_2F_SPC = 1 << 1,

    // converts numerical digits to halfwidth/fullwidth
    SKCONV_2H_NUM = 1 << 2,
    SKCONV_2F_NUM = 1 << 3,

    // converts alphabets to halfwidth/fullwidth
    SKCONV_2H_AL = 1 << 4,
    SKCONV_2F_AL = 1 << 5,

    // converts numerical digits and alphabets to halfwidth/fullwidth
    SKCONV_2H_ALNUM = SKCONV_2H_NUM | SKCONV_2H_AL,
    SKCONV_2F_ALNUM = SKCONV_2F_NUM | SKCONV_2F_AL,

    // converts alphabets to halfwidth/fullwidth
    SKCONV_2H_SYM = 1 << 6,
    SKCONV_2F_SYM = 1 << 7,

    // converts US-ASCII chars to halfwidth/fullwidth
    SKCONV_2H_ASCII = SKCONV_2H_NUM | SKCONV_2H_AL | SKCONV_2H_SYM | SKCONV_2H_SPC,
    SKCONV_2F_ASCII = SKCONV_2F_NUM | SKCONV_2F_AL | SKCONV_2F_SYM | SKCONV_2F_SPC,

    // converts fullwidth Hiragana/Katakana to halfwidth Katakana
    SKCONV_2H_HKANA = 1 << 8,
    SKCONV_2H_KKANA = 1 << 9,

    // converts halfwidth Katakana to fullwidth Hiragana/Katakana
    SKCONV_2F_HKANA = 1 << 10,
    SKCONV_2F_KKANA = 1 << 11,

    // converts fullwidth Katakana/Hiragana to fullwidth Hiragana/Katakana
    SKCONV_F2F_HKANA = 1 << 12,
    SKCONV_F2F_KKANA = 1 << 13,
};

@interface SmartKanaConverter: NSObject
{
}

+ (NSString *)convert:(NSString *)value withFlag:(int)flag;

@end
