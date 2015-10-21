using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TylerEvents
{
    public partial class Contact : Page
    {
        private string eventId;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Receive the parameters
            UrlParameterPasser urlWrapper = new UrlParameterPasser();
            eventId = urlWrapper["eventId"];
        }
    }
}