//
//  TestNSLocaleVC.m
//  Life
//
//  Created by Devin on 3/24/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestNSLocaleVC.h"
#import <sys/sysctl.h>

@interface TestNSLocaleVC ()

@end

@implementation TestNSLocaleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self printNSLocale];
    NSMutableArray *iOSLanguageArray =[[NSMutableArray alloc] initWithArray:@[@"aa",@"ab",@"ace",@"ach",@"ada",@"ady",@"ae",@"af",@"afa",@"afh",@"agq",@"ain",@"ak",@"akk",@"ale",@"alg",@"alt",@"am",@"an",@"ang",@"anp",@"apa",@"ar",@"arc",@"arn",@"arp",@"art",@"arw",@"as",@"asa",@"ast",@"ath",@"aus",@"av",@"awa",@"ay",@"az",@"ba",@"bad",@"bai",@"bal",@"ban",@"bas",@"bat",@"bax",@"bbj",@"be",@"bej",@"bem",@"ber",@"bez",@"bfd",@"bg",@"bh",@"bho",@"bi",@"bik",@"bin",@"bkm",@"bla",@"bm",@"bn",@"bnt",@"bo",@"br",@"bra",@"brx",@"bs",@"bss",@"btk",@"bua",@"bug",@"bum",@"byn",@"byv",@"ca",@"cad",@"cai",@"car",@"cau",@"cay",@"cch",@"ce",@"ceb",@"cel",@"cgg",@"ch",@"chb",@"chg",@"chk",@"chm",@"chn",@"cho",@"chp",@"chr",@"chy",@"ckb",@"cmc",@"co",@"cop",@"cpe",@"cpf",@"cpp",@"cr",@"crh",@"crp",@"cs",@"csb",@"cu",@"cus",@"cv",@"cy",@"da",@"dak",@"dar",@"dav",@"day",@"de",@"del",@"den",@"dgr",@"din",@"dje",@"doi",@"dra",@"dsb",@"dua",@"dum",@"dv",@"dyo",@"dyu",@"dz",@"dzg",@"ebu",@"ee",@"efi",@"egy",@"eka",@"el",@"elx",@"en",@"enm",@"eo",@"es",@"et",@"eu",@"ewo",@"fa",@"fan",@"fat",@"ff",@"fi",@"fil",@"fiu",@"fj",@"fo",@"fon",@"fr",@"frm",@"fro",@"frr",@"frs",@"fur",@"fy",@"ga",@"gaa",@"gay",@"gba",@"gd",@"gem",@"gez",@"gil",@"gl",@"gmh",@"gn",@"goh",@"gon",@"gor",@"got",@"grb",@"grc",@"gsw",@"gu",@"guz",@"gv",@"gwi",@"ha",@"hai",@"haw",@"he",@"hi",@"hil",@"him",@"hit",@"hmn",@"ho",@"hr",@"hsb",@"ht",@"hu",@"hup",@"hy",@"hz",@"ia",@"iba",@"ibb",@"id",@"ie",@"ig",@"ii",@"ijo",@"ik",@"ilo",@"inc",@"ine",@"inh",@"io",@"ira",@"iro",@"is",@"it",@"iu",@"ja",@"jbo",@"jgo",@"jmc",@"jpr",@"jrb",@"jv",@"ka",@"kaa",@"kab",@"kac",@"kaj",@"kam",@"kar",@"kaw",@"kbd",@"kbl",@"kcg",@"kde",@"kea",@"kfo",@"kg",@"kha",@"khi",@"kho",@"khq",@"ki",@"kj",@"kk",@"kkj",@"kl",@"kln",@"km",@"kmb",@"kn",@"ko",@"kok",@"kos",@"kpe",@"kr",@"krc",@"krl",@"kro",@"kru",@"ks",@"ksb",@"ksf",@"ksh",@"ku",@"kum",@"kut",@"kv",@"kw",@"ky",@"la",@"lad",@"lag",@"lah",@"lam",@"lb",@"lez",@"lg",@"li",@"lkt",@"ln",@"lo",@"lol",@"loz",@"lt",@"lu",@"lua",@"lui",@"lun",@"luo",@"lus",@"luy",@"lv",@"mad",@"maf",@"mag",@"mai",@"mak",@"man",@"map",@"mas",@"mde",@"mdf",@"mdr",@"men",@"mer",@"mfe",@"mg",@"mga",@"mgh",@"mgo",@"mh",@"mi",@"mic",@"min",@"mis",@"mk",@"mkh",@"ml",@"mn",@"mnc",@"mni",@"mno",@"mo",@"moh",@"mos",@"mr",@"ms",@"mt",@"mua",@"mul",@"mun",@"mus",@"mwl",@"mwr",@"my",@"mye",@"myn",@"myv",@"na",@"nah",@"nai",@"nap",@"naq",@"nb",@"nd",@"nds",@"ne",@"new",@"ng",@"nia",@"nic",@"niu",@"nl",@"nmg",@"nn",@"nnh",@"no",@"nog",@"non",@"nqo",@"nr",@"nso",@"nub",@"nus",@"nv",@"nwc",@"ny",@"nym",@"nyn",@"nyo",@"nzi",@"oc",@"oj",@"om",@"or",@"os",@"osa",@"ota",@"oto",@"pa",@"paa",@"pag",@"pal",@"pam",@"pap",@"pau",@"peo",@"phi",@"phn",@"pi",@"pl",@"pon",@"pra",@"pro",@"ps",@"pt",@"qu",@"raj",@"rap",@"rar",@"rm",@"rn",@"ro",@"roa",@"rof",@"rom",@"ru",@"rup",@"rw",@"rwk",@"sa",@"sad",@"sah",@"sai",@"sal",@"sam",@"saq",@"sas",@"sat",@"sba",@"sbp",@"sc",@"scn",@"sco",@"sd",@"se",@"see",@"seh",@"sel",@"sem",@"ses",@"sg",@"sga",@"sgn",@"shi",@"shn",@"shu",@"si",@"sid",@"sio",@"sit",@"sk",@"sl",@"sla",@"sm",@"sma",@"smi",@"smj",@"smn",@"sms",@"sn",@"snk",@"so",@"sog",@"son",@"sq",@"sr",@"srn",@"srr",@"ss",@"ssa",@"ssy",@"st",@"su",@"suk",@"sus",@"sux",@"sv",@"sw",@"swb",@"swc",@"syc",@"syr",@"ta",@"tai",@"te",@"tem",@"teo",@"ter",@"tet",@"tg",@"th",@"ti",@"tig",@"tiv",@"tk",@"tkl",@"tl",@"tlh",@"tli",@"tmh",@"tn",@"to",@"tog",@"tpi",@"tr",@"trv",@"ts",@"tsi",@"tt",@"tum",@"tup",@"tut",@"tvl",@"tw",@"twq",@"ty",@"tyv",@"tzm",@"udm",@"ug",@"uga",@"uk",@"umb",@"und",@"ur",@"uz",@"vai",@"ve",@"vi",@"vo",@"vot",@"vun",@"wa",@"wae",@"wak",@"wal",@"war",@"was",@"wen",@"wo",@"xal",@"xh",@"xog",@"yao",@"yap",@"yav",@"ybb",@"yi",@"yo",@"ypk",@"yue",@"za",@"zap",@"zbl",@"zen",@"zgh",@"zh",@"znd",@"zu",@"zun",@"zxx",@"zza"]];
    NSMutableArray *androidLanguageArray =[[NSMutableArray alloc] initWithArray:@[@"af", @"agq", @"ak", @"am", @"ar", @"as", @"asa", @"az", @"bas", @"be", @"bem", @"bez", @"bg", @"bm", @"bn", @"bo", @"br", @"brx", @"bs", @"ca", @"cgg", @"chr", @"cs", @"cy", @"da", @"dav", @"de", @"dje", @"dua", @"dyo", @"dz", @"ebu", @"ee", @"el", @"en", @"eo", @"es", @"et", @"eu", @"ewo", @"fa", @"ff", @"fi", @"fil", @"fo", @"fr", @"ga", @"gl", @"gsw", @"gu", @"guz", @"gv", @"ha", @"haw", @"hi", @"hr", @"hu", @"hy", @"ig", @"ii", @"in", @"is", @"it", @"iw", @"ja", @"jgo", @"jmc", @"ka", @"kab", @"kam", @"kde", @"kea", @"khq", @"ki", @"kk", @"kl", @"kln", @"km", @"kn", @"ko", @"kok", @"ks", @"ksb", @"ksf", @"kw", @"lag", @"lg", @"ln", @"lo", @"lt", @"lu", @"luo", @"luy", @"lv", @"mas", @"mer", @"mfe", @"mg", @"mgh", @"mgo", @"mk", @"ml", @"mn", @"mr", @"ms", @"mt", @"mua", @"my", @"naq", @"nb", @"nd", @"ne", @"nl", @"nmg", @"nn", @"nus", @"nyn", @"om", @"or", @"pa", @"pl", @"ps", @"pt", @"rm", @"rn", @"ro", @"rof", @"ru", @"rw", @"rwk", @"saq", @"sbp", @"seh", @"ses", @"sg", @"shi", @"si", @"sk", @"sl", @"sn", @"so", @"sq", @"sr", @"sv", @"sw", @"swc", @"ta", @"te", @"teo", @"th", @"ti", @"to", @"tr", @"twq", @"tzm", @"uk", @"ur", @"uz", @"vai", @"vi", @"vun", @"xog", @"yav", @"yo", @"zh", @"zu"]];
    NSMutableArray *lan6931Array = [[NSMutableArray alloc] initWithArray:@[@"ab",
                                                                           @"aa",
                                                                           @"af",
                                                                           @"ak",
                                                                           @"sq",
                                                                           @"am",
                                                                           @"ar",
                                                                           @"an",
                                                                           @"hy",
                                                                           @"as",
                                                                           @"av",
                                                                           @"ae",
                                                                           @"ay",
                                                                           @"az",
                                                                           @"bm",
                                                                           @"ba",
                                                                           @"eu",
                                                                           @"be",
                                                                           @"bn",
                                                                           @"bh",
                                                                           @"bi",
                                                                           @"bs",
                                                                           @"br",
                                                                           @"bg",
                                                                           @"my",
                                                                           @"ca",
                                                                           @"ch",
                                                                           @"ce",
                                                                           @"ny",
                                                                           @"zh",
                                                                           @"cv",
                                                                           @"kw",
                                                                           @"co",
                                                                           @"cr",
                                                                           @"hr",
                                                                           @"cs",
                                                                           @"da",
                                                                           @"dv",
                                                                           @"nl",
                                                                           @"dz",
                                                                           @"en",
                                                                           @"eo",
                                                                           @"et",
                                                                           @"ee",
                                                                           @"fo",
                                                                           @"fj",
                                                                           @"fi",
                                                                           @"fr",
                                                                           @"ff",
                                                                           @"gl",
                                                                           @"ka",
                                                                           @"de",
                                                                           @"el",
                                                                           @"gn",
                                                                           @"gu",
                                                                           @"ht",
                                                                           @"ha",
                                                                           @"he",
                                                                           @"hz",
                                                                           @"hi",
                                                                           @"ho",
                                                                           @"hu",
                                                                           @"ia",
                                                                           @"id",
                                                                           @"ie",
                                                                           @"ga",
                                                                           @"ig",
                                                                           @"ik",
                                                                           @"io",
                                                                           @"is",
                                                                           @"it",
                                                                           @"iu",
                                                                           @"ja",
                                                                           @"jv",
                                                                           @"kl",
                                                                           @"kn",
                                                                           @"kr",
                                                                           @"ks",
                                                                           @"kk",
                                                                           @"km",
                                                                           @"ki",
                                                                           @"rw",
                                                                           @"ky",
                                                                           @"kv",
                                                                           @"kg",
                                                                           @"ko",
                                                                           @"kj",
                                                                           @"la",
                                                                           @"lb",
                                                                           @"lg",
                                                                           @"li",
                                                                           @"ln",
                                                                           @"lo",
                                                                           @"lt",
                                                                           @"lv",
                                                                           @"gv",
                                                                           @"mk",
                                                                           @"mg",
                                                                           @"ms",
                                                                           @"ml",
                                                                           @"mt",
                                                                           @"mi",
                                                                           @"mr",
                                                                           @"mh",
                                                                           @"mn",
                                                                           @"na",
                                                                           @"nv",
                                                                           @"nd",
                                                                           @"ne",
                                                                           @"ng",
                                                                           @"nb",
                                                                           @"nn",
                                                                           @"no",
                                                                           @"ii",
                                                                           @"nr",
                                                                           @"oc",
                                                                           @"oj",
                                                                           @"cu",
                                                                           @"om",
                                                                           @"or",
                                                                           @"os",
                                                                           @"pa",
                                                                           @"pi",
                                                                           @"fa",
                                                                           @"pl",
                                                                           @"ps",
                                                                           @"pt",
                                                                           @"qu",
                                                                           @"rm",
                                                                           @"rn",
                                                                           @"ro",
                                                                           @"ru",
                                                                           @"sa",
                                                                           @"sc",
                                                                           @"sd",
                                                                           @"se",
                                                                           @"sm",
                                                                           @"sg",
                                                                           @"sr",
                                                                           @"gd",
                                                                           @"sn",
                                                                           @"si",
                                                                           @"sk",
                                                                           @"sl",
                                                                           @"so",
                                                                           @"st",
                                                                           @"es",
                                                                           @"su",
                                                                           @"sw",
                                                                           @"ss",
                                                                           @"sv",
                                                                           @"ta",
                                                                           @"te",
                                                                           @"tg",
                                                                           @"th",
                                                                           @"ti",
                                                                           @"bo",
                                                                           @"tk",
                                                                           @"tl",
                                                                           @"tn",
                                                                           @"to",
                                                                           @"tr",
                                                                           @"ts",
                                                                           @"tt",
                                                                           @"tw",
                                                                           @"ty",
                                                                           @"ug",
                                                                           @"uk",
                                                                           @"ur",
                                                                           @"uz",
                                                                           @"ve",
                                                                           @"vi",
                                                                           @"vo",
                                                                           @"wa",
                                                                           @"cy",
                                                                           @"wo",
                                                                           @"fy",
                                                                           @"xh",
                                                                           @"yi",
                                                                           @"yo",
                                                                           @"za",
                                                                           @"zu"]];
    
    NSArray *allArray = [[NSArray arrayWithArray:iOSLanguageArray] arrayByAddingObjectsFromArray:androidLanguageArray];
    NSMutableArray *allBothArray = [[NSMutableArray alloc] init];
    NSMutableArray *iOSHaveArray = [[NSMutableArray alloc] init];
    NSMutableArray *androidHaveArray = [[NSMutableArray alloc] init];
    
    for (NSString *tempLanguage in allArray) {
        BOOL iOSOriginalHave = [iOSLanguageArray containsObject:tempLanguage];
        BOOL androidOriginalHave = [androidLanguageArray containsObject:tempLanguage];
        BOOL allBothHave = [allBothArray containsObject:tempLanguage];
        BOOL iOSHave = [iOSHaveArray containsObject:tempLanguage];
        BOOL androidHave = [androidHaveArray containsObject:tempLanguage];
        if (iOSOriginalHave && androidOriginalHave && !allBothHave) {
            [allBothArray addObject:tempLanguage];
        }else
        {
            if (iOSOriginalHave && !androidOriginalHave && !iOSHave) {
                [iOSHaveArray addObject:tempLanguage];
            }else if (!iOSOriginalHave && androidOriginalHave && !androidHave)
            {
                [androidHaveArray addObject:tempLanguage];
            }else
            {
                [LogUtil Debug:@"other" message:tempLanguage];
            }
        }
    }
    
    NSMutableArray *androidIn6931 = [[NSMutableArray alloc] init];
    for (NSString *tempLang in androidLanguageArray) {
        if ([lan6931Array containsObject:tempLang]) {
            [androidIn6931 addObject:tempLang];
        }
    }
    
    NSMutableArray *iosIn6931 = [[NSMutableArray alloc] init];
    for (NSString *tempLang in iOSLanguageArray) {
        if ([lan6931Array containsObject:tempLang]) {
            [iosIn6931 addObject:tempLang];
        }
    }
    
    [LogUtil Debug:@"androidIn6931" message:androidIn6931];
    [LogUtil Debug:@"iosIn6931" message:iosIn6931];
    
    
    [LogUtil Debug:@"allBothArray" message:allBothArray];
    [LogUtil Debug:@"iOSHaveArray" message:iOSHaveArray];
    [LogUtil Debug:@"androidHaveArray" message:androidHaveArray];
    [LogUtil Debug:@"iOSO" message:@([iOSLanguageArray count])];
    [LogUtil Debug:@"iOSHaveArray" message:@([androidLanguageArray count])];
    
     NSDictionary *resultDic1 = [self filterTwoArray:iosIn6931 array2:androidIn6931];
     NSDictionary *resultDic = [self filterTwoArray:iOSLanguageArray array2:androidLanguageArray];
    
    
}

