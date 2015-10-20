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

            // XXXMukta: To Remove
            string tempOwnerId = "a14e1f21-5a2c-4d18-98db-6c1fbb938c70";
            int maxNumParticipants = 0;
            int minNumParticipants = 0;

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
                    tempOwnerId);
            }
        }
    }
}