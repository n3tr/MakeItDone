//
//  TravelVault.h
//  MakeItDone
//
//  Created by Jirat K on 6/27/55 BE.
//  Copyright (c) 2555 Allianz Global Assistance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TravelUser, TravelVaultImage, TravelVaultNote;

@interface TravelVault : NSManagedObject

@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *imageList;
@property (nonatomic, retain) NSSet *noteList;
@property (nonatomic, retain) TravelUser *owner;
@end

@interface TravelVault (CoreDataGeneratedAccessors)

- (void)addImageListObject:(TravelVaultImage *)value;
- (void)removeImageListObject:(TravelVaultImage *)value;
- (void)addImageList:(NSSet *)values;
- (void)removeImageList:(NSSet *)values;

- (void)addNoteListObject:(TravelVaultNote *)value;
- (void)removeNoteListObject:(TravelVaultNote *)value;
- (void)addNoteList:(NSSet *)values;
- (void)removeNoteList:(NSSet *)values;

@end
