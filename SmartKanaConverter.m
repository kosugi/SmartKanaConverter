// -*- objc -*-
// Copyright (c) 2010, KOSUGI Tomo
// This software is licensed under the New BSD License.

#import <Foundation/Foundation.h>
#import "SmartKanaConverter.h"

#define HW_DAKUTEN    (0xFF9EU)
#define HW_HANDAKUTEN (0xFF9FU)

#import "SmartKanaConverter_define.m"

static NSDictionary **maps_2f_kana[][3] = {
    { &map_2f_hkana_pa, &map_2f_hkana_ba, &map_2f_hkana },
    { &map_2f_kkana_pa, &map_2f_kkana_ba, &map_2f_kkana },
};

@implementation SmartKanaConverter

+ (NSString *)convert:(NSString *)src withFlag:(int)flag
{
    NSUInteger len = [src length];
    NSMutableString *dst = [NSMutableString stringWithCapacity:(len * 2)];
    for (NSUInteger n = 0; n < len; ++n) {

        NSString *cur = [src substringWithRange:NSMakeRange(n, 1)];
        NSString *rep;

        if ([set_hkkana member:cur]) {
            BOOL hasNext = n + 1 < len;
            unichar next = (hasNext && flag & SKCONV_COMPOSE)? [src characterAtIndex:(n + 1)]: 0;
            NSDictionary ***map_2f_kana = nil;
            if (flag & SKCONV_2F_HKANA) {
                map_2f_kana = maps_2f_kana[0];
            }
            else if (flag & SKCONV_2F_KKANA) {
                map_2f_kana = maps_2f_kana[1];
            }
            if (map_2f_kana && (
                    ((rep = [*map_2f_kana[0] objectForKey:cur]) && hasNext && next == HW_HANDAKUTEN && ++n) ||
                    ((rep = [*map_2f_kana[1] objectForKey:cur]) && hasNext && next == HW_DAKUTEN    && ++n) ||
                    ((rep = [*map_2f_kana[2] objectForKey:cur]))))
            {
                [dst appendString:rep];
                continue;
            }
        }
        else if (
            (flag & SKCONV_2H_SPC    && (rep = [map_2h_spc    objectForKey:cur])) ||
            (flag & SKCONV_2F_SPC    && (rep = [map_2f_spc    objectForKey:cur])) ||
            (flag & SKCONV_2H_NUM    && (rep = [map_2h_num    objectForKey:cur])) ||
            (flag & SKCONV_2F_NUM    && (rep = [map_2f_num    objectForKey:cur])) ||
            (flag & SKCONV_2H_AL     && (rep = [map_2h_al     objectForKey:cur])) ||
            (flag & SKCONV_2F_AL     && (rep = [map_2f_al     objectForKey:cur])) ||
            (flag & SKCONV_2H_SYM    && (rep = [map_2h_sym    objectForKey:cur])) ||
            (flag & SKCONV_2F_SYM    && (rep = [map_2f_sym    objectForKey:cur])) ||
            (flag & SKCONV_2H_HKANA  && (rep = [map_2h_hkana  objectForKey:cur])) ||
            (flag & SKCONV_2H_KKANA  && (rep = [map_2h_kkana  objectForKey:cur])) ||
            (flag & SKCONV_F2F_HKANA && (rep = [map_f2f_hkana objectForKey:cur])) ||
            (flag & SKCONV_F2F_KKANA && (rep = [map_f2f_kkana objectForKey:cur])))
        {
            [dst appendString:rep];
            continue;
        }
        [dst appendString:cur];
    }
    return [NSString stringWithString:dst];
}

+ (void)initialize
{
    static BOOL initialized = NO;
    if (!initialized) {
#import "SmartKanaConverter_init.m"
        initialized = YES;
    }
}

@end
