using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TylerEvents
{
    public partial class NewEvent : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddEvent_Click(object sender, EventArgs e)
        {
            if (this.IsValid)
            {
                //Insert to db here
            }
        }
    }
}