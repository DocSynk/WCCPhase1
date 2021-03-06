$(function(){init();});

function init() {
    updateAddGroupDropdown();
}

$("#groupUL").delegate('li', 'click', function(e){
    elem = $(this);

    var groupID = elem.attr("data-group-id");
    var userID = elem.attr("data-user-id");

    $.ajax( {
        "dataType": 'json',
        "type": 'POST',
        "url": PAGE.xeh.ajaxRemoveUserFromGroup,
        "data": {"userID":userID, "groupID":groupID},
        "success": function(e) {
            if(e === true){
                elem.remove();
                updateAddGroupDropdown();
            }
        },
        "timeout": 15000,
        "error": function(e) {
            updateAddGroupDropdown();
        }
    });

});

$("#newGroupID").change(function(e){
    elem = $("#newGroupID option:selected");

    var groupID = elem.attr("data-group-id");
    var userID = elem.attr("data-user-id");
    var groupName = elem.html();

    $.ajax( {
        "dataType": 'json',
        "type": 'POST',
        "url": PAGE.xeh.ajaxAddUserToGroup,
        "data": {"userID":userID, "groupID":groupID},
        "success": function(e) {
            if(e === true){
                $("#groupUL").append('<li class="userGroupItem list-group-item" data-user-id="' + userID + '" data-group-id="' + groupID + '" id="group_' + groupID + '">' + groupName + '<i style="float:right;" class="glyphicon glyphicon-remove icon-white"></i></li>');
                $("#newGroupID").val(-1);
                updateAddGroupDropdown();
            }
        },
        "timeout": 15000,
        "error": function(e) {
            $("#newGroupID").val(-1);
            updateAddGroupDropdown();
        }
    });
});

var assignedGroups = {};

function updateAddGroupDropdown () {
    assignedGroups = {};

    $("#groupUL li").each(function (index, elem) {
        var groupID = $(elem).attr("data-group-id");

        assignedGroups[groupID.toString()] = true;
    });

    $(".newGroupOption").each(function (index, elem) {
        $(elem).remove();
    });

    $(PAGE.arAllGroups).each(function (index, elem) {
        if (elem.groupID in assignedGroups) {
            //do nothing
        } else {
            $("#newGroupID").append('<option class="newGroupOption" value="' + elem.groupID + '" data-user-id="' + PAGE.userID + '" data-group-id="' + elem.groupID + '">' + elem.groupName + '</option>');
        }
    });

    $(".newGroupOption").each(function (index, elem) {
        var groupID = $(elem).attr("data-group-id");

        if (groupID in assignedGroups) {
            $(elem).remove();
        }
    });

    if ($(".newGroupOption").length === 0) {
        $("#newGroupID").hide();
    } else {
        $("#newGroupID").show();
    }
}
