//
//  TBFileAssistant.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBFileAssistant.h"

@implementation TBFileAssistant {
    TBSearchPathDirectory _directoryType;
}

@synthesize pathOfFile = _pathOfFile;

#pragma mark - init method
- (instancetype)initWithFilePath:(NSString *)filePath systemDirectoryType:(TBSearchPathDirectory)directoryType {
    if (self = [super init]) {
        _pathOfFile = filePath;
        _directoryType = directoryType;
    }
    return self;
}

- (NSString *)pathOfFile {
    return [[self class] absolutePathWithUserPath:_pathOfFile systemDirectoryType:_directoryType];
}

#pragma mark - load\save data methods
- (id)loadDataFromFileWithDataClass:(Class)class {
    self.classOfContent = class;
    return [self loadDataFromFile];
}

- (id)loadDataFromFile {
    NSString *absolutePath = [[self class] absolutePathWithUserPath:_pathOfFile
                                                systemDirectoryType:_directoryType];
    return [[_classOfContent alloc] initWithContentsOfFile:absolutePath];
}

- (BOOL)saveDataToFile:(id)data {
    self.dataOfFile = data;
    return [self saveDataToFile];
}

- (BOOL)saveDataToFile {
    [[self class] ensurePathExist:_pathOfFile systemDirectoryType:_directoryType];
    NSString *absolutePath = [[self class] absolutePathWithUserPath:_pathOfFile
                                                systemDirectoryType:_directoryType];
    if ([_dataOfFile isKindOfClass:[NSData class]]) {
        _classOfContent = [NSData class];
        NSData *data = (NSData *)_dataOfFile;
        return [data writeToFile:absolutePath atomically:YES];
    } else if ([_dataOfFile isKindOfClass:[NSDictionary class]]) {
        _classOfContent = [NSDictionary class];
        NSDictionary *dic = (NSDictionary *)_dataOfFile;
        return [dic writeToFile:absolutePath atomically:YES];
    } else if ([_dataOfFile isKindOfClass:[NSArray class]]) {
        _classOfContent = [NSArray class];
        NSArray *array = (NSArray *)_dataOfFile;
        return [array writeToFile:absolutePath atomically:YES];
    } else if ([_dataOfFile isKindOfClass:[NSString class]]) {
        _classOfContent = [NSString class];
        NSString *str = (NSString *)_dataOfFile;
        return [str writeToFile:absolutePath
                     atomically:YES
                       encoding:NSUTF8StringEncoding
                          error:nil];
    }
    return NO;
}

#pragma mark - class methods

+ (id)loadDataWithDataClass:(Class)aClass fromFileWithPath:(NSString *)pathOfFile systemDirectoryType:(TBSearchPathDirectory)directoryType {
    NSString *absolutePath = [self absolutePathWithUserPath:pathOfFile
                                        systemDirectoryType:directoryType];
    return [self loadDataWithDataClass:aClass fromFileWithAbsolutePath:absolutePath];
}

+ (id)loadDataWithDataClass:(Class)aClass fromFileWithAbsolutePath:(NSString *)absolutePath {
    if ([aClass isSubclassOfClass:[NSString class]]) {
        return [[aClass alloc] initWithContentsOfFile:absolutePath encoding:NSUTF8StringEncoding error:nil];
    }
    return [[aClass alloc] initWithContentsOfFile:absolutePath];
}

+ (BOOL)copyFileWithAbsolutePath:(NSString *)fromPath toAbsolutePath:(NSString *)toPath {
    if (![[NSFileManager defaultManager] fileExistsAtPath:toPath] && fromPath) {
        return [[NSFileManager defaultManager] copyItemAtPath:fromPath toPath:toPath error:nil];
    } else {
        return NO;
    }
}

+ (BOOL)copyBundlePathFileWithAbsolutePath:(NSString *)pathOfFile toAbsolutePath:(NSString *)toPath {
    NSString *plistPathInBundle = [[NSBundle mainBundle] pathForResource:pathOfFile ofType:nil];
    return [self copyFileWithAbsolutePath:plistPathInBundle toAbsolutePath:toPath];
}

+ (BOOL)copyBundlePathFileWithAbsolutePath:(NSString *)pathOfFile toSystemDirectoryType:(TBSearchPathDirectory)directoryType {
    NSString *toPath = [self absolutePathWithUserPath:pathOfFile systemDirectoryType:directoryType];
    return [self copyBundlePathFileWithAbsolutePath:pathOfFile toAbsolutePath:toPath];
}

+ (BOOL)saveData:(id)dataOfFile toFileWithPath:(NSString *)pathOfFile systemDirectoryType:(TBSearchPathDirectory)directoryType {
    [self ensurePathExist:pathOfFile systemDirectoryType:directoryType];
    NSString *absolutePath = [self absolutePathWithUserPath:pathOfFile
                                        systemDirectoryType:directoryType];
    return [self saveData:dataOfFile toAbsolutePath:absolutePath];
}

+ (BOOL)saveData:(id)dataOfFile toAbsolutePath:(NSString *)absolutePath {
    if ([dataOfFile isKindOfClass:[NSData class]]) {
        NSData *data = (NSData *)dataOfFile;
        return [data writeToFile:absolutePath atomically:YES];
    } else if ([dataOfFile isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)dataOfFile;
        return [dic writeToFile:absolutePath atomically:YES];
    } else if ([dataOfFile isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)dataOfFile;
        return [array writeToFile:absolutePath atomically:YES];
    } else if ([dataOfFile isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)dataOfFile;
        return [str writeToFile:absolutePath
                     atomically:YES
                       encoding:NSUTF8StringEncoding
                          error:nil];
    }
    return NO;
}

