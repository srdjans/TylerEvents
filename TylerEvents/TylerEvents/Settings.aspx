<%@ Page Title="User Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="TylerEvents.Settings" %>
<%@ Reference Control="~/UserSubscribedCategories.ascx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   <%-- <asp:SqlDataSource ID="UserCategoryDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT UserSubscribedCategories.CategoryId FROM UserSubscribedCategories Where UserSubscribedCategories.UserId = 'a14e1f21-5a2c-4d18-98db-6c1fbb938c70'" OnSelecting="UserCategoryDataSource_Selecting">
        <SelectParameters>
            <asp:Parameter Name="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
    <div class="container">
        <h3><%: Title %></h3>
        <br />
        <h4>Preferences</h4>

        <h4>Subscriptions</h4>
        <asp:PlaceHolder runat="server" ID="phUserSubscribedCategories"/>
        <br />
        <h4>Add Subscription</h4>
    </div>
</asp:Content>
