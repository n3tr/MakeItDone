//
//  TravelUser.h
//  MakeItDone
//
//  Created by Jirat K on 6/27/55 BE.
//  Copyright (c) 2555 Allianz Global Assistance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TravelTodoList, TravelVault;

@interface TravelUser : NSManagedObject

@property (nonatomic, retain) NSString * fname;
@property (nonatomic, retain) NSString * lname;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *listByUser;
@property (nonatomic, retain) TravelVault *vault;
@end

@interface TravelUser (CoreDataGeneratedAccessors)

- (void)addListByUserObject:(TravelTodoList *)value;
- (void)removeListByUserObject:(TravelTodoList *)value;
- (void)addListByUser:(NSSet *)values;
- (void)removeListByUser:(NSSet *)values;

@end
