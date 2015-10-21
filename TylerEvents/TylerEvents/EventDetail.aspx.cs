using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Configuration;
using System.Data.SqlClient;

namespace TylerEvents
{
    public partial class Contact : Page
    {
        private long eventRecId;

        protected void Page_Load(object sender, EventArgs e)
        {
            string eventId;

            string userName = this.User.Identity.Name;
            DataAccess databaseAccess = DataAccess.Instance();

            // Receive the parameters
            UrlParameterPasser urlWrapper = new UrlParameterPasser();
            eventId = urlWrapper["eventId"];
            eventRecId = Convert.ToInt64(eventId);

            // Set the form data
            if (!IsPostBack)
            {
                SaveEvent.Visible = false;

            EventData eventDetailsTable = DataAccess.Instance().retrieveEventDetailsFromId(eventRecId);
            //Need new stored procedure to get the data and count of all registered participants

            EventTitle.Text = eventDetailsTable.EventName;
            EventStartDateTime.Text = eventDetailsTable.StartDateTime;
            EventEndDateTime.Text = eventDetailsTable.StartDateTime;
            EventLocation.Text = eventDetailsTable.Location;
            EventDescription.Text = eventDetailsTable.Description;
            MinParticipants.Text = eventDetailsTable.MinParticipants.ToString();
            MaxParticipants.Text = eventDetailsTable.MaxParticipants.ToString();

            //Progress Bar data
            int minParticipants = eventDetailsTable.MinParticipants;
            int maxParticipants = eventDetailsTable.MaxParticipants;
            int registeredParticipants = databaseAccess.getNumberOfParticipantsInEvent(eventRecId);
            //SetTheProgressBar(minParticipants, maxParticipants, registeredParticipants);
            }

            if (databaseAccess.checkUserIsAlreadyParticipant(eventRecId, userName))
            {
                JoinEvent.Visible = false;
            }

            if (!this.IsPostBack)
            {
                this.PopulateComments();
            }

            ParticipantsDataSource.SelectParameters["EventId"].DefaultValue = eventId;
            AttendeesList.DataBind();
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
            string userName = this.User.Identity.Name;
            DataAccess addPartiicipantToDB = DataAccess.Instance();

            addPartiicipantToDB.joinEvent(eventRecId, userName);

            Alert.Show("Congratulations! You have successfully reggistered to " + EventTitle.Text);
        }

        protected void SaveEvent_Click(object sender, EventArgs e)
        {
            string userName = this.User.Identity.Name;
            int maxNumParticipants = 0;
            int minNumParticipants = 0;
            
            DataAccess updateEventOnDB = DataAccess.Instance();

            if (MaxParticipants.Text != "")
            {
                maxNumParticipants = Int32.Parse(MaxParticipants.Text);
            }

            if (MinParticipants.Text != "")
            {
                minNumParticipants = Int32.Parse(MinParticipants.Text);
            }

            updateEventOnDB.updateEvent(
                EventTitle.Text,
                EventLocation.Text,
                EventStartDateTime.Text,
                EventEndDateTime.Text,
                EventDescription.Text,
                maxNumParticipants,
                minNumParticipants,
                userName,
                eventRecId);
            
            JoinEvent.Visible = false;
            editButton.Visible = true;
            SaveEvent.Visible = false;

            EventTitle.Enabled = false;
            EventStartDateTime.Enabled = false;
            EventEndDateTime.Enabled = false;
            EventLocation.Enabled = false;
            EventDescription.Enabled = false;
            MinParticipants.Enabled = false;
            MaxParticipants.Enabled = false;
        }

        protected void EditButton_ServerClick(object sender, EventArgs e)
        {
            EventTitle.Enabled = true;
            EventStartDateTime.Enabled = true;
            EventEndDateTime.Enabled = true;
            EventLocation.Enabled = true;
            EventDescription.Enabled = true;
            MinParticipants.Enabled = true;
            MaxParticipants.Enabled = true;

            SaveEvent.Visible = true;
            editButton.Visible = false;
        }

        protected void AddComment(object sender, EventArgs e)
        {
            DataAccess accessDataBase = DataAccess.Instance();
            UrlParameterPasser urlWrapper;

            accessDataBase.addComment(eventRecId, this.User.Identity.Name, txtCommentBody.Text.Trim());

            // Reload page
            urlWrapper = new UrlParameterPasser("EventDetail.aspx");
            urlWrapper["eventId"] = eventRecId.ToString();
            urlWrapper.PassParameters();
        }

        private void PopulateComments()
        {
            DataAccess accessDataBase = DataAccess.Instance();
            this.rptComments.DataSource = accessDataBase.getAllCommentsForEvent(eventRecId);
            this.rptComments.DataBind();
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters[0].Value = eventRecId;
        }
    }
}