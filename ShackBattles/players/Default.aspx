<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ShackBattles.players.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">

    <script>
        $(function () {
           
            var bio = $("#bio").text();
            if (bio != null && bio.length > 0) {
                $("#bio").html(formatText(bio));
            }
            else {
                $("#bio").html('No profile entered.');
            }
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
    
    <h1>Player Profile for <asp:Literal ID="LiteralProfileName" runat="server"></asp:Literal></h1>
    <br />
    <table class="table table-bordered table-striped">
        <tr>
            <td width="50%">Shack Name:</td>
            <td><asp:Literal ID="LiteralShackName" runat="server"></asp:Literal></td>
        </tr>
        <tr>
            <td>Member Since:</td>
            <td><asp:Literal ID="LiteralMemberSince" runat="server"></asp:Literal></td>
        </tr>
        <tr>
            <td>Microsoft Gamer Tag:</td>
            <td><asp:Literal ID="LiteralGamerTag" runat="server"></asp:Literal></td>
        </tr>
        <tr>
            <td>Playstation Network ID:</td>
            <td><asp:Literal ID="LiteralPSNID" runat="server"></asp:Literal></td>
        </tr>
        <tr>
            <td>Battle.net:</td>
            <td><asp:Literal ID="LiteralBattleNet" runat="server"></asp:Literal></td>
        </tr>
        <tr>
            <td>Steam:</td>
            <td><asp:Literal ID="LiteralSteam" runat="server"></asp:Literal></td>
        </tr>
        <tr>
            <td>Origin:</td>
            <td><asp:Literal ID="LiteralOrigin" runat="server"></asp:Literal></td>
        </tr>
        <tr>
            <td colspan="2">
                <br />
                <b>Profile/Bio:</b>
                <hr />
               <div id="bio"><asp:Literal ID="LabelBio" runat="server"></asp:Literal></div>
                <br/>
            </td>

        </tr>
       

    </table>


</asp:Content>
