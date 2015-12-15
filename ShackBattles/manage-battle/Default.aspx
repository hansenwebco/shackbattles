<%@ Page Title="" EnableEventValidation="false" EnableViewState="false" Language="C#" MasterPageFile="~/MasterPages/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ShackBattles.manage_battle.Default" %>

<%@ Register Src="~/Webcontrols/ShackTags.ascx" TagPrefix="uc1" TagName="ShackTags" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/vader/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%=ResolveUrl("~") %>JS/jquery.maskedinput.min.js"></script>
    <script type="text/javascript">
        $(function () {

            setMenu("menu-create-battle");

            $("#<%=TextBoxDate.ClientID%>").datepicker({ showButtonPanel: true, minDate: -0 });
            $("#<%=TextBoxDate.ClientID%>").mask("99/99/9999", { placeholder: "_" });

            // bind system drop down
            var ddlSystems = $("#<%=DropDownListSystem.ClientID%>");
            if ($(ddlSystems).val() > 0) {
                $("#gamelist").slideDown();
                $("#battle-details").slideDown();
                $("#ButtonSave").text("Update Battle");
            }

            $(ddlSystems).change(function () {
                PopulateGamesDropDown();
            });

            var ddlGames = $("#<%=DropDownListGames.ClientID%>");
            $(ddlGames).change(function () {
                if ($(ddlGames).val() > 0)
                    $("#battle-details").slideDown();
                else
                    $("#battle-details").slideUp();
            })


            $("#ButtonSave").click(function () {

                var systemID = $("#<%=DropDownListSystem.ClientID%>").val();
                var gameID = $("#<%=DropDownListGames.ClientID%>").val();
                var dateTime = $("#<%=TextBoxDate.ClientID%>").val() + " " + $("#<%=DropDownListHours.ClientID%>").val();
                var title = $("#<%=TextBoxTitle.ClientID%>").val();
                var details = $("#<%=TextBoxDetails.ClientID%>").val();
                var battleGUID = '<%=_battleGUID%>';

                if (ValidateForm()) {

                    var postdata = { 
                        'GameKey': gameID , 
                        'Title': title , 
                        'Details':  details , 
                        'BattleDate':  dateTime  ,
                        'BattleGUID': battleGUID,
                        'CreatorKey':  <%=((ShackBattles.Classes.UserSession)Session["user"]).userKey%> };

                    // bind save button
                    $.ajax({
                        type: 'POST',
                        url: '/api/SaveBattle',
                        data: JSON.stringify(postdata),
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        success: function (data) {
                            document.location.href = '/view-battle/' + data.BattleGUID;
                        }
                    });
                }

            });
        });
        function ValidateForm() {
            var systemID = $("#<%=DropDownListSystem.ClientID%>").val();
            var gameID = $("#<%=DropDownListGames.ClientID%>").val();
            var dateTime = $("#<%=TextBoxDate.ClientID%>").val() + " " + $("#<%=DropDownListHours.ClientID%>").val();
            var title = $("#<%=TextBoxTitle.ClientID%>").val();
            var details = $("#<%=TextBoxDetails.ClientID%>").val();

            var errorMsg = "";
            if (systemID < 1)
                errorMsg += "You must select a <b>Game System</b>.";
            if (gameID < 1)
                errorMsg += "You must select a <b>Game</b>.<br/>";
            if (!isDate(dateTime))
                errorMsg += "You must enter a valid <b>Starting Time</b> for your battle.<br/>";
            if (title.length < 10)
                errorMsg += "You must enter a <b>Title</b> for your battle.<br/>";
            if (details.length < 10)
                errorMsg += "You must enter <b>Details</b> for your battle.<br/>";

            if (errorMsg.length > 0) {
                showAlert(errorMsg);
                return false;
            }
            else
                return true;

        }
        function PopulateGamesDropDown() {
            var ddlGames = $("#<%=DropDownListGames.ClientID%>");
            $(ddlGames).empty();
            $(ddlGames).append('<option value="0">=== SELECT GAME ===</option>');
            $.ajax({
                dataType: "json",
                url: '/api/GetSystemGames/' + $("#<%=DropDownListSystem.ClientID%>").val(),
                success: function (data) {
                    $.each(data, function (index, value) {
                        $(ddlGames).append('<option value="' + value.GameKey + '">' + value.GameName + '</option>');
                    });
                    var ddlSystems = $("#<%=DropDownListSystem.ClientID%>");
                    if ($(ddlSystems).val() > 0)
                        $("#gamelist").slideDown();
                    else {
                        $("#gamelist").slideUp();
                        $("#battle-details").slideUp();
                    }

                }
            });
        }

        function togglePreview(preview)
        {
            $("[id^=button]").removeClass('selected');

            console.log($("[id^=button]"));
            if (preview)
            {
                var previewText = $("#<%=TextBoxDetails.ClientID%>").val();
                previewText= formatText(previewText);

                $("#<%=TextBoxDetails.ClientID%>").hide();
                $("#preview").show();
                $("#button-preview").addClass('selected');
                $("#preview").html(previewText);
            }
            else{
                $("#<%=TextBoxDetails.ClientID%>").show();
                $("#preview").hide();
                $("#button-edit").addClass('selected');
            }
        }
     
      
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal">
                <div class="form-group">
                    <label for="inputEmail3" class="col-md-2 control-label">System:</label>
                    <div class="col-md-4">
                        <asp:DropDownList ID="DropDownListSystem" runat="server" CssClass="form-control input-sm">
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4 add-message">
                        <br />
                        Don't see a game you want?  <a href="<%=ResolveUrl("~") %>add-game/">Click here.</a>
                    </div>
                </div>
                <div id="gamelist">
                    <div class="form-group">
                        <label for="" class="col-md-2 control-label">Game:</label>
                        <div class="col-md-4">
                            <asp:DropDownList ID="DropDownListGames" runat="server" CssClass="input-sm form-control"></asp:DropDownList>
                        </div>

                    </div>

                </div>
                <div id="battle-details">
                    <div class="form-group">
                        <div class=" form-inline">
                            <label for="" class="col-xs-2 control-label">Date:</label>
                            <div class="col-xs-10">
                                <asp:TextBox ID="TextBoxDate" CssClass="form-control input-sm" runat="server"></asp:TextBox>

                                <asp:DropDownList ID="DropDownListHours" runat="server" CssClass="form-control input-sm">
                                </asp:DropDownList>
                                EST
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-md-2 control-label">Title:</label>
                        <div class="col-md-10">
                            <asp:TextBox ID="TextBoxTitle" MaxLength="100" runat="server" CssClass="input-sm form-control"></asp:TextBox>

                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-md-2 control-label">Details:</label>
                        <div class="col-md-10">
                            <uc1:ShackTags runat="server" ID="UserControlShackTags" />
                            <div id="preview" class="form-control input-sm"></div>
                            <asp:TextBox ID="TextBoxDetails" CssClass="form-control input-sm" runat="server" TextMode="MultiLine" Height="350"></asp:TextBox>
                            <div id="button-edit" onclick="togglePreview(false);" class="tab selected">Edit</div>
                            <div id="button-preview" onclick="togglePreview(true);" class="tab">Preview</div>
                        </div>
                    </div>
                    <asp:Panel ID="PanelShareURL" Visible="false" runat="server">
                        <div class="form-group">
                            <label for="" class="col-md-2 control-label">Share URL:</label>
                            <div class="col-md-10">
                                <asp:TextBox onclick="this.select();" ReadOnly="true" CssClass="form-control input-sm" ID="TextBoxShareURL" Text="" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </asp:Panel>
                    <div class="form-group">
                        <a id="ButtonSave" class="btn btn-success pull-right">Create Battle</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
</asp:Content>
