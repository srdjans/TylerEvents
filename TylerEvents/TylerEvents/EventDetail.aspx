﻿<%@ Page Title="Event Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventDetail.aspx.cs" Inherits="TylerEvents.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="ParticipantsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT AspNetUsers.UserName FROM AspNetUsers INNER JOIN Participants ON AspNetUsers.Id = Participants.UserId WHERE (Participants.EventId = @EventId)">
        <SelectParameters>
            <asp:Parameter Name="EventId" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="container">
    <div class="col-md-8">
        <h3><%: Title   %>
        </h3>
        <label>Event Title</label>
        <asp:TextBox ID="EventTitle" runat="server" placeholder="Event Title" CssClass="form-control" Enabled="false"></asp:TextBox>
        <asp:RequiredFieldValidator ID="EventTitleRequired" runat="server" ErrorMessage="Event title is required!!" ForeColor="Red" ControlToValidate="EventTitle"></asp:RequiredFieldValidator>
        <br />
        <label>Event Owner</label>
        <asp:TextBox ID="EventOwner" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
        <br />
        <label>Location</label>
        <asp:TextBox ID="EventLocation" runat="server" placeholder="Location" CssClass="form-control" Enabled="false"></asp:TextBox>
        <asp:RequiredFieldValidator ID="LocationRequired" runat="server" ErrorMessage="Location is required!!" ForeColor="Red" ControlToValidate="EventLocation"></asp:RequiredFieldValidator>
        <br />
        <div class="row">
            <div class='col-sm-4'>
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
            <div class='col-sm-4'>
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
                <asp:RegularExpressionValidator display="Dynamic" ID="MinParticipantsValidator" runat="server" ErrorMessage="Please enter a valid number!!" ForeColor="Red" ControlToValidate="MaxParticipants" ValidationExpression="[-+]?\d+"></asp:RegularExpressionValidator>
                <asp:CompareValidator id="cvMinParticipants" runat="server" ForeColor="Red"
                     ControlToCompare="MaxParticipants" cultureinvariantvalues="true" 
                     display="Dynamic" enableclientscript="true"  
                     ControlToValidate="MinParticipants" 
                     ErrorMessage="Must be lower than maximum!!"
                     type="Integer" setfocusonerror="true" Operator="LessThanEqual"
                     text="Must be lower than maximum!!"></asp:CompareValidator>
            </div>
            <div class='col-sm-4'>
                <label>Maximum Participants</label>
                <asp:TextBox ID="MaxParticipants" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                <asp:RegularExpressionValidator display="Dynamic" ID="MaxParticipantsValidator" runat="server" ErrorMessage="Please enter a valid number!!" ForeColor="Red" ControlToValidate="MinParticipants" ValidationExpression="[-+]?\d+"></asp:RegularExpressionValidator>
                <asp:CompareValidator id="cvtxtMaxParticipants" runat="server" ForeColor="Red"
                     ControlToCompare="MinParticipants" cultureinvariantvalues="true" 
                     display="Dynamic" enableclientscript="true"  
                     ControlToValidate="MaxParticipants" 
                     ErrorMessage="Must be greater than minimum!!"
                     type="Integer" setfocusonerror="true" Operator="GreaterThanEqual" 
                     text="Must be greater than minimum!!"></asp:CompareValidator>
            </div>
        </div>
        <br />
        <asp:Button ID="JoinEvent" runat="server" Text="Join Event" CssClass="btn btn-lg btn-primary" OnClick="JoinEvent_Click"/>
        <asp:Button ID="LeaveEvent" runat="server" Text="Leave Event" CssClass="btn btn-lg btn-primary" OnClick="LeaveEvent_Click" Visible="false"/>
        <asp:Button ID="SaveEvent" Visible="false" runat="server" Text="Save Event" CssClass="btn btn-lg btn-primary" OnClick="SaveEvent_Click"/>
        <asp:Button ID="EditEvent" runat="server" Text="Edit Event" CssClass="btn btn-lg btn-primary" OnClick="EditButton_ServerClick"/>
        <asp:Button ID="DeleteEvent" runat="server" Text="Delete Event" CssClass="btn btn-lg btn-primary" OnClick="DeleteEvent_Click"/>
        <br />
        <br />
        <div class="well" style="background-color:white">
            <h4>Discussion Panel</h4>
            <div class="coontainer">
        <asp:Panel ID="ChatPanel" runat="server">
            <div class="container">
            <asp:Repeater ID="rptComments" runat="server">
                <ItemTemplate>
                    <div class="row">
                    <div class="well">
                        <div class="col-xs-7">
                            <asp:Label ID="UserName" runat="server" Text='<%# Eval("UserName")%>' Font-Bold="true"></asp:Label>
                            &nbsp&nbsp<asp:Label ID="commentDateTime" runat="server" Text='<%# Eval("commentDateTime")%>' Font-Size="X-Small" Forecolor="DarkGray"></asp:Label>
                        </div>
                        <div class="col-xs-7">
                            &nbsp&nbsp&nbsp&nbsp&nbsp<asp:Label ID="lblCommentBody" runat="server" Text='<%# Eval("CommentBody") %>' Font-Italic="true"></asp:Label>
                        </div>
                        <hr />
                    </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            </div>
            <div class="well">
 
                <h4>Join the discussion...</h4>
 
                <div role="form" class="clearfix">
 
                    <div class="col-md-12 form-group">
                        <label class="sr-only" for="comment">Comment</label>
                        <asp:TextBox ID="txtCommentBody" runat="server" CssClass="form-control" TextMode="multiline" Rows="6" placeholder="Comment"/>
                    </div>
 
                    <div class="col-md-12 form-group text-right">
                        <asp:Button ID="btnAdd" runat="server" OnClick="AddComment" Text="Submit" CssClass="btn btn-primary" />
                    </div>
                </div>                   
            </div>
        </asp:Panel>
    </div>
    </div>
    </div>
    <div class="col-md-4" style="background-color:whitesmoke; border-radius:10px; padding:15px">
        <label>Participants required</label>
        <asp:panel runat="server" Id="progressMin" Visible="false">
            <div class="progress">
                <div runat="server" Id="ProgressBarReachMin" class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
            </div>
        </asp:panel>
        <asp:panel runat="server" Id="progressMinFull" Visible="false">
            <div class="progress">
                <div runat="server" Id="ProgressBarReachMinFull" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
            </div>
        </asp:panel>
        <label>Event participant capacity</label>
        <asp:panel runat="server" Id="progressMax" Visible="false">
            <div class="progress">
                <div runat="server" Id="ProgressBarReachMax" class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
            </div>
        </asp:panel>
        <asp:panel runat="server" Id="progressMaxFull" Visible="false">
            <div class="progress">
                <div runat="server" Id="ProgressBarReachMaxFull" class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
            </div>
        </asp:panel>
        <asp:Panel ID="AttendeesPanel" runat="server">
            <asp:GridView ID="AttendeesList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed" DataSourceID="ParticipantsDataSource" DataKeyNames="UserName">
                <Columns>
                    <asp:BoundField DataField="UserName" HeaderText="Participants" SortExpression="UserName" />
                </Columns>
            </asp:GridView>
        </asp:Panel>
    </div>
    </div>
    
</asp:Content>