+ (BOOL)removeFileWithPath:(NSString *)pathOfFile systemDirectoryType:(TBSearchPathDirectory)directoryType {
    if (directoryType == TBFileSystemPathProjectResource) {
        return NO;
    }
    return [self removeFileWithAbsolutePath:[self absolutePathWithUserPath:pathOfFile
                                                       systemDirectoryType:directoryType]];
}

+ (BOOL)removeFileWithAbsolutePath:(NSString *)absolutePath {
    return [[NSFileManager defaultManager] removeItemAtPath:absolutePath error:nil];
}

/**
 *  获取由pathDiretory和path决定的文件的绝对目录
 *
 *  @param path          文件在pathDiretory中的相对路径
 *  @param directoryType 文件在沙箱中的目录
 *
 *  @return 文件绝对路径
 */
+ (NSString *)absolutePathWithUserPath:(NSString *)path systemDirectoryType:(TBSearchPathDirectory)directoryType {
    NSSearchPathDirectory directory = NSDocumentDirectory;
    NSString *prefix = nil;
    switch (directoryType) {
        case TBFileSystemPathCache:
            directory = NSCachesDirectory;
            break;
        case TBFileSystemPathTmp:
            prefix = NSTemporaryDirectory();
            break;
        case TBFileSystemPathProjectResource:
            prefix = [[NSBundle mainBundle] bundlePath];
        default:
            break;
    }
    if (!prefix) {
        prefix = [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) firstObject];
    }
    return path.length > 0 ? [prefix stringByAppendingPathComponent:path] : prefix;
}

+ (void)ensurePathExist:(NSString *)path systemDirectoryType:(TBSearchPathDirectory)directoryType {
    //  不应该存储文件到应用程序的程序包目录，.app目录，即使存储了，也不能通过[[NSBundle mainBundle] pathForResource:pathOfFile ofType:nil]这个方法正常获取这个文件
    if (directoryType == TBFileSystemPathProjectResource) {
        NSAssert(NO, @" %s cant not save or modify file to this path", __FILE__, __FUNCTION__);
        return;
    }
    NSArray *pathArray = [path componentsSeparatedByString:@"/"];
    NSMutableString *mutablePath = [[NSMutableString alloc] init];
    [mutablePath appendString:[self absolutePathWithUserPath:nil systemDirectoryType:directoryType]];
    [pathArray enumerateObjectsUsingBlock:^(NSString *nodeName, NSUInteger idx, BOOL *stop) {
        [mutablePath appendFormat:@"/%@", nodeName];
        [self forceEnsurePathExistWithAbsolutePath:mutablePath
                                          isFolder:idx == [pathArray count] - 1 ? NO : YES];
        
    }];
}

+ (void)ensurePathExistWithAbsolutePath:(NSString *)absolutePath {
    NSArray *pathArray = [absolutePath componentsSeparatedByString:@"/"];
    NSMutableString *mutablePath = [NSMutableString string];
    [pathArray enumerateObjectsUsingBlock:^(NSString *nodeName, NSUInteger idx, BOOL *stop) {
        [mutablePath appendFormat:@"/%@", nodeName];
        [self forceEnsurePathExistWithAbsolutePath:mutablePath
                                          isFolder:idx == [pathArray count] - 1 ? NO : YES];
        
    }];
}

+ (BOOL)forceEnsurePathExistWithAbsolutePath:(NSString *)path isFolder:(BOOL)isFolder {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL test = [filemanager fileExistsAtPath:path isDirectory:&isDirectory];
    if (test && (isDirectory == isFolder)) {
        return YES;
    }
    
    NSError *error = nil;
    if (isFolder) {
        [filemanager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
    } else {
        [filemanager createFileAtPath:path contents:nil attributes:nil];
    }
    
    //文件已经存在，创建文件夹时，存在同名的文件。这里直接删除同名文件。
    //使用本方法需慎重，防止数据丢失。
    if (error.code == 516) {
        error = nil;
        [filemanager removeItemAtPath:path error:&error];
        if (!error) {
            return [self forceEnsurePathExistWithAbsolutePath:path isFolder:isFolder];
        } else {
            return NO;
        }
    }
    return !error;
}

+ (BOOL)fileExistAtPath:(NSString *)path systemDirectoryType:(TBSearchPathDirectory)directoryType {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self absolutePathWithUserPath:path systemDirectoryType:directoryType]];
}

+ (BOOL)fileExistAtAbsolutePath:(NSString *)absolutePath {
    return [[NSFileManager defaultManager] fileExistsAtPath:absolutePath];
}

+ (NSString *)randomNumberFileName {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef stringRef = CFUUIDCreateString(NULL, uuidRef);
    NSString *randomNumberString = (__bridge NSString *)stringRef;
    randomNumberString = [randomNumberString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    CFRelease(uuidRef);
    CFRelease(stringRef);
    return randomNumberString;
}

+ (NSString *)timeIntervalFileName {
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970] * 1000];
}

@end
