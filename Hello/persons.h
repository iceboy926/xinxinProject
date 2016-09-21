//
//  persons.h
//  Hello
//
//  Created by 金玉衡 on 16/9/20.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <Realm/Realm.h>

@interface persons : RLMObject

@property (nonatomic, assign) NSInteger _ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString *sex;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<persons>
RLM_ARRAY_TYPE(persons)
