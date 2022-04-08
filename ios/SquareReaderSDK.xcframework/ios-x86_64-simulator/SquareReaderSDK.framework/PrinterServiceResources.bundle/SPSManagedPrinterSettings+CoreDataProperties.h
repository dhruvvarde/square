//
//  SPSManagedPrinterSettings+CoreDataProperties.h
//  
//
//  Created by build on 10/18/21.
//
//  This file was automatically generated and should not be edited.
//

#import "SPSManagedPrinterSettings+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SPSManagedPrinterSettings (CoreDataProperties)

+ (NSFetchRequest<SPSManagedPrinterSettings *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *accountRemoteID;
@property (nullable, nonatomic, retain) SPSPrinterSettings *printerSettings;

@end

NS_ASSUME_NONNULL_END
