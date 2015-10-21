using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;

namespace TylerEvents
{
    public partial class Contact : Page
    {
        private string eventId;
        private long eventRecId;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Receive the parameters
            UrlParameterPasser urlWrapper = new UrlParameterPasser();
            eventId = urlWrapper["eventId"];
            eventRecId = Convert.ToInt64(eventId);

            // Set the form data
            EventData eventDetailsTable = DataAccess.Instance().retrieveEventDetailsFromId(eventRecId);
            //Need new stored procedure to get the data and count of all registered participants

            EventNameLabel.Text = eventDetailsTable.EventName;
            DateTimeLabel.Text = eventDetailsTable.StartDateTime;
            LocationLabel.Text = eventDetailsTable.Location;
            DescriptionLabel.Text = eventDetailsTable.Description;

            //Progress Bar data
            int minParticipants = eventDetailsTable.MinParticipants;
            int maxParticipants = eventDetailsTable.MaxParticipants;
            int registeredParticipants = 0;// will be set to count of particapants
            //SetTheProgressBar(minParticipants, maxParticipants, registeredParticipants);
        }

        protected void SetTheProgressBar(int min, int max, int registered)
        {
            HtmlGenericControl htmlProgressBar = new HtmlGenericControl();
            if (registered < min)
            {
                decimal widthPercent = Math.Floor((decimal)(100 / max) * min);
                htmlProgressBar = (HtmlGenericControl)htmlProgressBar.FindControl("ProgressBarReachMin");
                htmlProgressBar.Attributes.Add("style", string.Format("width:{0}%;", widthPercent));
            }
            else
            {
                decimal widthPercent = Math.Floor((decimal)(100 / max) * registered);
                htmlProgressBar = (HtmlGenericControl)htmlProgressBar.FindControl("ProgressBarReachMax");
                htmlProgressBar.Attributes.Add("style", string.Format("width:{0}%;", widthPercent));
            }
           
        }

        protected void JoinEvent_Click(object sender, EventArgs e)
        {
            //Insert user record to particapant table
        }
    }
}