-(NSDictionary *)filterTwoArray:(NSMutableArray *)array1 array2:(NSMutableArray *)array2
{
    NSArray *allArray = [[NSArray arrayWithArray:array1] arrayByAddingObjectsFromArray:array2];
    NSMutableArray *allBothArray = [[NSMutableArray alloc] init];
    NSMutableArray *iOSHaveArray = [[NSMutableArray alloc] init];
    NSMutableArray *androidHaveArray = [[NSMutableArray alloc] init];
    
    for (NSString *tempLanguage in allArray) {
        BOOL iOSOriginalHave = [array1 containsObject:tempLanguage];
        BOOL androidOriginalHave = [array2 containsObject:tempLanguage];
        BOOL allBothHave = [allBothArray containsObject:tempLanguage];
        BOOL iOSHave = [iOSHaveArray containsObject:tempLanguage];
        BOOL androidHave = [androidHaveArray containsObject:tempLanguage];
        if (iOSOriginalHave && androidOriginalHave && !allBothHave) {
            [allBothArray addObject:tempLanguage];
        }else
        {
            if (iOSOriginalHave && !androidOriginalHave && !iOSHave) {
                [iOSHaveArray addObject:tempLanguage];
            }else if (!iOSOriginalHave && androidOriginalHave && !androidHave)
            {
                [androidHaveArray addObject:tempLanguage];
            }else
            {
                [LogUtil Debug:@"other" message:tempLanguage];
            }
        }
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:allBothArray,@"allBoth",iOSHaveArray,@"array1Single",androidHaveArray,@"array2Single", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*)printNSLocale
{
    [LogUtil Debug:@"Test Current NSLocale \n" message:@""];
    NSLocale *locale = [NSLocale currentLocale];
    [LogUtil Debug:@"Test NSLocale currentLocale\n" message:locale];

    NSString *languageString = [locale objectForKey:NSLocaleLanguageCode];
        [LogUtil Debug:@"Test NSLocale NSLocaleLanguageCode\n" message:locale];
    languageString = [locale objectForKey:NSLocaleCountryCode];
        [LogUtil Debug:@"Test NSLocale NSLocaleCountryCode\n" message:locale];
    languageString = [locale objectForKey:NSLocaleScriptCode];
        [LogUtil Debug:@"Test NSLocale NSLocaleScriptCode\n" message:locale];
    languageString = [locale objectForKey:NSLocaleVariantCode];
        [LogUtil Debug:@"Test NSLocale NSLocaleVariantCode\n" message:locale];
    
    NSString *localeIdentifer = locale.localeIdentifier;
    [LogUtil Debug:@"Test NSLocale localeIdentifier\n" message:localeIdentifer];
    NSDictionary *someThing = [NSLocale componentsFromLocaleIdentifier:localeIdentifer];
    [LogUtil Debug:@"Test NSLocale componentsFromLocaleIdentifier\n" message:someThing];
    
    
    NSArray *languageArray = [NSLocale preferredLanguages];
        [LogUtil Debug:@"Test NSLocale preferredLanguages\n" message:languageArray];
    languageArray = [NSLocale availableLocaleIdentifiers];
        [LogUtil Debug:@"Test NSLocale availableLocaleIdentifiers\n" message:languageArray];
    languageArray = [NSLocale commonISOCurrencyCodes];
        [LogUtil Debug:@"Test NSLocale commonISOCurrencyCodes\n" message:languageArray];
    languageArray = [NSLocale ISOCountryCodes];
        [LogUtil Debug:@"Test NSLocale ISOCountryCodes\n" message:languageArray];
    languageArray = [NSLocale ISOCurrencyCodes];
        [LogUtil Debug:@"Test NSLocale ISOCurrencyCodes\n" message:languageArray];
    languageArray = [NSLocale ISOLanguageCodes];
    NSString *string = @"@[%@]";
    NSString *subString = @"";
    for (NSString *tempCode in languageArray) {
        subString =[NSString stringWithFormat:@"%@,@\"%@\"",subString,tempCode];
    }
    string = [NSString stringWithFormat:string,subString];
        [LogUtil Debug:@"Test NSLocale ISOLanguageCodes\n" message:languageArray];

    
    
    NSString *language = [languageArray objectAtIndex:0];
    if ([language rangeOfString:@"zh"].location != NSNotFound) {
        return @"zh-chs";
    }
    return @"en";
}

+ (NSString *) platformString{
    //NSString *platform = [[UIDevice currentDevice] model];
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    //iPhone
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 1";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4s";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    //iPot Touch
    
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch";
    
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2";
    
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3";
    
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4";
    
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5";
    
    //iPad
    
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1";
    
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1";
    
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1";
    
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad air";
    
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad air";
    
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad air";
    
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad mini 2";
    
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad mini 2";
    
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad mini 3";
    
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad mini 3";
    
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad air 2";
    
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad air 2";
    
    if ([platform isEqualToString:@"iPhone Simulator"] || [platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return platform;
}

+(NSString *)like_uuid
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return @"";
}

@end
