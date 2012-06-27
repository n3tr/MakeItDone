//
//  TravelTodoList.h
//  UnityDriven
//
//  Created by n3tr on 5/28/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TravelTodoItem, TravelUser;

@interface TravelTodoList : NSManagedObject

@property (nonatomic, retain) NSDate * created_date;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) TravelUser *owner;
@property (nonatomic, retain) NSSet *todoItems;
@end

@interface TravelTodoList (CoreDataGeneratedAccessors)

- (void)addTodoItemsObject:(TravelTodoItem *)value;
- (void)removeTodoItemsObject:(TravelTodoItem *)value;
- (void)addTodoItems:(NSSet *)values;
- (void)removeTodoItems:(NSSet *)values;

@end
