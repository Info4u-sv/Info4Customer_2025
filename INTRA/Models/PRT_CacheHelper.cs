using System;
using System.Data;
using System.Web;
using System.Web.Caching;

/// <summary>
/// Descrizione di riepilogo per PRT_CacheHelper
/// </summary>
///
namespace info4lab
{
    namespace Portal
    {
        public class CacheHelper
        {
            public CacheHelper()
            {
                //
                // TODO: aggiungere qui la logica del costruttore
                //
            }
            public static bool ItemExists(string key)
            {
                //return HttpContext.Current.Cache[key] != null;
                //string context = HttpContext.Current.ToString();
#pragma warning disable CS0168 // La variabile 'e' è dichiarata, ma non viene mai usata
                try
                {
                    return HttpRuntime.Cache[key] != null;
                    //return HttpContext.Current.Cache[key] != null;
                }
                catch (Exception e)
                {
                    return false;
                }
#pragma warning restore CS0168 // La variabile 'e' è dichiarata, ma non viene mai usata
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
                    HttpRuntime.Cache.Add(
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