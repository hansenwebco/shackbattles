<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ShackBattles.view_game.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script>
        var following = <%=_following.ToString().ToLower()%>;
        $(function () {
            setMenu("menu-find-battle");
            SetFollowButton();
            $("[class^='table']").stacktable();
         
            $(function () {
                $("input[data-id]").click(function () {
                    manageUserBattle($(this).attr('data-id') ,<%=_userKey%>);
                });
            });

            $("#followBattle").click(function () {
                followGame(<%=_userKey%>, <%=_gameKey%>);
            });
            function followGame(userKey, gameKey) {
                $("#followBattle").val("Updating...");
                following = !following;
                $.ajax({
                    type: 'POST',
                    url: '/api/FollowBattle',
                    data: JSON.stringify("{ 'userKey':" + userKey + ", 'gameKey': " + gameKey + ", 'follow' : " + following + "}"),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (data) {
                        if (following)
                            $("#followers").text(eval($("#followers").text())+1);
                        else
                            $("#followers").text(eval($("#followers").text())-1);

                        SetFollowButton();
                    },
                    error: function (data) {
                        following = !following;
                        SetFollowButton();
                    }
                });
            }
            function SetFollowButton()
            {
                if (following) 
                    $("#followBattle").val("Unfollow Battles");
                else 
                    $("#followBattle").val("Follow Battles");
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContent" runat="server">
    <div class="row">
        <div class="col-md-3 text-center">
            <img class="box-art img-rounded" src="<%=ResolveUrl("~") %>Images/boxart/<%=_gameImage %>" /><br />
            <br />
            Released:
            <asp:Literal ID="LiteralReleaseDate" runat="server"></asp:Literal><br />
            <span class="label label-info">
                <asp:Literal ID="LiteralGameSystemName" runat="server"></asp:Literal></span><br />
            Followers: <span id="followers"><%=_followCount %></span><br />
            <br />
            <input type="button" id="followBattle" class="btn btn-primary" value="Follow Battle" />
            <br />
            <br />
        </div>
        <div class="col-md-9">
            <h2>
                <asp:Literal ID="LiteralGameName" runat="server"></asp:Literal></h2>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Upcoming Battles</h3>
                </div>
                <div class="panel-body">
                    <asp:Repeater ID="RepeaterUpcomingBattles" runat="server">
                        <HeaderTemplate>
                            <table class="table table-striped col-md-12">
                                <tr>
                                    <th>Title</th>
                                    <th class="text-center">When</th>
                                    <th class="text-center">Manage</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><a href="<%=ResolveUrl("~") %>view-battle/<%#Eval("BattleGUID") %>"><%#Eval("Title") %></a></td>
                                <td class="text-center"><%#ShackBattles.Classes.Helper.StartTimeToWords((DateTime)Eval("BattleDate")) %></td>
                                <td class="text-center">
                                     <input type="button" data-joined="<%#Eval("Joined") %>" data-id="<%#Eval("BattleGUID")%>" class="btn btn-xs <%#(int)Eval("Joined") == 0 ? "btn-primary" :  "btn-danger"%>" value="<%#(int)Eval("Joined") == 0 ? "Join" :  "Leave"%>" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                            
                        </FooterTemplate>
                    </asp:Repeater>
                    <asp:Label runat="server" id="LabelNoBattles" Text="No battles upcoming!"></asp:Label>
                </div>
            </div>
            <asp:Literal ID="LiteralGameDetails" runat="server"></asp:Literal>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
