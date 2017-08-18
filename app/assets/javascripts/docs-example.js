

$(document).ready(function() {
    //todo
    setup();
});



var examples = {
    "test": {
        "API-title": "test",
        "API-example": "GET services/test, no params required <br> returns { status: 'ok!''}",
        "test-link": "/services/test"
    },
    "users_test": {
        "API-title": "users_test",
        "API-example": "GET users/test, params required <br> returns { success: 'ok' }",
        "test-link": "/users/test"
    },
    "users_show": {
        "API-title": "users_show",
        "API-example": "GET users/show <br><br> params required: <br> 'user_id' <br> This request would return user information.",
        "test-link": "/users/show?user_id=111"
    },
    "users_create": {
        "API-title": "users_create",
        "API-example": "POST users/create <br><br> params required: <br> 'email', 'nick_name', 'password_salted', 'desription'. <br> If not enough params passed thru, it will return an error msg. <br> If success, it will return back a user_id.<br><br> CANNOT test due to it's POST request.",
        "test-link": ""
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
    $(".test-link").attr("href", examples[getParameterByName("req")]["test-link"]);
}
