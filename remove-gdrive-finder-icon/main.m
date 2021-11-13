#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LSSharedFileListRef sflRef = LSSharedFileListCreate(NULL, kLSSharedFileListFavoriteItems, NULL);

        AuthorizationRef auth = NULL;
        NSString *itemName = @"";
        AuthorizationCreate(NULL, kAuthorizationEmptyEnvironment, kAuthorizationFlagDefaults, &auth);
        LSSharedFileListSetAuthorization(sflRef, auth);

        UInt32 seed;

        if(sflRef){
            NSArray *list = (__bridge NSArray *)LSSharedFileListCopySnapshot(sflRef, &seed);

            LSSharedFileListItemRef sflItemRef = NULL;
            for(NSObject *object in list) {
                sflItemRef = (__bridge LSSharedFileListItemRef)object;
                CFStringRef nameRef = LSSharedFileListItemCopyDisplayName(sflItemRef);
                itemName = (__bridge NSString*)nameRef;

                if ([itemName isEqualToString:@"Google Drive"]) {
                    LSSharedFileListItemRemove(sflRef, sflItemRef);
                    break;
                }
            }
        }
        CFRelease(sflRef);
    }
    return 0;
}
