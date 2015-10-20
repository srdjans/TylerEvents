<%@ Page Title="Create a new event" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewEvent.aspx.cs" Inherits="TylerEvents.NewEvent" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <br />
    <div class="container">
        <h4>Event Title:</h4>
        <asp:TextBox ID="EventTitle" runat="server" placeholder="Event Title" CssClass="form-control"></asp:TextBox>
        <asp:RequiredFieldValidator ID="EventTitleRequired" runat="server" ErrorMessage="Event title is required!!" ForeColor="Red" ControlToValidate="EventTitle"></asp:RequiredFieldValidator>
        <br />
        <h4>Location:</h4>
        <asp:TextBox ID="EventLocation" runat="server" placeholder="Location" CssClass="form-control"></asp:TextBox>
        <asp:RequiredFieldValidator ID="LocationRequired" runat="server" ErrorMessage="Location is required!!" ForeColor="Red" ControlToValidate="EventLocation"></asp:RequiredFieldValidator>
        <br />
        <div class="row">
            <div class='col-sm-3'>
                <h4>Start Date and Time:</h4>
                <div class="form-group">
                    <div class='input-group date' id='startDateTimePicker'>
                        <asp:TextBox ID="EventStartDateTime" runat="server" placeholder="Start date" CssClass="form-control"></asp:TextBox>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                    <asp:RequiredFieldValidator ID="EventStartDateTimeRequired" runat="server" ErrorMessage="Start date and time are required!!" ForeColor="Red" ControlToValidate="EventStartDateTime"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class='col-sm-3'>
                <h4>End Date and Time:</h4>
                <div class="form-group">
                    <div class='input-group date' id='endDateTimePicker'>
                        <asp:TextBox ID="EventEndDateTime" runat="server" placeholder="End date" CssClass="form-control"></asp:TextBox>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                    <asp:RequiredFieldValidator ID="EventEndDateTimeRequired" runat="server" ErrorMessage="End date and time are required!!" ForeColor="Red" ControlToValidate="EventEndDateTime"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <h4>Description:</h4>
        <asp:TextBox ID="EventDescription" runat="server" placeholder="Description" CssClass="form-control" TextMode="multiline" Rows="6"></asp:TextBox>
        <br />
        <div class="row">
            <div class='col-sm-3'>
                <h4>Minimum Participants:</h4>
                <asp:TextBox ID="MaxParticipants" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RegularExpressionValidator ID="MaxParticipantsValidator" runat="server" ErrorMessage="Please enter a valid number!!" ForeColor="Red" ControlToValidate="MaxParticipants" ValidationExpression="[-+]?\d+"></asp:RegularExpressionValidator>
                
            </div>
            <div class='col-sm-3'>
                <h4>Maximum Participants:</h4>
                <asp:TextBox ID="MinParticipants" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RegularExpressionValidator ID="MinParticipantsValidator" runat="server" ErrorMessage="Please enter a valid number!!" ForeColor="Red" ControlToValidate="MinParticipants" ValidationExpression="[-+]?\d+"></asp:RegularExpressionValidator>
            </div>
        </div>
    </div>

    <asp:Button ID="AddEvent" runat="server" Text="Add Event" CssClass="btn btn-lg btn-primary" OnClick="AddEvent_Click"/>
</asp:Content>
