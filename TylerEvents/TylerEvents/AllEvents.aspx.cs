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
    public partial class AllEvents : System.Web.UI.Page
    {
        private DataView allEventsDataSource;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Receive the parameters
            UrlParameterPasser urlWrapper = new UrlParameterPasser();
            String filterDate = urlWrapper["filterDate"];

            this.filterOnDate(filterDate);
        }

        protected void DateSearchButton_Clicked(object sender, EventArgs e)
        {
            this.filterOnDate(SearchDate.Text);
        }
        protected void TitleSearchButton_Clicked(object sender, EventArgs e)
        {
            this.filterOnTitle(SearchTitle.Text);
        }

        private void filterOnDate(string dateString)
        {
            DateTime startDate;
            
            if ((dateString != "") && (DateTime.TryParse(dateString, out startDate)))
            {
                AllEventsGrid.DataSourceID = null;
                AllEventsGrid.DataSource = EventsDataSourceFilterByDate;
                EventsDataSourceFilterByDate.SelectParameters["FilterDate"].DefaultValue = dateString;
            }
            else
            {
                AllEventsGrid.DataSourceID = null;
                AllEventsGrid.DataSource = EventsDataSource;
            }

            AllEventsGrid.DataBind();
        }


        private void filterOnTitle(string titleString)
        {
            if (titleString != "")
            {
                AllEventsGrid.DataSourceID = null;
                AllEventsGrid.DataSource = EventsDataSourceFilterByTitle;
                EventsDataSourceFilterByTitle.SelectParameters["FilterTitle"].DefaultValue = titleString;
            }
            else
            {
                AllEventsGrid.DataSourceID = null;
                AllEventsGrid.DataSource = EventsDataSource;
            }

            AllEventsGrid.DataBind();
        }

        protected void AllEventsGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            AllEventsGrid.PageIndex = e.NewPageIndex;
            AllEventsGrid.DataBind();
        }
        
    }
}