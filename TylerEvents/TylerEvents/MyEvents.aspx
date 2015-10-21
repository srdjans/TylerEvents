<%@ Page Title="My Events" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyEvents.aspx.cs" Inherits="TylerEvents._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="OwnedEvents" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT Events.RecId, Events.EventName, Events.Location, Events.OwnerId, Events.Description, Events.MinParticipants, Events.MaxParticipants, Events.StartDateTime, Events.EndDateTime, AspNetUsers.Id, AspNetUsers.Email, AspNetUsers.EmailConfirmed, AspNetUsers.PasswordHash, AspNetUsers.SecurityStamp, AspNetUsers.PhoneNumber, AspNetUsers.PhoneNumberConfirmed, AspNetUsers.TwoFactorEnabled, AspNetUsers.LockoutEndDateUtc, AspNetUsers.LockoutEnabled, AspNetUsers.AccessFailedCount, AspNetUsers.UserName FROM Events INNER JOIN AspNetUsers ON Events.OwnerId = AspNetUsers.Id WHERE (AspNetUsers.UserName = @UserId)" OnSelecting="OwnedEvents_Selecting">
        <SelectParameters>
            <asp:Parameter Name="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="RegisteredEventsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT Events.RecId, Events.EventName, Events.Location, Events.OwnerId, Events.Description, Events.MinParticipants, Events.MaxParticipants, Events.StartDateTime, Events.EndDateTime, Participants.UserId, Participants.EventId, AspNetUsers.Id, AspNetUsers.Email, AspNetUsers.EmailConfirmed, AspNetUsers.PasswordHash, AspNetUsers.SecurityStamp, AspNetUsers.PhoneNumber, AspNetUsers.PhoneNumberConfirmed, AspNetUsers.TwoFactorEnabled, AspNetUsers.LockoutEndDateUtc, AspNetUsers.LockoutEnabled, AspNetUsers.AccessFailedCount, AspNetUsers.UserName FROM Events INNER JOIN Participants ON Events.RecId = Participants.EventId INNER JOIN AspNetUsers ON Participants.UserId = AspNetUsers.Id WHERE (AspNetUsers.UserName = @UserId)" OnSelecting="CurrentMonthEventsDataSource_Selecting">
        <SelectParameters>
            <asp:Parameter Name="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="UpcommingEventsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT RecId, EventName, Location, OwnerId, Description, MinParticipants, MaxParticipants, StartDateTime, EndDateTime FROM Events WHERE (StartDateTime &gt;= GETDATE()) AND (StartDateTime &lt;= DATEADD(DAY, 60, GETDATE()))"></asp:SqlDataSource>
    <asp:SqlDataSource ID="CalendarEventsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT RecId, EventName, Location, OwnerId, Description, MinParticipants, MaxParticipants, StartDateTime, EndDateTime FROM Events WHERE StartDateTime Like '%'+@FilterDate+'%'">
        <SelectParameters>
            <asp:Parameter Name="FilterDate" />
        </SelectParameters>
    </asp:SqlDataSource>

    <!--<div class="jumbotron">
        <h1>Tyler Events</h1>
        <p class="lead">The easy way to organize an event.</p>
    </div>-->
    <div class="row">
        <div class="container">
            <div class="col-md-7">
                <h2>My created events</h2>
                    <div class="table-responsive">
                        <asp:GridView ID="OwnedEventsGrid" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed" DataSourceID="OwnedEvents" DataKeyNames="RecId,Id">
                            <Columns>
                                <asp:HyperLinkField DataNavigateUrlFields="RecId" DataNavigateUrlFormatString="EventDetail.aspx?eventId={0}" DataTextField="EventName" HeaderText="Event Name" SortExpression="EventName"/>
                                <asp:BoundField DataField="StartDateTime" HeaderText="Start Date and Time" SortExpression="StartDateTime" />
                            </Columns>
                        </asp:GridView>
                    </div>
                <h2>My registered events</h2>
                    <div class="table-responsive">
                        <asp:GridView ID="RegisteredEvents" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed" DataSourceID="RegisteredEventsDataSource" DataKeyNames="RecId,Id">
                            <Columns>
                                <asp:HyperLinkField DataNavigateUrlFields="RecId" DataNavigateUrlFormatString="EventDetail.aspx?eventId={0}" DataTextField="EventName" HeaderText="Event Name" SortExpression="EventName"/>
                                <asp:BoundField DataField="StartDateTime" HeaderText="Start Date and Time" SortExpression="StartDateTime" />
                            </Columns>
                        </asp:GridView>
                    </div>
                <h2>Upcoming Events</h2>
                    <div class="table-responsive">
                        <asp:GridView ID="UpcomingEvents" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed" DataSourceID="UpcommingEventsDataSource" DataKeyNames="RecId">
                            <Columns>
                                <asp:HyperLinkField DataNavigateUrlFields="RecId" DataNavigateUrlFormatString="EventDetail.aspx?eventId={0}" DataTextField="EventName" HeaderText="Event Name" SortExpression="EventName"/>
                                <asp:BoundField DataField="StartDateTime" HeaderText="Start Date and Time" SortExpression="StartDateTime" />
                            </Columns>
                        </asp:GridView>
                    </div>
            </div>
            <div class="col-md-3">
                <asp:Calendar ID="HomePageCalendar" runat="server" OnSelectionChanged="HomePageCalendar_SelectionChanged"></asp:Calendar>
                <asp:Panel ID="CalendarPanel" runat="server" visible="false" >
                    <h3><asp:Label ID="CalendarLabel" runat="server"/></h3>
                    <asp:Label ID="NoEventsTodayLabel" Text="No events for the selected day." runat="server" />
                    <asp:GridView ID="CalendarEvents" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed" DataSourceID="CalendarEventsDataSource" DataKeyNames="RecId">
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="RecId" DataNavigateUrlFormatString="EventDetail.aspx?eventId={0}" DataTextField="EventName" HeaderText="Event Name" SortExpression="EventName"/>
                            <asp:BoundField DataField="StartDateTime" HeaderText="Start Date and Time" SortExpression="StartDateTime" />
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>
