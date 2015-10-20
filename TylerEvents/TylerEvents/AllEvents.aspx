﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AllEvents.aspx.cs" Inherits="TylerEvents.AllEvents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <div class="container">
        <div class="row">
            <div class="col-md-2 sidebar">
                <asp:Panel ID="Sidebar" runat="server" BackColor="#f5f5f5">
                    
                </asp:Panel>
            </div>
            <div class="col-sm-8 blog-main">
                <h3>All Events</h3>
                <div class="table-responsive">
                    <asp:GridView ID="AllEventsGrid" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed">
                        <Columns>
                            <asp:BoundField DataField="EventName" HeaderText="EventName" SortExpression="EventName" />
                            <asp:BoundField DataField="StartDateTime" HeaderText="StartDateTime" SortExpression="StartDateTime" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>