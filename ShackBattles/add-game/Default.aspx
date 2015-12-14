<%@ Page Title="" EnableViewState="true" Language="C#" MasterPageFile="~/MasterPages/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ShackBattles.add_game.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContent" runat="server">
    <asp:Panel ID="PanelMain" runat="server">
    <div class="row">
        <div class="col-md-8 col-md-offset-1">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title">Hey You!  READ THIS!</h3>
                </div>
                <div class="panel-body">
                    This tool will import games from TheGamesDb.net.  Please check carefully before adding a game to make sure we don't already
            have it in the database.  Only YOU can prevent duplicate game entries!
                </div>
            </div>
        </div>
    </div>
    <br />
    
        <asp:Panel ID="PanelError" Visible="false" runat="server">
            <div class="row">
                <div class="col-md-8 col-md-offset-1">
                    <div class="panel panel-danger">
                        <div class="panel-heading">
                            <h3 class="panel-title">Error!</h3>
                        </div>
                        <div class="panel-body">
                            <asp:Literal ID="LiteralError" runat="server"></asp:Literal>
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <br />
        </asp:Panel>

        <div class="row">
            <div class="form-horizontal">
                <div class="form-group">
                    <label for="inputEmail3" class="col-md-2 control-label">System:</label>
                    <div class="col-md-4">
                        <asp:DropDownList ID="DropDownListSystem" runat="server" CssClass="form-control input-sm">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-md-2 control-label">Search:</label>
                    <div class="col-md-4">
                        <asp:TextBox ID="TextBoxSearch" runat="server" CssClass="form-control input-sm">
                        </asp:TextBox>
                    </div>
                    <div class="col-md-1">
                        <asp:Button ID="ButtonSearch" OnClick="ButtonSearch_Click" runat="server" Text="Search" CssClass="btn btn-sm btn-primary" />
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 col-md-offset-1">
                <asp:Repeater ID="RepeaterResults" runat="server">
                    <HeaderTemplate>
                        <div>
                            <h3>Search Results</h3>
                        </div>
                        <table class="table table-bordered  table-striped">
                            <tr>
                                <th>Title</th>
                                <th class="text-center">Release Date</th>
                                <th class="text-center">Option</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%#Eval("Title") %></td>
                            <td class="text-center"><%#Eval("ReleaseDate") %></td>
                            <td class="text-center">
                                <asp:Button runat="server" OnClientClick="return confirm('Many games have similar titles, make sure you are adding the one that makes the most sense.\n\nAre you sure you want to add this game?')" CommandArgument='<%#Eval("id") %>' OnCommand="AddGame_Command" Text="Add Game" CssClass="btn btn-xs btn-primary" /></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="PanelDone" Visible="false" runat="server">
        <div class="row">
            <div class="col-md-8 col-md-offset-1">
                Game has been added to the system.
            </div>
        </div>

    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
