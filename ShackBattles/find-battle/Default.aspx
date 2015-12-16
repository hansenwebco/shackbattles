<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ShackBattles.find_battle.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script>
        $(function () {
            setMenu("menu-find-battle");
            $("[class^='table']").stacktable();
        });
       var userKey = <%=_userKey%>;
        $(function () {
            $("input[data-id]").click(function () {
                manageUserBattle($(this).attr('data-id') ,userKey);
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Upcoming Shack Battles</h3>
                </div>
                <div class="panel-body">
                    <asp:Repeater ID="RepeaterUpcomingBattles" runat="server">
                        <HeaderTemplate>
                            <table class="table table-striped col-md-12">
                                <tr>
                                    <th>Title</th>
                                    <th>Game Name</th>
                                    <th class="text-center">When</th>
                                    <th class="text-center">Owner</th>
                                    <th class="text-center">Manage</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><a href="<%=ResolveUrl("~") %>view-battle/<%#Eval("BattleGUID") %>/"><%#Eval("Title") %></a></td>
                                <td><a href="<%=ResolveUrl("~") %>game/<%#Eval("GameKey")%>/<%#Eval("GameSystemName").ToString().ToLower() %>/<%#ShackBattles.Classes.Helper.CovertStringToSEO(Eval("GameName").ToString()) %>/"><%#Eval("GameName") %></a></td>
                                <td class="text-center"><%#ShackBattles.Classes.Helper.StartTimeToWords((DateTime)Eval("BattleDate")) %></td>
                                <td class="text-center">
                                    <a href="<%#_userKey == (int)Eval("CreatorKey") ? ResolveUrl("~") + "account" : ResolveUrl("~")  + "player/" +  Eval("CreatorKey") + "/" + ShackBattles.Classes.Helper.CovertStringToSEO(Eval("CreatorName").ToString())%>"><%#Eval("CreatorName") %></a>
                                    <asp:HyperLink NavigateUrl='<%# Eval("BattleGUID","~/edit-battle/{0}") %>' type="button" CssClass="btn btn-xs btn-primary" Text="Edit" runat="server" Visible='<%#(int)Eval("CreatorKey") == _userKey %>' /></td>
                                <td class="text-center">
                                    <input type="button" data-joined="<%#Eval("Joined") %>" data-id="<%#Eval("BattleGUID")%>" class="btn btn-xs <%#(int)Eval("Joined") == 0 ? "btn-primary" :  "btn-danger"%>" value="<%#(int)Eval("Joined") == 0 ? "Join" :  "Leave"%>" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Literal runat="server" Visible="false" ID="LabelUpcomingBattlesYouFollow"><tr><td colspan="5">You probably need to <a href="/find-battle/">follow</a> some games!</td></tr></asp:Literal>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
    <asp:Repeater ID="RepeaterGames" runat="server">
        <ItemTemplate>
            <div class="col-sm-6 col-md-3 find-game-box text-center">
                <a href="<%=ResolveUrl("~") %>game/<%#Eval("Game.GameKey") %>/<%#ShackBattles.Classes.Helper.CovertStringToSEO((string)Eval("GameSystemName")) %>/<%#ShackBattles.Classes.Helper.CovertStringToSEO((string)Eval("Game.GameName")) %>/">
                    <img class="find-game-image img-rounded" src="../Images/boxart/<%#Eval("Game.CoverImage") %>" /></a><br />
                <%#Eval("Game.GameName") %><br />
                <span class="label label-info"><%#Eval("GameSystemName") %></span>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
