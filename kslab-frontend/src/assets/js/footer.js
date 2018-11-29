$(function() {
    $("#footer").load("footer.html", function () {
        var link = "<link rel='stylesheet' href='./css/footer.css'>";
        $("head").append(link);
    })
})