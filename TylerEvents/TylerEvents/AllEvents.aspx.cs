using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace TylerEvents
{
    public partial class AllEvents : System.Web.UI.Page
    {
        private DataView allEventsDataSource;

        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable allEventsTable = DataAccess.Instance().retrieveAllEvents();

            allEventsDataSource = new DataView(allEventsTable);

            AllEventsGrid.DataSource = allEventsDataSource;

            AllEventsGrid.DataBind();
        }
        protected void CurrentMonthEventsDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters[0].Value = this.User.Identity.Name;
        }

    }
}