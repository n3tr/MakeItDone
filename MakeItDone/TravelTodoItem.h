//
//  TravelTodoItem.h
//  UnityDriven
//
//  Created by n3tr on 5/28/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TravelTodoList;

@interface TravelTodoItem : NSManagedObject

@property (nonatomic, retain) NSDate * created_date;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSNumber * isDone;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) TravelTodoList *parentList;

@end
