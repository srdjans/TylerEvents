<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserSubscribedCategories.ascx.cs" Inherits="TylerEvents.UserSubscribedCategories" %>
<div class="container">
    <div class="row">
        <div class='col-sm-3'>
            <%= this.CategoryName %>
        </div>
        <div class='col-sm-3'>
            <asp:Button ID="RemoveCategory" runat="server" Text="Remove" CssClass="btn btn-lg btn-primary" OnClick="RemoveCategory_Clicked"/>
        </div>
    </div>
</div>