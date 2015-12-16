<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ShackBattles.view_battle.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script>
        var userKey = <%=_userKey%>;
        $(function () {
            $("input[data-id]").click(function () {
                manageUserBattle($(this).attr('data-id') ,userKey);
            });

            var format = formatText($("#<%=LiteralBattleDetails.ClientID%>").text());
            $("#<%=LiteralBattleDetails.ClientID%>").html(format);
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContent" runat="server">
    <div class="row">
        <div class="col-md-3 text-center">
            <img class="box-art img-rounded" src="<%=ResolveUrl("~") %>Images/boxart/<%=_boxArt %>" />
            <br />
            <br />
            <% if (_userKey != _creatorKey){  %>
            <input type="button" data-joined="<%=_joined %>" data-id="<%=_battleGUID%>" class="btn <%=_joined == 0 ? "btn-primary" :  "btn-danger"%>" value="<%=_joined == 0 ? "Join" :  "Leave"%>" />
            <% } %>
            <br />
            <br />
            <% if (_userKey == _creatorKey){  %>
            <a href="<%=ResolveUrl("~")%>edit-battle/<%=_battleGUID %>" class="btn btn-default">Edit Your Battle</a>
            <br /><br />
            <asp:Button runat="server" OnClick="DeleteBattle_Click" OnClientClick="return confirm('Are you sure you want to delete your battle?')" ID="DeleteBattle" Text="Delete Your Battle" CssClass="btn btn-danger" />
            <% } %>

            
        </div>
        <div class="col-md-9">
            <h1>
                <asp:Literal ID="LiteralBattleTitle" runat="server"></asp:Literal></h1>
            <h4>
                <asp:Literal ID="LiteralBattleDateTime" runat="server"></asp:Literal>EST</h4>
            <hr />
            <h5>Share Battle: <a class="sharelink" href="#">
                <asp:Literal ID="LiteralBattleLink" runat="server"></asp:Literal></a></h5>
            <hr />
            <p>
                <asp:Label ID="LiteralBattleDetails" runat="server"></asp:Label>
            </p>
            <hr />
            <h2>Enlisted Players</h2>
            <asp:Repeater ID="RepeaterEnlisted" runat="server">
                <ItemTemplate>
                    <a href="<%#_userKey == (int)Eval("UserKey") ? ResolveUrl("~") + "account" : ResolveUrl("~")  + "player/" +  Eval("UserKey") + "/" + ShackBattles.Classes.Helper.CovertStringToSEO(Eval("UserName").ToString())%>" class="btn battle-player btn-sm <%#(int)Eval("CreatorKey") == (int)Eval("UserKey") ? "btn-danger" : "btn-default"%>"><%#Eval("Username") %><%#(int)Eval("CreatorKey") == (int)Eval("UserKey") ? " (owner) " :  ""%></a>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
