//
//  easyModel.h
//  JdMomBaby
//
//  Created by cdyjy-cdwutao3 on 16/7/7.
//  Copyright © 2016年 jd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface easyModel : NSObject

-(instancetype)initWithDic:(NSDictionary*)dic;
-(instancetype)initWithJson:(NSString*)jsonStr;
+(instancetype)modelWithDic:(NSDictionary*)dic;
+(instancetype)modelWithJson:(NSString*)jsonStr;
@end
#define NSARRAY_TYPE(__ModelName__) @protocol __ModelName__;

@protocol NSString;
@protocol NSNumber;


