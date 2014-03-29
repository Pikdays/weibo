#import "UIUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"
@implementation UIUtils

+ (NSString *)getDocumentsPath:(NSString *)fileName {
    
    //两种获取document路径的方式
//    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [paths objectAtIndex:0];
    NSString *path = [documents stringByAppendingPathComponent:fileName];
    
    return path;
}

+ (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formate];
	NSString *str = [formatter stringFromDate:date];
	[formatter release];
	return str;
}

+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    [formatter release];
    return date;
}

//Sat Jan 12 11:50:16 +0800 2013
+ (NSString *)fomateString:(NSString *)datestring {
    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSDate *createDate = [UIUtils dateFromFomate:datestring formate:formate];
    NSString *text = [UIUtils stringFromFomate:createDate formate:@"MM-dd HH:mm"];
    return text;
}
+(NSString *)parseUrl:(NSString *)text
{
    
    if(text.length>0){
        NSString *regex = @"(@\\w+)|(#\\w+#)|(http(s)?://([A-Za-z0-9._-]+(/)?)*)";
        
        
        NSArray *array = [text componentsMatchedByRegex:regex];
        
        for (NSString *link in array) {
            
            NSString * replaceing=nil;
            
            if ([link hasPrefix:@"@"]) {
                replaceing=[NSString stringWithFormat:@"<a href='user://%@'>%@</a>",[link URLEncodedString],link];
            }else if ([link hasPrefix:@"http"]){
                replaceing=[NSString stringWithFormat:@"<a href='%@'>%@</a>",link,link];
                
            }else if([link hasPrefix:@"#"]){
                replaceing=[NSString stringWithFormat:@"<a href='topic://%@'>%@</a>",[link URLEncodedString],link];
                
            }
            
            if (replaceing!=nil) {
                text = [text stringByReplacingOccurrencesOfString:link withString:replaceing];
                
            }
            
        }
    
    }

    return text;

}
@end
