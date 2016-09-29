//
//  People.h
//  easyModel
//
//  Created by cdyjy-cdwutao3 on 16/9/23.
//  Copyright © 2016年 horace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "easyModel.h"

@interface subTypeClass  : easyModel
@property (nonatomic,copy) NSString* subTypeName;
@property (nonatomic,assign)  int  subi;

@end
NSARRAY_TYPE(subTypeClass)



@interface testType:easyModel
@property(copy, nonatomic)  dispatch_block_t block;
@property(assign, nonatomic) BOOL b;
@property(assign, nonatomic) int i;
@property(assign, nonatomic) unsigned int ui;
@property(assign, nonatomic) NSInteger ni;
@property(assign, nonatomic) NSUInteger uni;
@property(assign, nonatomic) long l;
@property(assign, nonatomic) long long ll;
@property(assign, nonatomic) float f;
@property(assign, nonatomic) double d;
@property(copy, nonatomic) NSString *string;
@property(copy, nonatomic) NSMutableString *mstring;
@property(strong, nonatomic) NSNumber *number;
@property(strong, nonatomic) NSArray<NSString> *subStrings;
@property(strong, nonatomic)  NSArray<subTypeClass> *subTypes;
@property(strong, nonatomic)  NSMutableArray<subTypeClass> *msubTypes;

@end

@interface subTestType: testType
@property (copy, nonatomic) NSString* subNameString;
@end
