<%@ Page Title="Event Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventDetail.aspx.cs" Inherits="TylerEvents.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-md-8">
        <h3><%: Title   %><button runat="server" class = "btn btn-default" type = "button" onserverclick="EditButton_ServerClick"><i class="glyphicon glyphicon-edit">Edit</i></button></h3>
        <label>Event Title</label>
        <asp:TextBox ID="EventTitle" runat="server" placeholder="Event Title" CssClass="form-control" Enabled="false"></asp:TextBox>
        <asp:RequiredFieldValidator ID="EventTitleRequired" runat="server" ErrorMessage="Event title is required!!" ForeColor="Red" ControlToValidate="EventTitle"></asp:RequiredFieldValidator>
        <br />
        <label>Location</label>
        <asp:TextBox ID="EventLocation" runat="server" placeholder="Location" CssClass="form-control" Enabled="false"></asp:TextBox>
        <asp:RequiredFieldValidator ID="LocationRequired" runat="server" ErrorMessage="Location is required!!" ForeColor="Red" ControlToValidate="EventLocation"></asp:RequiredFieldValidator>
        <br />
        <div class="row">
            <div class='col-sm-3'>
                <label>Start Date and Time</label>
                <div class="form-group">
                    <div class='input-group date' id='startDateTimePicker'>
                        <asp:TextBox ID="EventStartDateTime" runat="server" placeholder="Start date" CssClass="form-control"  Enabled="false"></asp:TextBox>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                    <asp:RequiredFieldValidator ID="EventStartDateTimeRequired" runat="server" ErrorMessage="Start date and time are required!!" ForeColor="Red" ControlToValidate="EventStartDateTime"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class='col-sm-3'>
                <label>End Date and Time</label>
                <div class="form-group">
                    <div class='input-group date' id='endDateTimePicker'>
                        <asp:TextBox ID="EventEndDateTime" runat="server" placeholder="End date" CssClass="form-control"  Enabled="false"></asp:TextBox>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                    <asp:RequiredFieldValidator ID="EventEndDateTimeRequired" runat="server" ErrorMessage="End date and time are required!!" ForeColor="Red" ControlToValidate="EventEndDateTime"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <label>Description</label>
        <asp:TextBox ID="EventDescription" runat="server" placeholder="Description" CssClass="form-control" TextMode="multiline" Rows="6" Enabled="false"></asp:TextBox>
        <br />
        <div class="row">
            <div class='col-sm-4'>
                <label>Minimum Participants</label>
                <asp:TextBox ID="MinParticipants" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                <asp:RegularExpressionValidator ID="MinParticipantsValidator" runat="server" ErrorMessage="Please enter a valid number!!" ForeColor="Red" ControlToValidate="MaxParticipants" ValidationExpression="[-+]?\d+"></asp:RegularExpressionValidator>
                
            </div>
            <div class='col-sm-4'>
                <label>Maximum Participants</label>
                <asp:TextBox ID="MaxParticipants" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                <asp:RegularExpressionValidator ID="MaxParticipantsValidator" runat="server" ErrorMessage="Please enter a valid number!!" ForeColor="Red" ControlToValidate="MinParticipants" ValidationExpression="[-+]?\d+"></asp:RegularExpressionValidator>
            </div>
        </div>
            <asp:Button ID="JoinEvent" runat="server" Text="Join Event" CssClass="btn btn-lg btn-primary" OnClick="JoinEvent_Click"/>
    </div>
    <div>
        <asp:Panel ID="ChatPanel" runat="server">

        </asp:Panel>
    </div>
  
    <div class="col-md-4">
        <div class="progress">
            <div Id="ProgressBarReachMin" class="progress-bar progress-bar-warning" role="progressbar" style= "width:0%">
                Not enough<!--need a placeholder for the progress bar-->

            </div>
            <div Id="ProgressBarReachMax" class="progress-bar progress-bar-info" role="progressbar" style= "width:0%">
               Enough <!--need a placeholder for the progress bar-->

            </div>
        </div>
        <asp:Panel ID="AttendeesPanel" runat="server" BackColor="WhiteSmoke" Height="900px">
            <asp:GridView ID="AttendeesList" runat="server"></asp:GridView>
        </asp:Panel>
    </div>
    
</asp:Content>
