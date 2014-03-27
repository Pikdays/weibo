//
//  WXBaseModel.h
//  MTWeibo
//  所有对象实体的基类

//  Created by wei.chen on 11-9-22.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject <NSCoding>{

}

-(id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;

- (NSString *)cleanString:(NSString *)str;    //清除\n和\r的字符串

@end
