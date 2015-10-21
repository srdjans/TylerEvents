<%@ Page Title="Event Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventDetail.aspx.cs" Inherits="TylerEvents.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>
    <div class="col-md-8">
      <h3>
          <asp:Label ID="EventNameLabel" runat="server" ></asp:Label>
      </h3>
        <h4>
            <asp:Label ID="DateTimeLabel" runat="server"></asp:Label>
            <asp:Label ID="LocationLabel" runat="server"></asp:Label>
        </h4>
        <div>
            <asp:Button ID="JoinEvent" runat="server" Text="Join Event" CssClass="btn btn-lg btn-primary" OnClick="JoinEvent_Click"/>
            <asp:Panel ID="DescriptionPanel" runat="server" Height="450px">
                <h5 ID="Description">
                    <asp:Label ID="DescriptionLabel" runat="server"></asp:Label></h5>
            </asp:Panel>
        </div>
        <div>
            <asp:Panel ID="ChatPanel" runat="server">

            </asp:Panel>
        </div>
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
