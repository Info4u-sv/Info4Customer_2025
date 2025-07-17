using System;
using System.Data;
using System.Web;
using System.Web.Caching;

/// <summary>
/// Descrizione di riepilogo per PRT_CacheHelper
/// </summary>
///
namespace INTRA.AppCode
{
    namespace Portal
    {
        public class CacheHelper_23
        {
            public CacheHelper_23()
            {
                //
                // TODO: aggiungere qui la logica del costruttore
                //
            }
            public static bool ItemExists(string key)
            {
                //return HttpContext.Current.Cache[key] != null;
                //string context = HttpContext.Current.ToString();
                try
                {
                    return HttpRuntime.Cache[key] != null;
                    //return HttpContext.Current.Cache[key] != null;
                }
                catch (Exception)
                {
                    return false;
                }
            }

            public static void Insert(string key, object obj)
            {
                TimeSpan oneHour = new TimeSpan(1, 0, 0);
                Insert(key, obj, oneHour);
            }

            public static void Insert(string key, object obj, TimeSpan span)
            {
                if (obj == null) { }
                else
                {
                    _ = HttpRuntime.Cache.Add(
                        key,
                        obj,
                        null, //no dependencies
                        DateTime.Now.Add(span),
                        Cache.NoSlidingExpiration,
                        CacheItemPriority.Normal,
                        null //no remove callback
                    );
                    //HttpContext.Current.Cache.Add(
                    //    key,
                    //    obj,
                    //    null, //no dependencies
                    //    DateTime.Now.Add(span),
                    //    Cache.NoSlidingExpiration,
                    //    CacheItemPriority.Normal,
                    //    null //no remove callback
                    //);
                }
            }

            public static T Retrieve<T>(string key)
            {
                return (T)HttpRuntime.Cache[key];
                //return (T)HttpContext.Current.Cache[key];
            }
            public static DataTable RetrieveDT(string key)
            {
                return (DataTable)HttpRuntime.Cache[key];
                //return (DataTable)HttpContext.Current.Cache[key];
            }
        }

    }
}