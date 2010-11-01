#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
#import "SmartKanaConverter.h"

int main()
{
}

@interface TestSmartKanaConverter: SenTestCase
{
}
@end

@implementation TestSmartKanaConverter

- (void)testNone
{
    STAssertEqualObjects([SmartKanaConverter convert:@" " withFlag:0], @" ", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"　" withFlag:0], @"　", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"0" withFlag:0], @"0", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"０" withFlag:0], @"０", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"A" withFlag:0], @"A", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"a" withFlag:0], @"a", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"Ａ" withFlag:0], @"Ａ", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ａ" withFlag:0], @"ａ", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"あ" withFlag:0], @"あ", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ア" withFlag:0], @"ア", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ー" withFlag:0], @"ー", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ｱ" withFlag:0], @"ｱ", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"･" withFlag:0], @"･", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"#" withFlag:0], @"#", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"＃" withFlag:0], @"＃", nil);

    STAssertEqualObjects([SmartKanaConverter convert:@"¥" withFlag:0], @"¥", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"￥" withFlag:0], @"￥", nil);
}

- (void)test_SKCONV_2H_SPC
{
    STAssertEqualObjects([SmartKanaConverter convert:@"　" withFlag:SKCONV_2H_SPC], @" ", nil);
}

- (void)test_SKCONV_2F_SPC
{
    STAssertEqualObjects([SmartKanaConverter convert:@" " withFlag:SKCONV_2F_SPC], @"　",  nil);
}

- (void)test_SKCONV_2H_NUM
{
    STAssertEqualObjects([SmartKanaConverter convert:@"０" withFlag:SKCONV_2H_NUM], @"0", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"１" withFlag:SKCONV_2H_NUM], @"1", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"２" withFlag:SKCONV_2H_NUM], @"2", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"３" withFlag:SKCONV_2H_NUM], @"3", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"４" withFlag:SKCONV_2H_NUM], @"4", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"５" withFlag:SKCONV_2H_NUM], @"5", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"６" withFlag:SKCONV_2H_NUM], @"6", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"７" withFlag:SKCONV_2H_NUM], @"7", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"８" withFlag:SKCONV_2H_NUM], @"8", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"９" withFlag:SKCONV_2H_NUM], @"9", nil);
}

- (void)test_SKCONV_2F_NUM
{
    STAssertEqualObjects([SmartKanaConverter convert:@"0" withFlag:SKCONV_2F_NUM], @"０", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"1" withFlag:SKCONV_2F_NUM], @"１", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"2" withFlag:SKCONV_2F_NUM], @"２", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"3" withFlag:SKCONV_2F_NUM], @"３", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"4" withFlag:SKCONV_2F_NUM], @"４", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"5" withFlag:SKCONV_2F_NUM], @"５", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"6" withFlag:SKCONV_2F_NUM], @"６", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"7" withFlag:SKCONV_2F_NUM], @"７", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"8" withFlag:SKCONV_2F_NUM], @"８", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"9" withFlag:SKCONV_2F_NUM], @"９", nil);
}

- (void)test_SKCONV_2H_AL
{
    STAssertEqualObjects([SmartKanaConverter convert:@"＠" withFlag:SKCONV_2H_AL], @"＠", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"Ａ" withFlag:SKCONV_2H_AL], @"A",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"Ｚ" withFlag:SKCONV_2H_AL], @"Z",  nil);
}

- (void)test_SKCONV_2F_AL
{
    STAssertEqualObjects([SmartKanaConverter convert:@"@" withFlag:SKCONV_2F_AL], @"@",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"A" withFlag:SKCONV_2F_AL], @"Ａ", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"Z" withFlag:SKCONV_2F_AL], @"Ｚ", nil);
}

- (void)test_SKCONV_2H_ALNUM
{
    STAssertEqualObjects([SmartKanaConverter convert:@"０Ａｚ" withFlag:SKCONV_2H_ALNUM], @"0Az",  nil);
}

- (void)test_SKCONV_2F_ALNUM
{
    STAssertEqualObjects([SmartKanaConverter convert:@"0Az" withFlag:SKCONV_2F_ALNUM], @"０Ａｚ",  nil);
}

- (void)test_SKCONV_2H_SYM
{
    STAssertEqualObjects([SmartKanaConverter convert:@"！＼／" withFlag:SKCONV_2H_SYM], @"!\\/",  nil);
}

