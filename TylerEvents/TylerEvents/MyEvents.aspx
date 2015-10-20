<%@ Page Title="My Events" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyEvents.aspx.cs" Inherits="TylerEvents._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="CurrentMonthEventsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:TylerEventsDB %>" SelectCommand="SELECT Events.RecId, Events.EventName, Events.Location, Events.OwnerId, Events.Description, Events.MinParticipants, Events.MaxParticipants, Events.StartDateTime, Events.EndDateTime, Participants.UserId, Participants.EventId, AspNetUsers.Id, AspNetUsers.Email, AspNetUsers.EmailConfirmed, AspNetUsers.PasswordHash, AspNetUsers.SecurityStamp, AspNetUsers.PhoneNumber, AspNetUsers.PhoneNumberConfirmed, AspNetUsers.TwoFactorEnabled, AspNetUsers.LockoutEndDateUtc, AspNetUsers.LockoutEnabled, AspNetUsers.AccessFailedCount, AspNetUsers.UserName FROM Events INNER JOIN Participants ON Events.RecId = Participants.EventId INNER JOIN AspNetUsers ON Participants.UserId = AspNetUsers.Id"></asp:SqlDataSource>
    <asp:SqlDataSource ID="UpcommingEventsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:TylerEventsDB %>" SelectCommand="SELECT Events.RecId, Events.EventName, Events.Location, Events.OwnerId, Events.Description, Events.MinParticipants, Events.MaxParticipants, Events.StartDateTime, Events.EndDateTime, Participants.UserId, Participants.EventId, AspNetUsers.* FROM Events INNER JOIN Participants ON Events.RecId = Participants.EventId INNER JOIN AspNetUsers ON Participants.UserId = AspNetUsers.Id"></asp:SqlDataSource>

    <!--<div class="jumbotron">
        <h1>Tyler Events</h1>
        <p class="lead">The easy way to organize an event.</p>
    </div>-->
    <div class="row">
        <div class="col-md-2">
            <h2>Todd is awesome
            </h2>
        </div>
        <div class="col-md-7">
            <h2>Events this month</h2>
                <div class="table-responsive">
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed" DataSourceID="CurrentMonthEventsDataSource" DataKeyNames="RecId,Id">
                        <Columns>
                            <asp:BoundField DataField="EventName" HeaderText="EventName" SortExpression="EventName" />
                            <asp:BoundField DataField="StartDateTime" HeaderText="StartDateTime" SortExpression="StartDateTime" />
                        </Columns>
                    </asp:GridView>
                </div>
            <h2>Upcoming Events</h2>
                <div class="table-responsive">
                    <asp:GridView ID="UpcomingEvents" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed" DataSourceID="UpcommingEventsDataSource" DataKeyNames="RecId,Id">
                        <Columns>
                            <asp:BoundField DataField="EventName" HeaderText="EventName" SortExpression="EventName" />
                            <asp:BoundField DataField="StartDateTime" HeaderText="StartDateTime" SortExpression="StartDateTime" />
                        </Columns>
                    </asp:GridView>
                </div>
        </div>
        <div class="col-md-3">
            <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
            <h3>Recently created</h3>
            <div class="table-responive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Event name</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>

</asp:Content>
