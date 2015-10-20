﻿<%@ Page Title="My Events" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyEvents.aspx.cs" Inherits="TylerEvents._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!--<div class="jumbotron">
        <h1>Tyler Events</h1>
        <p class="lead">The easy way to organize an event.</p>
    </div>-->
    <div class="row">
        <div class="col-md-2">
            <h2>Space</h2>
        </div>
        <div class="col-md-7">
            <h2>Events this month</h2>
            <table class="table">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Event name</th>
                                    <!--Add a link for more details
                                        <a href="#" class="btn btn-info" role="button>More</a>-->
                                </tr>
                            </thead>
                        </table>
                       <h2>Upcoming Events</h2>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Event name</th>
                                    <!--Add a link for more details
                                        <a href="#" class="btn btn-info" role="button>More</a>-->
                                </tr>
                            </thead>
                        </table>
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