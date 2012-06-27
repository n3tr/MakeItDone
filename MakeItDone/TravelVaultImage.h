//
//  TravelVaultImage.h
//  MakeItDone
//
//  Created by Jirat K on 6/27/55 BE.
//  Copyright (c) 2555 Allianz Global Assistance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TravelVault;

@interface TravelVaultImage : NSManagedObject

@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) NSDate * created_date;
@property (nonatomic, retain) NSString * source_path;
@property (nonatomic, retain) NSString * thumbnail_path;
@property (nonatomic, retain) TravelVault *vault;

@end
