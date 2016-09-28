//
//  easyModel.h
//
//  Created by cdyjy-cdwutao3 on 16/7/7.
//  Copyright © 2016年 jd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface easyModel : NSObject
#pragma mark -
#pragma -mark ==== init ====
#pragma mark -
-(instancetype)initWithDic:(NSDictionary*)dic;
-(instancetype)initWithJson:(NSString*)jsonStr;
+(instancetype)modelWithDic:(NSDictionary*)dic;
+(instancetype)modelWithJson:(NSString*)jsonStr;

#pragma mark -
#pragma -mark ==== suport fuc ====
#pragma mark -
-(id)getObjectForKey:(id)key witClass:(Class)forClass  dic:(NSDictionary*)dic;
-(NSString *)getStringElementForKey:(id)key dic:(NSDictionary*)dic;
-(NSDictionary*)getDicElementForKey:(id)key dic:(NSDictionary*)dic;
- (NSArray*)getArrayElementForKey:(id)key dic:(NSDictionary*)dic;
- (NSNumber *)getNumberElementForKey:(id)key dic:(NSDictionary*)dic;
@end

#define NSARRAY_TYPE(__ModelName__) @protocol __ModelName__;

@protocol NSString;
@protocol NSNumber;


