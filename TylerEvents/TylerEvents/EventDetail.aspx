<%@ Page Title="Event Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventDetail.aspx.cs" Inherits="TylerEvents.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <h2><%: Title %></h2>
    <div class="col-md-8">
      <h3></h3>
    </div>
    <div class="col-md-4">
        <div class="progress">
            <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style= "width:100%">
                <!--need a placeholder for the progress bar-->

            </div>
        </div>
        <asp:Panel ID="Panel1" runat="server"></asp:Panel>
    </div>
    
</asp:Content>
