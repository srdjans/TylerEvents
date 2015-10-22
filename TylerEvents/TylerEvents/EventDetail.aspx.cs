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

            if (eventId == null){
                Response.Redirect("/MyEvents");
            }
            else{
                eventRecId = Convert.ToInt64(eventId);

                EventData eventDetailsTable = DataAccess.Instance().retrieveEventDetailsFromId(eventRecId);

                // Set the form data
                if (!IsPostBack)
                {
                    SaveEvent.Visible = false;
                    //Need new stored procedure to get the data and count of all registered participants

                    EventTitle.Text = eventDetailsTable.EventName;
                    EventOwner.Text = databaseAccess.getUserNameFromUserName(eventDetailsTable.OwnerId);
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
                    SetTheProgressBar(minParticipants, maxParticipants, registeredParticipants);

                }

                if (!databaseAccess.checkUserNameBelongsToUserId(eventDetailsTable.OwnerId, this.User.Identity.Name))
                {
                    DeleteEvent.Visible = false;
                    EditEvent.Visible = false;

                    if (databaseAccess.checkUserIsAlreadyParticipant(eventRecId, userName))
                    {
                        JoinEvent.Visible = false;
                        LeaveEvent.Visible = true;
                    }
                }
                else
                {
                    DeleteEvent.Visible = true;
                    EditEvent.Visible = true;
                    JoinEvent.Visible = false;
                }

                if (!this.IsPostBack)
                {
                    this.PopulateComments();
                }

                ParticipantsDataSource.SelectParameters["EventId"].DefaultValue = eventId;
                AttendeesList.DataBind();
            }
        }

        protected void SetTheProgressBar(int min, int max, int registered)
        {
            if (registered < min)
            {
                decimal widthPercent = Math.Floor((decimal)(100 / min) * registered);

                ProgressBarReachMin.Attributes.Add("style", string.Format("width:{0}%;", widthPercent));
                progressMin.Visible = true;
                progressMinFull.Visible = false;
            }
            else
            {
                ProgressBarReachMinFull.Attributes.Add("style", string.Format("width:{0}%;", 100));
                progressMinFull.Visible = true;
                progressMin.Visible = false;
            }

            if (registered < max)
            {
                decimal widthPercent = Math.Floor((decimal)(100 / max) * registered);

                ProgressBarReachMax.Attributes.Add("style", string.Format("width:{0}%;", widthPercent));

                progressMax.Visible = true;
                progressMaxFull.Visible = false;
            }
            else
            {
                ProgressBarReachMaxFull.Attributes.Add("style", string.Format("width:{0}%;", 100));

                progressMaxFull.Visible = true;
                progressMax.Visible = false;
            }
           
        }
        protected void JoinEvent_Click(object sender, EventArgs e)
        {
            string userName = this.User.Identity.Name;
            DataAccess databaseAccess = DataAccess.Instance();

            EventData eventDetailsTable = DataAccess.Instance().retrieveEventDetailsFromId(eventRecId);

            if (databaseAccess.getNumberOfParticipantsInEvent(eventRecId) + 1 <= eventDetailsTable.MaxParticipants || eventDetailsTable.MaxParticipants == 0)
            {
                databaseAccess.joinEvent(eventRecId, userName);
                Alert.Show("Congratulations! You have successfully registered to " + EventTitle.Text);

                LeaveEvent.Visible = true;
                JoinEvent.Visible = false;
            }
            else
            {
                Alert.Show("Sorry, but this event is already full.");

                LeaveEvent.Visible = false;
                JoinEvent.Visible = true;
            }

            
        }

        protected void LeaveEvent_Click(object sender, EventArgs e)
        {
            string userName = this.User.Identity.Name;
            DataAccess addPartiicipantToDB = DataAccess.Instance();

            addPartiicipantToDB.leaveEvent(eventRecId, userName);

            LeaveEvent.Visible = false;
            JoinEvent.Visible = true;

            Alert.Show("You have left the event " + EventTitle.Text);
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
            EditEvent.Visible = true;
            SaveEvent.Visible = false;

            EventTitle.Enabled = false;
            EventStartDateTime.Enabled = false;
            EventEndDateTime.Enabled = false;
            EventLocation.Enabled = false;
            EventDescription.Enabled = false;
            MinParticipants.Enabled = false;
            MaxParticipants.Enabled = false;
        }

        protected void DeleteEvent_Click(object sender, EventArgs e)
        {
            if (eventRecId != 0)
            {
                DataAccess.Instance().removeEvent(eventRecId);
                Response.Redirect("/MyEvents");
            }
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
            EditEvent.Visible = false;
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