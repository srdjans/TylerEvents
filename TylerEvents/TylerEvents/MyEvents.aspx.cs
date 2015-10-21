using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TylerEvents
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CurrentMonthEventsDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters[0].Value = this.User.Identity.Name;  
        }

        protected void OwnedEvents_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters[0].Value = this.User.Identity.Name;
        }

        protected void HomePageCalendar_SelectionChanged(object sender, EventArgs e)
        {
            UrlParameterPasser urlWrapper;

            // Pass textbox values to ReceiveQueryString.aspx
            urlWrapper = new UrlParameterPasser("AllEvents.aspx");

            // Add some values
            urlWrapper["filterDate"] = HomePageCalendar.SelectedDate.ToShortDateString();

            // Redirect to the page, passing the parameters in the querystring
            urlWrapper.PassParameters();
        }
    }
}