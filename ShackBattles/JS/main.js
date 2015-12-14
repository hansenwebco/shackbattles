function isDate(val) {
    var d = new Date(val);
    return !isNaN(d.valueOf());
}
function showAlert(msg) {
    $("#alert-text").html(msg);
    $("#alert").slideDown();
    $('html, body').animate({ scrollTop: '0px' }, 300)
}
function setMenu(id) {
    $("[id^='menu-']").removeAttr('class', 'active');
    $("#" + id).attr('class', 'active');
}
function manageUserBattle(battleGUID, userKey) {

    //var btn = $("#battle-" + battleGUID);

    var btn = $("input[data-id=" + battleGUID + "]")
    var dj = btn.attr("data-joined");

    var join;
    if (dj == 0)
        join = true
    else
        join = false;

    btn.val("Saving...");

    var json = { 'userKey': userKey, 'battleGUID': battleGUID, 'joinBattle': join };
    $.ajax({
        type: 'POST',
        url: '/api/JoinBattle',
        data: JSON.stringify(json),
        contentType: 'application/json',
        dataType: 'json',
        success: function (data) {
            if (data.success) {
                if (join) {
                    btn.val("Leave");
                    btn.removeClass("btn-primary").addClass("btn-danger");
                    btn.attr("data-joined", 1);
                }
                else {
                    btn.val("Join");
                    btn.removeClass("btn-danger").addClass("btn-primary");
                    btn.attr("data-joined", 0);
                }
            }
        },
        error: function (data) {
            if (!join) {
                btn.val("Leave");
                btn.removeClass("btn-primary").addClass("btn-danger");
                btn.attr("data-joined", 1);
            }
            else {
                btn.val("Join");
                btn.removeClass("btn-danger").addClass("btn-primary");
                btn.attr("data-joined", 0);
            }

            alert("There was an error updating battle.");




        }
    });
}
function formatText(post) {
    post = replaceAll(post, "r{", "<span class='shack-red'>");



    post = replaceAll(post, "g{", "<span class='shack-green'>");
    post = replaceAll(post, "b{", "<span class='shack-blue'>");
    post = replaceAll(post, "y{", "<span class='shack-yellow'>");
    post = replaceAll(post, "e\\[", "<span class='shack-olive'>");
    post = replaceAll(post, "l\\[", "<span class='shack-lime'>");
    post = replaceAll(post, "n\\[", "<span class='shack-orange'>");
    post = replaceAll(post, "p\\[", "<span class='shack-pink'>");
    post = replaceAll(post, "b\\[", "<span class='shack-bold'>");
    post = replaceAll(post, "_\\[", "<span class='shack-underline'>");
    post = replaceAll(post, "u\\[", "<span class='shack-underline'>");
    post = replaceAll(post, "/\\[", "<span class='shack-italics'>");
    post = replaceAll(post, "q\\[", "<span class='shack-quotes'>");
    post = replaceAll(post, "s\\[", "<span class='shack-sample'>");
    post = replaceAll(post, "-\\[", "<span class='shack-strike'>");
    post = replaceAll(post, "o\\[", "<span onclick='unSpoil(this)' class='shack-spoiler'>");
    post = replaceAll(post, "/{{", "<span class='shack-code'>");

    post = replaceAll(post, "}r", "</span>");
    post = replaceAll(post, "}g", "</span>");
    post = replaceAll(post, "}b", "</span>");
    post = replaceAll(post, "}y", "</span>");
    post = replaceAll(post, "\\]e", "</span>");
    post = replaceAll(post, "\\]l", "</span>");
    post = replaceAll(post, "\\]n", "</span>");
    post = replaceAll(post, "\\]p", "</span>");
    post = replaceAll(post, "\\]b", "</span>");
    post = replaceAll(post, "\\]_", "</span>");
    post = replaceAll(post, "\\]u", "</span>");
    post = replaceAll(post, "\\]/", "</span>");
    post = replaceAll(post, "\\]q", "</span>");
    post = replaceAll(post, "\\]s", "</span>");
    post = replaceAll(post, "\\]-", "</span>");
    post = replaceAll(post, "\\]o", "</span>");
    post = replaceAll(post, "}}/", "</span>");

    post = post.replace(/(?:\r\n|\r|\n)/g, '<br/>');

    return post;
}
function replaceAll(str, find, replace) {
    return str.replace(new RegExp(find, 'g'), replace);
}

function unSpoil(elm)
{
    $(elm).removeClass('shack-spoiler');
}

function wrapText(elementID, openTag, closeTag) {
    var textArea = $('#' + elementID);
    var len = textArea.val().length;
    var start = textArea[0].selectionStart;
    var end = textArea[0].selectionEnd;
    var selectedText = textArea.val().substring(start, end);
    var replacement = openTag + selectedText + closeTag;
    textArea.val(textArea.val().substring(0, start) + replacement + textArea.val().substring(end, len));
}