- (void)test_SKCONV_2F_SYM
{
    STAssertEqualObjects([SmartKanaConverter convert:@"!\\/" withFlag:SKCONV_2F_SYM], @"！＼／",  nil);
}

- (void)test_SKCONV_2H_ASCII
{
    STAssertEqualObjects([SmartKanaConverter convert:@"　＃０Ａａ？" withFlag:SKCONV_2H_ASCII], @" #0Aa?",  nil);
}

- (void)test_SKCONV_2F_ASCII
{
    STAssertEqualObjects([SmartKanaConverter convert:@" #0Aa?" withFlag:SKCONV_2F_ASCII], @"　＃０Ａａ？",  nil);
}

- (void)test_SKCONV_2H_HKANA
{
    STAssertEqualObjects([SmartKanaConverter convert:@"ぁ" withFlag:SKCONV_2H_HKANA], @"ｧ",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"が" withFlag:SKCONV_2H_HKANA], @"ｶﾞ",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ぱ" withFlag:SKCONV_2H_HKANA], @"ﾊﾟ",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ん" withFlag:SKCONV_2H_HKANA], @"ﾝ",  nil);
}

- (void)test_SKCONV_2H_KKANA
{
    STAssertEqualObjects([SmartKanaConverter convert:@"ァ" withFlag:SKCONV_2H_KKANA], @"ｧ",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ガ" withFlag:SKCONV_2H_KKANA], @"ｶﾞ",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"パ" withFlag:SKCONV_2H_KKANA], @"ﾊﾟ",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ン" withFlag:SKCONV_2H_KKANA], @"ﾝ",  nil);
}

- (void)test_SKCONV_2F_HKANA
{
    STAssertEqualObjects([SmartKanaConverter convert:@"ァ" withFlag:SKCONV_2F_HKANA], @"ァ",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ぁ" withFlag:SKCONV_2F_HKANA], @"ぁ",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ｧ"  withFlag:SKCONV_2F_HKANA], @"ぁ",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ｶﾞ" withFlag:SKCONV_2F_HKANA], @"か゛",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ﾊﾟ" withFlag:SKCONV_2F_HKANA], @"は゜",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ｶﾞ" withFlag:SKCONV_2F_HKANA_C], @"が",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ﾊﾟ" withFlag:SKCONV_2F_HKANA_C], @"ぱ",  nil);
}

- (void)test_SKCONV_2F_KKANA
{
    STAssertEqualObjects([SmartKanaConverter convert:@"ァ" withFlag:SKCONV_2F_KKANA], @"ァ",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ぁ" withFlag:SKCONV_2F_KKANA], @"ぁ",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ｧ"  withFlag:SKCONV_2F_KKANA], @"ァ",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ｶﾞ" withFlag:SKCONV_2F_KKANA], @"カ゛",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ﾊﾟ" withFlag:SKCONV_2F_KKANA], @"ハ゜",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ｶﾞ" withFlag:SKCONV_2F_KKANA_C], @"ガ",  nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ﾊﾟ" withFlag:SKCONV_2F_KKANA_C], @"パ",  nil);
}

- (void)test_SKCONV_F2F_HKANA
{
    STAssertEqualObjects([SmartKanaConverter convert:@"ァ" withFlag:SKCONV_F2F_HKANA], @"ぁ", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ヴ" withFlag:SKCONV_F2F_HKANA], @"ゔ", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ー" withFlag:SKCONV_F2F_HKANA], @"ー", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ガ" withFlag:SKCONV_F2F_HKANA], @"が", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"パ" withFlag:SKCONV_F2F_HKANA], @"ぱ", nil);
}

- (void)test_SKCONV_F2F_KKANA
{
    STAssertEqualObjects([SmartKanaConverter convert:@"ぁ" withFlag:SKCONV_F2F_KKANA], @"ァ", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ゔ" withFlag:SKCONV_F2F_KKANA], @"ヴ", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ー" withFlag:SKCONV_F2F_KKANA], @"ー", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"が" withFlag:SKCONV_F2F_KKANA], @"ガ", nil);
    STAssertEqualObjects([SmartKanaConverter convert:@"ぱ" withFlag:SKCONV_F2F_KKANA], @"パ", nil);
}

- (void)test_SKCONV_VARIATION
{
    NSString *s;
    s = @"か゛";
    s = [SmartKanaConverter convert:s withFlag:SKCONV_2H_HKANA];
    s = [SmartKanaConverter convert:s withFlag:SKCONV_2F_KKANA_C];
    STAssertEqualObjects(s, @"ガ", nil);
}

@end
