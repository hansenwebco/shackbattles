<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ShackBattles.Home.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script>
        var userKey = <%=_userKey%>;
        $(function () {
            $("input[data-id]").click(function () {
                manageUserBattle($(this).attr('data-id') ,userKey);
            });

            $("[class^='table']").stacktable();

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContent" runat="server">
    <br />
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-warning">
                <div class="panel-heading">
                    <h3 class="panel-title">ShackBattles - Welcome</h3>
                </div>
                <div class="panel-body">
                    Welcome to ShackBattl.es!  The site is new so if you have suggestions or find any bugs please report them using the
                    "Leave feedback" tab on the right. 
                </div>
            </div>

            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Upcoming Battles For Games You Follow</h3>
                </div>
                <div class="panel-body">
                    <asp:Repeater ID="RepeaterUpcomingBattlesYouFollow" runat="server">
                        <HeaderTemplate>
                            <table id="tblUpcomingBattlesYouFollow" class="table table-striped col-md-12">
                                <tr>
                                    <th>Title</th>
                                    <th>Game </th>
                                    <th class="text-center">When</th>
                                    <th class="text-center">Owner</th>
                                    <th class="text-center">Players</th>
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
                                <td class="text-center"><%#Eval("Registered") %></td>
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
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Battles You're Registered For</h3>
                </div>
                <div class="panel-body">
                    <div class="table">
                        <asp:Repeater ID="RepeaterUserRegisteredBattles" runat="server">
                            <HeaderTemplate>
                                <table id="tblUserRegisteredBattles" class="table table-striped col-md-12">
                                    <tr>
                                        <th>Title</th>
                                        <th>Game</th>
                                        <th class="text-center">When</th>
                                        <th class="text-center">Owner</th>
                                        <th class="text-center">Players</th>
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
                                        <asp:HyperLink NavigateUrl='<%# Eval("BattleGUID","~/edit-battle/{0}") %>' type="button" CssClass="btn btn-xs btn-primary" Text="Edit" runat="server" Visible='<%#(int)Eval("CreatorKey") == _userKey %>' />
                                    </td>
                                    <td class="text-center"><%#Eval("Registered") %></td>
                                    <td class="text-center">
                                        <input type="button" data-joined="<%#Eval("Joined") %>" data-id="<%#Eval("BattleGUID")%>" class="btn btn-xs <%#(int)Eval("Joined") == 0 ? "btn-primary" :  "btn-danger"%>" value="<%#(int)Eval("Joined") == 0 ? "Join" :  "Leave"%>" /></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Literal runat="server" Visible="false" ID="LabelRegisteredBattles"><tr><td colspan="5">Go and <a href="/find-battle/">find</a> some battles!</td></tr></asp:Literal>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Games You Follow</h3>
                </div>
                <asp:Repeater ID="RepeaterFollowedGames" runat="server">
                    <HeaderTemplate>
                        <div class="panel-body">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <a href="<%=ResolveUrl("~") %>game/<%#Eval("Game.GameKey") %>/<%#(ShackBattles.Classes.Helper.CovertStringToSEO(Eval("GameSystemName").ToString())) %>/<%#(ShackBattles.Classes.Helper.CovertStringToSEO(Eval("Game.GameName").ToString())) %>/"><%#Eval("Game.GameName") %></a> (<%#Eval("GameSystemName") %>)<br />
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label runat="server" Visible="false" ID="LabelEmptyFollowing">None yet!</asp:Label>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
