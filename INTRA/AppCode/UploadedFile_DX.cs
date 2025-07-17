using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace INTRA.AppCode
{
    public class UploadedFile_DX
    {

        public class UploadedFilesStorage_1
        {
            public string Path { get; set; }
            public string Key { get; set; }
            public DateTime LastUsageTime { get; set; }

            public IList<UploadedFileInfo_1> Files { get; set; }
        }
        public class UploadedFileInfo_1
        {
            public string UniqueFileName { get; set; }
            public string OriginalFileName { get; set; }
            public string FilePath { get; set; }
            public string FileSize { get; set; }
        }

        public static class UploadControlHelper
        {
            private const int DisposeTimeout = 5;
            private const string FolderKey = "UploadDirectory";
            private const string TempDirectory = "~/UploadControl/Temp/";
            private static readonly object storageListLocker = new object();

            private static HttpContext Context => HttpContext.Current;

            private static string RootDirectory => Context.Request.MapPath(TempDirectory);

            private static IList<UploadedFilesStorage_1> UploadedFilesStorageList { get; set; }

            static UploadControlHelper()
            {
                UploadedFilesStorageList = new List<UploadedFilesStorage_1>();
            }

            private static string CreateTempDirectoryCore()
            {
                string uploadDirectory = Path.Combine(RootDirectory, Path.GetRandomFileName());
                _ = Directory.CreateDirectory(uploadDirectory);

                return uploadDirectory;
            }
            public static UploadedFilesStorage_1 GetUploadedFilesStorageByKey(string key)
            {
                lock (storageListLocker)
                {
                    return GetUploadedFilesStorageByKeyUnsafe(key);
                }
            }

            private static UploadedFilesStorage_1 GetUploadedFilesStorageByKeyUnsafe(string key)
            {
                UploadedFilesStorage_1 storage = UploadedFilesStorageList.Where(i => i.Key == key).SingleOrDefault();
                if (storage != null)
                {
                    storage.LastUsageTime = DateTime.Now;
                }

                return storage;
            }
            public static string GenerateUploadedFilesStorageKey()
            {
                return Guid.NewGuid().ToString("N");
            }
            public static void AddUploadedFilesStorage(string key)
            {
                lock (storageListLocker)
                {
                    UploadedFilesStorage_1 storage = new UploadedFilesStorage_1
                    {
                        Key = key,
                        Path = CreateTempDirectoryCore(),
                        LastUsageTime = DateTime.Now,
                        Files = new List<UploadedFileInfo_1>()
                    };
                    UploadedFilesStorageList.Add(storage);
                }
            }
            public static void RemoveUploadedFilesStorage(string key)
            {
                lock (storageListLocker)
                {
                    UploadedFilesStorage_1 storage = GetUploadedFilesStorageByKeyUnsafe(key);
                    if (storage != null)
                    {
                        Directory.Delete(storage.Path, true);
                        _ = UploadedFilesStorageList.Remove(storage);
                    }
                }
            }
            public static void RemoveOldStorages()
            {
                if (!Directory.Exists(RootDirectory))
                {
                    _ = Directory.CreateDirectory(RootDirectory);
                }

                lock (storageListLocker)
                {
                    string[] existingDirectories = Directory.GetDirectories(RootDirectory);
                    foreach (string directoryPath in existingDirectories)
                    {
                        UploadedFilesStorage_1 storage = UploadedFilesStorageList.Where(i => i.Path == directoryPath).SingleOrDefault();
                        if (storage == null || (DateTime.Now - storage.LastUsageTime).TotalMinutes > DisposeTimeout)
                        {
                            Directory.Delete(directoryPath, true);
                            if (storage != null)
                            {
                                _ = UploadedFilesStorageList.Remove(storage);
                            }
                        }
                    }
                }
            }
            public static UploadedFileInfo_1 AddUploadedFileInfo(string key, string originalFileName)
            {
                UploadedFilesStorage_1 currentStorage = GetUploadedFilesStorageByKey(key);
                UploadedFileInfo_1 fileInfo = new UploadedFileInfo_1
                {
                    FilePath = Path.Combine(currentStorage.Path, Path.GetRandomFileName()),
                    OriginalFileName = originalFileName,
                    UniqueFileName = GetUniqueFileName(currentStorage, originalFileName)
                };
                currentStorage.Files.Add(fileInfo);

                return fileInfo;
            }
            public static UploadedFileInfo_1 GetDemoFileInfo(string key, string fileName)
            {
                UploadedFilesStorage_1 currentStorage = GetUploadedFilesStorageByKey(key);
                return currentStorage.Files.Where(i => i.UniqueFileName == fileName).SingleOrDefault();
            }
            public static string GetUniqueFileName(UploadedFilesStorage_1 currentStorage, string fileName)
            {
                string baseName = Path.GetFileNameWithoutExtension(fileName);
                string ext = Path.GetExtension(fileName);
                int index = 1;
                while (currentStorage.Files.Any(i => i.UniqueFileName == fileName))
                {
                    fileName = string.Format("{0} ({1}){2}", baseName, index++, ext);
                }

                return fileName;
            }



        }

    }
}