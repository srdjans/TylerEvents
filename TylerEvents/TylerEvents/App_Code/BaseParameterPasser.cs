using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

namespace TylerEvents
{
    public abstract class BaseParameterPasser
    {
        private string url = string.Empty;

        public BaseParameterPasser()
        {
            if (HttpContext.Current != null)
                url = HttpContext.Current.Request.Url.ToString();
        }

        public BaseParameterPasser(string Url)
        {
            this.url = Url;
        }

        public virtual void PassParameters()
        {
            if (HttpContext.Current != null)
                HttpContext.Current.Response.Redirect(Url);
        }

        public string Url
        {
            get
            {
                return url;
            }
            set
            {
                url = value;
            }
        }

        public abstract string this[string name]
        {
            get;
            set;
        }

        public abstract ICollection Keys
        {
            get;
        }
    }

}