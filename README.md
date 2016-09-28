easyModel

一个简单的将JSON或者NSDictionary对象转换成自定义对象的组件
可以定义如下对象：
#import "easyModel.h"

@interface subTypeClass  : easyModel

@property (nonatomic,copy) NSString* subTypeName;

@property (nonatomic,assign)  int  subi;

@end

NSARRAY_TYPE(subTypeClass)



@interface testType:easyModel

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

功能
1:支持int，NSInteger，BOOL，float等基础类型

2:支持NSArray模板定义对象

    比如   NSArray<NSString> * strings

           NSArray<modelType>  models

3:不支持 NSDate，NSData，我们的数据基本都是从网络取回来的json，不用支持如此复杂的数据类型，如果有需要自己添加也方便

4:没有做自己定义map，如果有需要，可以添做如下操作

比如对应的 otherName  需要对应到 网络返回的jsonName:

@implement testType

-(instancetype)initWithDic:(NSDictionary*)dic{

  self = [supper initWithDic:dic];

  if(self){

     self.otherName = [self getStringElementForKey:@"jsonName" dic:dic];

  }

  return self;

}

@end

