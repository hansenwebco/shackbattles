<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ShackBattles.account.Default" %>

<%@ Register Src="~/Webcontrols/ShackTags.ascx" TagPrefix="uc1" TagName="ShackTags" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script type="text/javascript">
        $(function () {
            setMenu("menu-account");
        });

        function togglePreview(preview) {
            $("[id^=button]").removeClass('selected');

            console.log($("[id^=button]"));
            if (preview) {
                var previewText = $("#<%=TextBoxBio.ClientID%>").val();
                previewText = formatText(previewText);

                $("#<%=TextBoxBio.ClientID%>").hide();
                $("#preview").show();
                $("#button-preview").addClass('selected');
                $("#preview").html(previewText);
            }
            else {
                $("#<%=TextBoxBio.ClientID%>").show();
                $("#preview").hide();
                $("#button-edit").addClass('selected');
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
    <div class="form col-md-9">
        <div class="form-group">
            <label for="<%=TextBoxGamerTag.ClientID %>">Microsoft Gamer Tag:</label>
            <asp:TextBox ID="TextBoxGamerTag" runat="server" CssClass="form-control input-sm"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="<%=TextBoxPSN.ClientID %>">PlayStation Network ID:</label>
            <asp:TextBox ID="TextBoxPSN" runat="server" CssClass="form-control input-sm"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="<%=TextBoxBattleNet.ClientID %>">Battle.net ID:</label>
            <asp:TextBox ID="TextBoxBattleNet" runat="server" CssClass="form-control input-sm"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="<%=TextBoxSteam.ClientID %>">Steam ID:</label>
            <asp:TextBox ID="TextBoxSteam" runat="server" CssClass="form-control input-sm"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="<%=TextBoxOrigin.ClientID %>">Origin ID:</label>
            <asp:TextBox ID="TextBoxOrigin" runat="server" CssClass="form-control input-sm"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="<%=TextBoxBio.ClientID %>">Bio:</label><br />
            <uc1:ShackTags runat="server" ID="UserControlShackTags" />
            <div id="preview" style="height: 250px;" class="form-control input-sm"></div>
            <asp:TextBox TextMode="MultiLine" ID="TextBoxBio" runat="server" Height="250" CssClass="form-control input-sm"></asp:TextBox>
            <div id="button-edit" onclick="togglePreview(false);" class="tab selected">Edit</div>
            <div id="button-preview" onclick="togglePreview(true);" class="tab">Preview</div>
        </div>
        <div class="pull-right">
            <asp:Button OnClick="ButtonSubmit_Click" ID="ButtonSubmit" runat="server" CssClass="btn btn-primary" Text="Save" />
        </div>
    </div>
    <!--
    <div class="col-md-3">
        <h4>Your Created Battles</h4>
        <asp:Repeater ID="RepeaterPreviousBattles" runat="server">
            <HeaderTemplate>
                <ul>
            </HeaderTemplate>
            <ItemTemplate>
                <li><a href="<%=ResolveUrl("~") %>view-battle/<%#Eval("BattleGUID") %>"><%#Eval("Title") %></a></li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
          </div>
        -->

  
</asp:Content>
