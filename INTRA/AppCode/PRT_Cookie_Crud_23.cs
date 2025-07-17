using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace INTRA.AppCode
{
    public class PRT_Cookie_Crud_23
    {

        /// <summary>
        /// Stores multiple values in a Cookie using a key-value dictionary, creating the cookie (and/or the key) if it doesn't exists yet.
        /// </summary>
        /// <param name="cookieName">Cookie name</param>
        /// <param name="cookieDomain">Cookie domain (or NULL to use default domain value)</param>
        /// <param name="keyName">Cookie key name (if the cookie is a keyvalue pair): if NULL or EMPTY, this method will raise an exception since it's required when inserting multiple values.</param>
        /// <param name="values">Values to store into the cookie</param>
        /// <param name="expirationDate">Expiration Date (set it to NULL to leave default expiration date)</param>
        /// <param name="httpOnly">set it to TRUE to enable HttpOnly, FALSE otherwise (default: false)</param>
        /// <param name="sameSite">set it to 'None', 'Lax', 'Strict' or '(-1)' to not add it (default: '(-1)').</param>
        /// <param name="secure">set it to TRUE to enable Secure (HTTPS only), FALSE otherwise</param>
        public static void StoreInCookie(
            string cookieName,
            string cookieDomain,
            Dictionary<string, string> keyValueDictionary,
            DateTime? expirationDate,
            bool httpOnly = false,
            //SameSiteMode sameSite = (SameSiteMode)(-1),
            bool secure = false)
        {
            // NOTE: we have to look first in the response, and then in the request.
            // This is required when we update multiple keys inside the cookie.
            HttpCookie cookie = HttpContext.Current.Response.Cookies.AllKeys.Contains(cookieName)
                ? HttpContext.Current.Response.Cookies[cookieName]
                : HttpContext.Current.Request.Cookies[cookieName];
            bool cookieExist = false;
            if (cookie == null) { cookie = new HttpCookie(cookieName); } else { cookieExist = true; }
            if (keyValueDictionary == null || keyValueDictionary.Count == 0)
            {
                cookie.Value = null;
            }
            else
            {
                foreach (KeyValuePair<string, string> kvp in keyValueDictionary)
                {
                    cookie.Values.Set(kvp.Key, kvp.Value);
                }
            }

            if (expirationDate.HasValue)
            {
                cookie.Expires = expirationDate.Value;
            }

            if (!string.IsNullOrEmpty(cookieDomain))
            {
                cookie.Domain = cookieDomain;
            }

            if (httpOnly)
            {
                cookie.HttpOnly = true;
            }

            cookie.Secure = secure;
            //cookie.SameSite = sameSite;
            if (cookieExist)
            {
                HttpContext.Current.Response.SetCookie(cookie);
            }
            else { HttpContext.Current.Response.Cookies.Add(cookie); }
        }

        /// <summary>
        /// Retrieves a single value from Request.Cookies
        /// </summary>
        public static string GetFromCookie(string cookieName, string keyName)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[cookieName];
            if (cookie != null)
            {
                string val = (!string.IsNullOrEmpty(keyName)) ? cookie[keyName] : cookie.Value;
                if (!string.IsNullOrEmpty(val))
                {
                    return Uri.UnescapeDataString(val);
                }
            }
            return null;
        }
        /// <summary>
        /// Removes a single value from a cookie or the whole cookie (if keyName is null)
        /// </summary>
        /// <param name="cookieName">Cookie name to remove (or to remove a KeyValue in)</param>
        /// <param name="keyName">the name of the key value to remove. If NULL or EMPTY, the whole cookie will be removed.</param>
        /// <param name="domain">cookie domain (required if you need to delete a .domain.it type of cookie)</param>
        public static void RemoveCookie(string cookieName, string keyName, string domain)
        {
            if (HttpContext.Current.Request.Cookies[cookieName] != null)
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies[cookieName];

                // SameSite.None Cookies won't be accepted by Google Chrome and other modern browsers if they're not secure, which would lead in a "non-deletion" bug.
                // in this specific scenario, we need to avoid emitting the SameSite attribute to ensure that the cookie will be deleted.
                //if (cookie.SameSite == SameSiteMode.None && !cookie.Secure)
                //    cookie.SameSite = (SameSiteMode)(-1);

                if (string.IsNullOrEmpty(keyName))
                {
                    cookie.Expires = DateTime.UtcNow.AddYears(-1);
                    if (!string.IsNullOrEmpty(domain))
                    {
                        cookie.Domain = domain;
                    }

                    HttpContext.Current.Response.Cookies.Add(cookie);
                    HttpContext.Current.Request.Cookies.Remove(cookieName);
                }
                else
                {
                    cookie.Values.Remove(keyName);
                    if (!string.IsNullOrEmpty(domain))
                    {
                        cookie.Domain = domain;
                    }

                    HttpContext.Current.Response.Cookies.Add(cookie);
                }
            }
        }
        /// <summary>
        /// Checks if a cookie / key exists in the current HttpContext.
        /// </summary>
        public static bool CookieExist(string cookieName, string keyName)
        {
            HttpCookieCollection cookies = HttpContext.Current.Request.Cookies;
            return string.IsNullOrEmpty(keyName)
                ? cookies[cookieName] != null
                : cookies[cookieName] != null && cookies[cookieName][keyName] != null;
        }

        public static void ExpireAllCookies()
        {
            if (HttpContext.Current != null)
            {
                int cookieCount = HttpContext.Current.Request.Cookies.Count;
                for (int i = 0; i < cookieCount; i++)
                {
                    HttpCookie cookie = HttpContext.Current.Request.Cookies[i];
                    if (cookie != null)
                    {
                        HttpCookie expiredCookie = new HttpCookie(cookie.Name)
                        {
                            Expires = DateTime.Now.AddDays(-1),
                            Domain = cookie.Domain
                        };
                        HttpContext.Current.Response.Cookies.Add(expiredCookie); // overwrite it
                    }
                }

                // clear cookies server side
                HttpContext.Current.Request.Cookies.Clear();
            }
        }


        public static void RewriteCoockies(params string[] Pairs)
        {
            for (int i = 0; i < Pairs.Length; i++)
            {
                if (i % 2 != 0)
                {
                    continue;
                }
                else
                {
                    HttpCookie cookie = HttpContext.Current.Request.Cookies[Pairs[i]];
                    cookie.Value = Pairs[i + 1];
                    HttpContext.Current.Response.Cookies.Add(cookie);

                }
            }
        }


        public static void ExpireCookies(params string[] cookieNames)
        {
            foreach (string name in cookieNames)
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies[name];
                cookie.Expires = DateTime.Now.AddDays(-1);
                HttpContext.Current.Response.Cookies.Add(cookie);
            }
        }

        /*
         Funzione per la creazione di un cookie:
            Legenda parametri:
                cookieName: Nome del Cookie;
                    Valori ammessi: string;

                cookie_values: Dictionary di valori e chiavi di lettura dei dati salvati nel cookie;
                    Valori ammessi: null e Dictionary<string,string>;
                
                cookie_val: valore del cookie;
                    Valori ammessi: null e string;


            Funzionamento:
                Passo obbligatoriamente il nome del cookie ed in seguito posso passare uno  degli altri due parametri per genereare il cookie;
                Se si valorizza il primo campo si 
         
         */
        public static void CreateCookie(string name, string value)
        {
            try
            {
                CreateCookie(name, value, null);
            }
            catch
            {
                RewriteCoockies(name, value);
            }
        }

        public static void CreateCookie(string name, Dictionary<string, string> cookie_values)
        {
            CreateCookie(name, null, cookie_values);
        }
        private static void CreateCookie(string cookieName, string cookie_val, Dictionary<string, string> cookie_values)
        {
            if (cookie_values == null && cookie_val == null)
            {
                throw new ArgumentNullException("Valore del cookie mancante");
            }

            if (HttpContext.Current.Request.Cookies[cookieName] != null)
            {
                throw new InvalidOperationException("Cookie già esistente");
            }

            HttpCookie cookie = new HttpCookie(cookieName);
            if (cookie_values != null)
            {
                foreach (string key in cookie_values.Keys)
                {
                    cookie[key] = cookie_values[key];
                }
            }

            if (cookie_val != null)
            {
                cookie.Value = cookie_val;
            }

            HttpContext.Current.Response.Cookies.Add(cookie);
        }
    }
}