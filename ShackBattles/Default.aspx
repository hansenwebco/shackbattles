<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ShackBattles.Default" %>

<%@ Import Namespace="ShackBattles.Classes" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Welcome to ShackBattles</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous" />
    <link href="CSS/login.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="JS/backgrounds.js"></script>
    <script>
        $(function () {
            SetBackground();
        });
        function SetBackground()
        {
            var back = Math.floor(Math.random() * (backgrounds.length-1)) + 1
            console.log(back);
            $("#gameTitle").text(backgrounds[back].gameTitle);
            $("#gameDev").text(backgrounds[back].gameDev);
            $("#gameYear").text(backgrounds[back].gameYear);

            $("body").css('background-image', "url(/images/" + backgrounds[back].img + ")");
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="panel panel-default">
                    <img class="login-logo img-responsive" id="login-logo" style="" src="Images/testlogo.png" />
                    <div class="panel-body">
                        <form runat="server" class="form-horizontal" method="post" action="#" role="login">
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label">Login</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="TextBoxLogin" runat="server" placeholder="" required CssClass="form-control input-lg"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputPassword3" class="col-sm-3 control-label">
                                    Password</label>
                                <div class="col-sm-9">
                                    <asp:TextBox ID="TextBoxPassword" TextMode="Password" runat="server" placeholder="" required CssClass="form-control input-lg"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group last">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <button type="submit" name="go" class="btn btn-sm btn-primary btn-block">Login</button>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <br />
                                <asp:Literal ID="LiteralError" runat="server"></asp:Literal>
                            </div>
                        </form>
                    </div>
                    <div class="panel-footer">
                        Not Registered? <a target="_blank" href="http://www.shacknews.com/">Register here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="hidden-xs" id="gameInfo">
        <div id="gameTitle"></div>
        <div class="gameDetails"><span id="gameDev"></span> - <span id="gameYear"></span></div>
        <a href="javascript:SetBackground();">refresh</a>
    </div>
</body>
</html>
