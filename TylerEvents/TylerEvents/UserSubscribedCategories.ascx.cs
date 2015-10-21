using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TylerEvents
{
    public partial class UserSubscribedCategories : System.Web.UI.UserControl
    {
        private string categoryName;
        public event EventHandler CategoryRemoved;

        public string CategoryName
        {
            get { return categoryName; }
            set { categoryName = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RemoveCategory_Clicked(object sender, EventArgs e)
        {
            // Add code to remove category

            if (CategoryRemoved != null)
                CategoryRemoved(this, EventArgs.Empty);
        }

    }
}