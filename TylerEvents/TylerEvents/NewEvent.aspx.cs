using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace TylerEvents
{
    public partial class NewEvent : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddEvent_Click(object sender, EventArgs e)
        {
            string              ownerUserName = this.User.Identity.Name;
            int                 maxNumParticipants = 0;
            int                 minNumParticipants = 0;
            string              eventId;
            UrlParameterPasser  urlWrapper;

            if (this.IsValid)
            {
                //Insert to TtlerEventsDB
                DataAccess insertEventToDB = DataAccess.Instance();

                if (MaxParticipants.Text != "")
                {
                    maxNumParticipants = Int32.Parse(MaxParticipants.Text);
                }

                if (MinParticipants.Text != "")
                {
                    minNumParticipants = Int32.Parse(MinParticipants.Text);
                }

                insertEventToDB.insertEvent(
                    EventTitle.Text, 
                    EventLocation.Text, 
                    EventStartDateTime.Text,
                    EventEndDateTime.Text,
                    EventDescription.Text,
                    maxNumParticipants,
                    minNumParticipants,
                    ownerUserName);

                eventId = insertEventToDB.getEventIdFromEventNameAndDateTime(EventTitle.Text, EventStartDateTime.Text);

                insertEventToDB.joinEvent(Int64.Parse(eventId), ownerUserName);

                // Pass textbox values to ReceiveQueryString.aspx
                urlWrapper = new UrlParameterPasser("EventDetail.aspx");

                // Add some values
                urlWrapper["eventId"] = eventId;

                // Redirect to the page, passing the parameters in the querystring
                urlWrapper.PassParameters();
            }
        }
    }
}