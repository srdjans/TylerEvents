using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TylerEvents
{
    public class EventData
    {
        private string eventName;
        private string location;
        private string ownerId;
        private string description;
        private int minParticipants;
		private int maxParticipants;
        private string startDateTime;
        private string endDateTime;

        public string EventName
        {
            get { return eventName; }
            set { eventName = value; }
        }

        public string Location
        {
            get { return location; }
            set { location = value; }
        }

        public string OwnerId
        {
            get { return ownerId; }
            set { ownerId = value; }
        }

        public string Description
        {
            get { return description; }
            set { description = value; }
        }

        public int MinParticipants
        {
            get { return minParticipants; }
            set { minParticipants = value; }
        }

        public int MaxParticipants
        {
            get { return maxParticipants; }
            set { maxParticipants = value; }
        }

        public string StartDateTime
        {
            get { return startDateTime; }
            set { startDateTime = value; }
        }

        public string EndDateTime
        {
            get { return endDateTime; }
            set { endDateTime = value; }
        }
    }
}