

$(document).ready(function() {
    //todo
    setup();
});



var examples = {
    "test": {
        "API-title": "test",
        "API-example": "GET services/test, return {\"status\":\"ok!\"}"
    }
}


function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}



var setup = function() {
    $(".API-title").html(examples[getParameterByName("req")]["API-title"]);
    $(".API-example").html(examples[getParameterByName("req")]["API-example"]);
}
