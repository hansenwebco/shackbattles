<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ShackTags.ascx.cs" Inherits="ShackBattles.Webcontrols.ShackTags" %>

<div data-open="b[" data-close="]b" class="shack-bold tag">b</div>
<div data-open="_[" data-close="]_" class="shack-underline tag">u</div>
<div data-open="/[" data-close="]/" class="shack-italics tag">i</div>
<div data-open="r{" data-close="}r" class="shack-red tag">red</div>
<div data-open="g{" data-close="}g" class="shack-green tag">green</div>
<div data-open="b{" data-close="}b" class="shack-blue tag">blue</div>
<div data-open="y{" data-close="}y" class="shack-yellow tag">yelow</div>
<div data-open="e[" data-close="]e" class="shack-olive tag">olive</div>
<div data-open="l[" data-close="]l" class="shack-lime tag">lime</div>
<div data-open="n[" data-close="]n" class="shack-orange tag">orange</div>
<div data-open="p[" data-close="]p" class="shack-pink tag">pink</div>
<div data-open="q[" data-close="]q" class="shack-quote tag">quote</div>
<div data-open="s[" data-close="]s" class="shack-italics tag">sample</div>
<div data-open="_[" data-close="]_" class="shack-strike tag">strike</div>
<div data-open="o[" data-close="]o" class="tag">spoil</div>
<div data-open="/{{" data-close="}}/" class="tag">code</div>

<script type="text/javascript">
    $(function () {
        $(".tag").click(function () {
            var openTag = $(this).attr("data-open");
            var closeTag = $(this).attr("data-close");
            var id = '<%=TargetControlID%>';

            wrapText(id, openTag, closeTag);
        });
    });
</script>
