<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AllEvents.aspx.cs" Inherits="TylerEvents.AllEvents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="EventsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT RecId, EventName, Location, OwnerId, Description, MinParticipants, MaxParticipants, StartDateTime, EndDateTime FROM Events"></asp:SqlDataSource>
    <asp:SqlDataSource ID="EventsDataSourceFilterByDate" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT RecId, EventName, Location, OwnerId, Description, MinParticipants, MaxParticipants, StartDateTime, EndDateTime FROM Events WHERE StartDateTime Like @FilterDate+'%'">
        <SelectParameters>
            <asp:Parameter Name="FilterDate" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="EventsDataSourceFilterByTitle" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT RecId, EventName, Location, OwnerId, Description, MinParticipants, MaxParticipants, StartDateTime, EndDateTime FROM Events WHERE EventName Like '%'+@FilterTitle+'%'">
        <SelectParameters>
            <asp:Parameter Name="FilterTitle" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="row">
        <div class="container">
            <div class="col-md-2 sidebar" style="background-color:#f5f5f5; border-radius:10px; padding:15px">
                <label>Filter by Start Date</label>
                <div class="input-group">
                    <div class="input-daterange">
                        <asp:TextBox ID="SearchDate" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <span class = "input-group-btn">
                        <button runat="server" class = "btn btn-default" type = "button" onserverclick="DateSearchButton_Clicked"><i class="glyphicon glyphicon-search"></i></button>
                    </span>
                </div>
                <br />
                <label>Filter by Title</label>
                <div class="input-group">
                    <asp:TextBox ID="SearchTitle" runat="server" CssClass="form-control"></asp:TextBox>
                    <span class = "input-group-btn">
                        <button runat="server" class = "btn btn-default" type = "button" onserverclick="TitleSearchButton_Clicked"><i class="glyphicon glyphicon-search"></i></button>
                    </span>
                </div>
                <br />
            </div>
            <div class="col-sm-8 blog-main">
                <h3>All Events</h3>
                <div class="table-responsive">
                    <asp:GridView ID="AllEventsGrid" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed" DataSourceID="EventsDataSource" DataKeyNames="RecId" OnPageIndexChanging="AllEventsGrid_PageIndexChanging">
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="RecId" DataNavigateUrlFormatString="EventDetail.aspx?eventId={0}" DataTextField="EventName" HeaderText="Event Name" SortExpression="EventName"/>
                            <asp:BoundField DataField="StartDateTime" HeaderText="Start Date and Time" SortExpression="StartDateTime" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
