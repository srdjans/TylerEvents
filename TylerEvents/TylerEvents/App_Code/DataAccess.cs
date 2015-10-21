using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace TylerEvents
{
    public class DataAccess
    {
        private SqlConnection con = null;
        private volatile static DataAccess dataAccessInstance;
        const string InsertEvent = "Events_InsertEvent";
        const string GetAllEvents = "Events_GetAllEvents";
        const string GetEventFromId = "Events_GetEventFromId ";

        private DataAccess()
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        }

        public static DataAccess Instance()
        {
            if (dataAccessInstance == null)
            {
                dataAccessInstance = new DataAccess();
            }
            return dataAccessInstance;
        }

        //Executing select command
        public DataTable ExecuteSelectCommand(string CommandName, CommandType cmdType)
        {
            SqlCommand cmd = null;
            DataTable table = new DataTable();

            cmd = con.CreateCommand();

            cmd.CommandType = cmdType;
            cmd.CommandText = CommandName;

            try
            {
                con.Open();

                SqlDataAdapter da = null;
                using (da = new SqlDataAdapter(cmd))
                {
                    da.Fill(table);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                cmd.Dispose();
                cmd = null;
                con.Close();
            }

            return table;
        }

        public DataTable ExecuteParamerizedSelectCommand(string CommandName,
                         CommandType cmdType, SqlParameter[] param)
        {
            SqlCommand cmd = null;
            DataTable table = new DataTable();

            cmd = con.CreateCommand();

            cmd.CommandType = cmdType;
            cmd.CommandText = CommandName;
            cmd.Parameters.AddRange(param);

            try
            {
                con.Open();

                SqlDataAdapter da = null;
                using (da = new SqlDataAdapter(cmd))
                {
                    da.Fill(table);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                cmd.Dispose();
                cmd = null;
                con.Close();
            }

            return table;
        }

        //Executing Update, Delete, and Insert Commands
        public bool ExecuteNonQuery(string CommandName, CommandType cmdType, SqlParameter[] pars)
        {
            SqlCommand cmd = null;
            int res = 0;

            cmd = con.CreateCommand();

            cmd.CommandType = cmdType;
            cmd.CommandText = CommandName;
            cmd.Parameters.AddRange(pars);

            try
            {
                con.Open();

                res = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                cmd.Dispose();
                cmd = null;
                con.Close();
            }

            if (res >= 1)
            {
                return true;
            }
            return false;
        }

        private string getUserIdFromUserName(string userName)
        {
            SqlParameter[] userIdParams = new SqlParameter[1];
            userIdParams[0] = new SqlParameter("@UserName", userName);

            return this.ExecuteParamerizedSelectCommand("AspNetUsers_GetIdFromUserName", CommandType.StoredProcedure, userIdParams).Rows[0]["Id"].ToString();
        }

        public string getEventIdFromEventNameAndDateTime(string eventName, string eventStartDateTime)
        {
            SqlParameter[] userIdParams = new SqlParameter[2];
            userIdParams[0] = new SqlParameter("@EventName", eventName);
            userIdParams[1] = new SqlParameter("@StartDateTime", eventStartDateTime);

            return this.ExecuteParamerizedSelectCommand("Events_GetEventIdFromNameAndDateTime", CommandType.StoredProcedure, userIdParams).Rows[0]["RecId"].ToString();
        }

        public bool insertEvent(
            string eventTitle, 
            string eventLocation, 
            string eventStartDateTime, 
            string eventEndDateTime,
            string eventDescription,
            int    maxParticipants,
            int    minParticipants,
            string ownerUserName)
        {
            
            SqlParameter[] valuesToInsert = new SqlParameter[8];
            string ownerUserId = this.getUserIdFromUserName(ownerUserName);

            if (ownerUserId != "")
            {
                valuesToInsert[0] = new SqlParameter("@EventName", eventTitle);
                valuesToInsert[1] = new SqlParameter("@Location", eventLocation);
                valuesToInsert[2] = new SqlParameter("@StartDateTime", eventStartDateTime);
                valuesToInsert[3] = new SqlParameter("@EndDateTime", eventEndDateTime);
                valuesToInsert[4] = new SqlParameter("@Description", eventDescription);
                valuesToInsert[5] = new SqlParameter("@MaxParticipants", maxParticipants);
                valuesToInsert[6] = new SqlParameter("@MinParticipants", minParticipants);
                valuesToInsert[7] = new SqlParameter("@OwnerId", ownerUserId);

                return this.ExecuteNonQuery(InsertEvent, CommandType.StoredProcedure, valuesToInsert);
            }

            return false;
        }

        public bool updateEvent(
            string eventTitle,
            string eventLocation,
            string eventStartDateTime,
            string eventEndDateTime,
            string eventDescription,
            int maxParticipants,
            int minParticipants,
            string userName,
            Int64 eventIdToUpdate)
        {

            SqlParameter[] valuesToUpdate = new SqlParameter[9];
            string userId = this.getUserIdFromUserName(userName);

            if (userId != "")
            {
                valuesToUpdate[0] = new SqlParameter("@EventName", eventTitle);
                valuesToUpdate[1] = new SqlParameter("@Location", eventLocation);
                valuesToUpdate[2] = new SqlParameter("@StartDateTime", eventStartDateTime);
                valuesToUpdate[3] = new SqlParameter("@EndDateTime", eventEndDateTime);
                valuesToUpdate[4] = new SqlParameter("@Description", eventDescription);
                valuesToUpdate[5] = new SqlParameter("@MaxParticipants", maxParticipants);
                valuesToUpdate[6] = new SqlParameter("@MinParticipants", minParticipants);
                valuesToUpdate[7] = new SqlParameter("@OwnerId", userId);
                valuesToUpdate[8] = new SqlParameter("@EventId", eventIdToUpdate);

                return this.ExecuteNonQuery("Events_UpdateEvent", CommandType.StoredProcedure, valuesToUpdate);
            }

            return false;
        }

        public EventData retrieveEventDetailsFromId(Int64 EventId)
        {
            SqlParameter[] eventIdParams = new SqlParameter[1];
            EventData eventDetails = new EventData();
            DataTable data;

            eventIdParams[0] = new SqlParameter("@EventId", EventId);

            data = this.ExecuteParamerizedSelectCommand(GetEventFromId, CommandType.StoredProcedure, eventIdParams);

            eventDetails.EventName = data.Rows[0]["EventName"].ToString();
            eventDetails.Location = data.Rows[0]["Location"].ToString();
            eventDetails.StartDateTime = data.Rows[0]["StartDateTime"].ToString();
            eventDetails.EndDateTime = data.Rows[0]["EndDateTime"].ToString();
            eventDetails.Description = data.Rows[0]["Description"].ToString();
            eventDetails.MaxParticipants = Int32.Parse(data.Rows[0]["MaxParticipants"].ToString());
            eventDetails.MinParticipants = Int32.Parse(data.Rows[0]["MinParticipants"].ToString());
            eventDetails.OwnerId = data.Rows[0]["OwnerId"].ToString();

            return eventDetails;
        }

        public bool removeEvent(Int64 EventId)
        {
            SqlParameter[] eventIdParams = new SqlParameter[1];
            EventData eventDetails = new EventData();

            eventIdParams[0] = new SqlParameter("@EventId", EventId);

            return this.ExecuteNonQuery("Events_DeleteEvents", CommandType.StoredProcedure, eventIdParams);
        }
        

        public bool joinEvent(Int64 EventId, string userName)
        {
            SqlParameter[] eventIdParams = new SqlParameter[2];
            EventData eventDetails = new EventData();

            string userId = this.getUserIdFromUserName(userName);

            eventIdParams[0] = new SqlParameter("@EventId", EventId);
            eventIdParams[1] = new SqlParameter("@UserId", userId);

            return this.ExecuteNonQuery("Events_JoinEvent", CommandType.StoredProcedure, eventIdParams);
        }

        public bool checkUserIsAlreadyParticipant(Int64 EventId, string userName)
        {
            SqlParameter[] eventIdParams = new SqlParameter[2];
            EventData eventDetails = new EventData();

            string userId = this.getUserIdFromUserName(userName);

            eventIdParams[0] = new SqlParameter("@EventId", EventId);
            eventIdParams[1] = new SqlParameter("@UserId", userId);

            return (this.ExecuteParamerizedSelectCommand("Participants_GetEventParticipant", CommandType.StoredProcedure, eventIdParams).Rows.Count != 0);
        }

        public bool checkUserNameBelongsToUserId(string userId, string userName)
        {
            EventData eventDetails = new EventData();

            string userNameId = this.getUserIdFromUserName(userName);

            return (userName == userNameId);
        }

        public DataTable retrieveAllEvents()
        {
            return this.ExecuteSelectCommand(GetAllEvents, CommandType.StoredProcedure);
        }

        public int getNumberOfParticipantsInEvent(Int64 eventId)
        {
            SqlParameter[] eventIdParams = new SqlParameter[1];

            eventIdParams[0] = new SqlParameter("@EventId", eventId);

            return Int32.Parse(this.ExecuteParamerizedSelectCommand("Participants_GetNumberOfParticipantsInEvent", CommandType.StoredProcedure, eventIdParams).Rows[0]["Num"].ToString());
        }

        public bool addComment(Int64 eventId, string userName, string commentBody)
        {
            SqlParameter[] commentParams = new SqlParameter[3];
            EventData eventDetails = new EventData();

            commentParams[0] = new SqlParameter("@EventId", eventId);
            commentParams[1] = new SqlParameter("@UserName", userName);
            commentParams[2] = new SqlParameter("@CommentBody", commentBody);

            return this.ExecuteNonQuery("Comments_Insert", CommandType.StoredProcedure, commentParams);
        }

        public DataTable getAllCommentsForEvent(Int64 eventId)
        {
            string sqlStatment = "SELECT UserName, CommentBody FROM Comments WHERE EventId=@EventId";
            SqlParameter[] eventIdParams = new SqlParameter[1];

            eventIdParams[0] = new SqlParameter("@EventId", eventId);

            return this.ExecuteParamerizedSelectCommand(sqlStatment, CommandType.Text, eventIdParams);
        }
    }
}