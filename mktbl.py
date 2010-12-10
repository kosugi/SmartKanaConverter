# -*- coding: utf-8 -*-
# Copyright (c) 2010, KOSUGI Tomo
# This software is licensed under the New BSD License.

# mktbl.py creates conversion tables into:
#   SmartKanaConverter_define.m
#   SmartKanaConverter_init.m

import codecs

def escape(c):
    return c.replace('\\', '\\\\').replace('"', '\\"')

def make_str_in_range(*pairs):
    return ''.join([''.join([unichr(n) for n in range(ord(p[0]), ord(p[1]) + 1)]) for p in pairs])

def ident(n, value):
    return value[n]

class Writer(object):

    def make_set(self, name, values):
        self.fp_defn.write('static NSSet *%s;\n' % name)
        self.fp_init.write('%s = [[NSSet alloc] initWithObjects:\n' % name)
        for value in values:
            self.fp_init.write('\t@"%s",\n' % escape(value))
        self.fp_init.write('\tnil];\n\n')

    def make_map(self, name, lhs, rhs, fn):
        self.fp_defn.write('static NSDictionary *%s;\n' % name)
        self.fp_init.write('%s = [[NSDictionary alloc] initWithObjectsAndKeys:\n' % name)
        for n in range(len(lhs)):
            self.fp_init.write('\t@"%s", @"%s",\n' % (escape(fn(n, rhs)), escape(lhs[n])))
        self.fp_init.write('\tnil];\n\n')

    def do(self):

        msg = '''// -*- objc -*-
// Copyright (c) 2010, KOSUGI Tomo
// This software is licensed under the New BSD License.

// THIS FILE IS AUTO-GENERATED. DO NOT MODIFY.

'''
        self.fp_defn.write(msg)
        self.fp_init.write(msg)

        HW_SPC, FW_SPC = u'\u0020\u3000'
        self.make_map('map_2h_spc', FW_SPC, HW_SPC, ident)
        self.make_map('map_2f_spc', HW_SPC, FW_SPC, ident)

        HW_NUM = make_str_in_range([u'0', u'9'])
        FW_NUM = make_str_in_range([u'０', u'９'])
        self.make_map('map_2h_num', FW_NUM, HW_NUM, ident)
        self.make_map('map_2f_num', HW_NUM, FW_NUM, ident)

        HW_AL = make_str_in_range([u'A', u'Z'], [u'a', u'z'])
        FW_AL = make_str_in_range([u'Ａ', u'Ｚ'], [u'ａ', u'ｚ'])
        self.make_map('map_2h_al', FW_AL, HW_AL, ident)
        self.make_map('map_2f_al', HW_AL, FW_AL, ident)

        HW_SYM = make_str_in_range([u'!',  u'/'],  [u':',  u'@'],  [u'[',  u'`'],  [u'{',  u'}'])  + u'~'
        FW_SYM = make_str_in_range([u'！', u'／'], [u'：', u'＠'], [u'［', u'｀'], [u'｛', u'｝']) + u'〜'
        self.make_map('map_2h_sym', FW_SYM, HW_SYM, ident)
        self.make_map('map_2f_sym', HW_SYM, FW_SYM, ident)

        FW_HKANA_2H = u"ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろわゐゑをんゔ゛゜・ー「」。、"
        FW_KKANA_2H = u"ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロワヰヱヲンヴ゛゜・ー「」。、"
        HW_KKANA_2H = u"ｧ ｱ ｨ ｲ ｩ ｳ ｪ ｴ ｫ ｵ ｶ ｶﾞｷ ｷﾞｸ ｸﾞｹ ｹﾞｺ ｺﾞｻ ｻﾞｼ ｼﾞｽ ｽﾞｾ ｾﾞｿ ｿﾞﾀ ﾀﾞﾁ ﾁﾞｯ ﾂ ﾂﾞﾃ ﾃﾞﾄ ﾄﾞﾅ ﾆ ﾇ ﾈ ﾉ ﾊ ﾊﾞﾊﾟﾋ ﾋﾞﾋﾟﾌ ﾌﾞﾌﾟﾍ ﾍﾞﾍﾟﾎ ﾎﾞﾎﾟﾏ ﾐ ﾑ ﾒ ﾓ ｬ ﾔ ｭ ﾕ ｮ ﾖ ﾗ ﾘ ﾙ ﾚ ﾛ ﾜ ｲ ｴ ｦ ﾝ ｳﾞﾞ ﾟ ･ ｰ ｢ ｣ ｡ ､ "
        self.make_map('map_2h_hkana', FW_HKANA_2H, HW_KKANA_2H, lambda n, value: value[(n * 2):(n * 2) + 2].rstrip())
        self.make_map('map_2h_kkana', FW_KKANA_2H, HW_KKANA_2H, lambda n, value: value[(n * 2):(n * 2) + 2].rstrip())

        HW_KKANA_2F = make_str_in_range([u'｡', u'ﾟ'])
        self.make_set('set_hkkana', HW_KKANA_2F)

        HW_KKANA_PA = u'ﾊﾋﾌﾍﾎ'
        self.make_set('set_pa', HW_KKANA_PA)
        self.make_map('map_2f_hkana_pa', HW_KKANA_PA, u'ぱぴぷぺぽ', ident)
        self.make_map('map_2f_kkana_pa', HW_KKANA_PA, u'パピプペポ', ident)

        HW_KKANA_BA = u'ｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾊﾋﾌﾍﾎｳ'
        self.make_set('set_ba', HW_KKANA_BA)
        self.make_map('map_2f_hkana_ba', HW_KKANA_BA, u'がぎぐげござじずぜぞだぢづでどばびぶべぼゔ', ident)
        self.make_map('map_2f_kkana_ba', HW_KKANA_BA, u'ガギグゲゴザジズゼゾダヂヅデドバビブベボヴ', ident)

        HW_KKANA_2F = u"ｧｱｨｲｩｳｪｴｫｵｶｷｸｹｺｻｼｽｾｿﾀﾁｯﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓｬﾔｭﾕｮﾖﾗﾘﾙﾚﾛﾜｦﾝﾞﾟ･ｰ｢｣｡､"
        FW_HKANA_2F = u"ぁあぃいぅうぇえぉおかきくけこさしすせそたちっつてとなにぬねのはひふへほまみむめもゃやゅゆょよらりるれろわをん゛゜・ー「」。、"
        FW_KKANA_2F = u"ァアィイゥウェエォオカキクケコサシスセソタチッツテトナニヌネノハヒフヘホマミムメモャヤュユョヨラリルレロワヲン゛゜・ー「」。、"
        self.make_map('map_2f_hkana', HW_KKANA_2F, FW_HKANA_2F, ident)
        self.make_map('map_2f_kkana', HW_KKANA_2F, FW_KKANA_2F, ident)

        FW_HKANA = make_str_in_range([u'ぁ', u'ゖ'])
        FW_KKANA = make_str_in_range([u'ァ', u'ヶ'])
        self.make_map('map_f2f_hkana', FW_KKANA, FW_HKANA, ident)
        self.make_map('map_f2f_kkana', FW_HKANA, FW_KKANA, ident)

    def write(self):
        self.fp_defn = codecs.open('src/SmartKanaConverter_define.m', 'w', 'UTF-8')
        self.fp_init = codecs.open('src/SmartKanaConverter_init.m', 'w', 'UTF-8')
        self.do()
        self.fp_defn.close()
        self.fp_init.close()

if __name__ == '__main__':
    Writer().write()
