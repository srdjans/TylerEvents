using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

namespace TylerEvents
{
    public class UrlParameterPasser : BaseParameterPasser
    {
        private SortedList localQueryString = null;

        public UrlParameterPasser() : base() { }
        public UrlParameterPasser(string Url) : base(Url) { }

        public override void PassParameters()
        {
            // add parameters, if any exist
            if (localQueryString.Count > 0)
            {
                // see if we need to add the ?
                if (base.Url.IndexOf("?") == -1)
                    base.Url += "?";
                else
                    base.Url += "&";

                bool firstOne = true;
                foreach (DictionaryEntry o in localQueryString)
                {
                    if (!firstOne)
                        base.Url += "&";
                    else
                        firstOne = false;

                    base.Url += string.Concat(
                                HttpContext.Current.Server.UrlEncode(o.Key.ToString()),
                                "=",
                                HttpContext.Current.Server.UrlEncode(o.Value.ToString()));
                }
            }

            base.PassParameters();
        }

        public override string this[string name]
        {
            get
            {
                if (localQueryString == null)
                {
                    if (HttpContext.Current != null)
                        return HttpContext.Current.Request.QueryString[name];
                    else
                        return null;
                }
                else
                    return localQueryString[name].ToString();
            }
            set
            {
                if (localQueryString == null)
                    localQueryString = new SortedList();

                // add if it is new, or replace the old value
                if ((localQueryString[name]) == null)
                    localQueryString.Add(name, value);
                else
                    localQueryString[name] = value;
            }
        }

        public override ICollection Keys
        {
            get
            {
                if (localQueryString == null)
                {
                    if (HttpContext.Current != null)
                        return HttpContext.Current.Request.QueryString.Keys;
                    else
                        return null;
                }
                else
                    return localQueryString.Keys;
            }
        }
    }
}