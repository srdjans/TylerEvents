using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

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
            this.filterCalendarGridOnDate(HomePageCalendar.SelectedDate.ToShortDateString());
            /*UrlParameterPasser urlWrapper;

            // Pass textbox values to ReceiveQueryString.aspx
            urlWrapper = new UrlParameterPasser("AllEvents.aspx");

            // Add some values
            urlWrapper["filterDate"] = HomePageCalendar.SelectedDate.ToShortDateString();

            // Redirect to the page, passing the parameters in the querystring
            urlWrapper.PassParameters();*/
        }

        private void filterCalendarGridOnDate(string dateString)
        {
            if (dateString != "")
            {
                CalendarEvents.DataSourceID = null;
                CalendarEvents.DataSource = CalendarEventsDataSource;
                CalendarEventsDataSource.SelectParameters["FilterDate"].DefaultValue = dateString;
                CalendarPanel.Visible = true;
            }
            else
            {
                CalendarPanel.Visible = false;
            }

            CalendarEvents.DataBind();
        }
    }
}